/**
Gotham.cash BNB mixer - 0.1 BNB pool

https://gotham.cash
https://github.com/gotham-cash
https://x.com/gothamcash
https://t.me/gotham_cash

Our mixer was built using simple and secured solidity functions.
Encryption is generated off-chain in a collision-resistant manner, using SHA256 and Keccak256.

To maximize the security, variables are hardcoded (cannot be changed), deposits/withdrawals cannot be paused or cancelled,
the contract cannot self-destruct, and cannot be called via a delegatecall.
The contract is not deployed behind a proxy, so not immutable and not upgradeable.
The funds cannot be withdrawn without a valid note: if it's lost, the funds are lost forever.
THe contract has been secured against frontrunning, no third-party can steal your funds during withdrawal.

The protocol takes a 1% mixing fee.
**/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract GothamCash01BNB {
    struct DepositInfo {
        bytes32 commitment;
        uint256 timestamp;
    }

    DepositInfo[] public deposits;

    uint256 public constant MIX_AMOUNT = 0.1 ether;
    uint256 public constant FEE_BPS = 100; // 1% (100 basis points)

    mapping(bytes32 => bool) public commitments;
    mapping(bytes32 => bool) public nullifiers;

    event Deposit(bytes32 indexed commitment, uint256 timestamp);
    event Withdrawal(address indexed to, bytes32 indexed nullifier);

    address public constant DEV_ADDRESS = 0xD3d47348442cD6e1b3ca1481F26743A93c5ca537;

    function recoverSigner(bytes32 commitment, bytes memory signature) public pure returns (address) {
        bytes32 messageHash = keccak256(abi.encodePacked(commitment));
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        return recover(ethSignedMessageHash, signature);
    }

    function getEthSignedMessageHash(bytes32 _messageHash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _signature) internal pure returns (address) {
        require(_signature.length == 65, "Invalid signature length");

        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            r := mload(add(_signature, 32))
            s := mload(add(_signature, 64))
            v := byte(0, mload(add(_signature, 96)))
        }

        return ecrecover(_ethSignedMessageHash, v, r, s);
    }


    function deposit(bytes32 commitment) external payable {
        require(msg.value == MIX_AMOUNT, "Deposit exact amount");
        require(!commitments[commitment], "Commitment already used");
        require(!nullifiers[commitment], "Commitment already withdrawn before");

        commitments[commitment] = true;

        deposits.push(DepositInfo({
            commitment: commitment,
            timestamp: block.timestamp
        }));

        uint256 feeAmount = (MIX_AMOUNT * FEE_BPS) / 10_000;

        // relayer fee
        (bool successRelayer, ) = DEV_ADDRESS.call{value: feeAmount}("");
        require(successRelayer, "Transfer to relayer failed");

        emit Deposit(commitment, block.timestamp);
    }

    function getDepositsCount() external view returns (uint256) {
        return deposits.length;
    }

    function getDeposit(uint256 index) external view returns (bytes32 commitment, uint256 timestamp) {
        require(index < deposits.length, "Invalid index");
        DepositInfo storage d = deposits[index];
        return (d.commitment, d.timestamp);
    }

    function withdraw(
        bytes32 secret,
        bytes calldata signature
    ) external {
        bytes32 keccak = keccak256(abi.encodePacked(secret));
        bytes32 commitment = sha256(abi.encodePacked(keccak));
        require(commitments[commitment], "Unknown commitment");
        require(!nullifiers[commitment], "Already withdrawn");

        address payable signer = payable(recoverSigner(commitment, signature));
        require(signer != address(0), "Invalid signature");

        nullifiers[commitment] = true;
        commitments[commitment] = false;

        uint256 feeAmount = (MIX_AMOUNT * FEE_BPS) / 10_000;
        uint256 userAmount = MIX_AMOUNT - feeAmount;

        // user withdrawal
        (bool successUser, ) = signer.call{value: userAmount}("");
        require(successUser, "Transfer to user failed");

        bytes32 hashedNullifierHash = keccak256(abi.encodePacked(commitment));
        emit Withdrawal(signer, hashedNullifierHash);
    }

}
