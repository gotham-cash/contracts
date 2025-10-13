Official GothamCash contracts

Gotham Cash mixers were built using simple and secured solidity functions. Encryption is generated off-chain in a collision-resistant manner, using a combination of SHA256 and Keccak256. We do not use ZKSNARK/STARK nor MerkleTree configuration, but the multiple-layers encryption combined to a strong anonymity set (high amount of deposits) still makes it a good privacy tool for end-users.

Security features of the contracts:

    Variables are hardcoded (cannot be changed)
    Deposits/withdrawals cannot be paused or cancelled by a third-party
    The contracts cannot self-destruct, and cannot be called via a delegatecall.
    The contracts are not deployed behind a proxy, so they are not immutable and not upgradeable.
    The funds cannot be withdrawn without a valid note: if the note is lost, the associated funds are lost forever.
    The contract has been secured against frontrunning, no third-party can steal your funds during withdrawal.
    There is no expiration on deposits. Your deposit can lay in the contract as long as you want.
    All the contracts are public and verified on the blockchains, ensuring transparency and security.

The protocol takes a 1% mixing fee (on withdrawals only).

The full source code of GothamCash contracts is available in the contracts files. You will also find the official deployments on BSC testnet/mainnet (more chains will be added, but the MVP is deployed on BSC):
BSC Mainnet
BNB

    0.01 BNB testpool:
    0.1 BNB pool:
    1 BNB pool:
    10 BNB pool:
    100 BNB pool:

USDC

    1 USDC testpool:
    10 USDC pool:
    100 USDC pool:
    1000 USDC pool:
    10000 USDC pool:

BSC Testnet
BNB

    0.01 BNB testpool:
    0.1 BNB pool:
    1 BNB pool:
    10 BNB pool:
    100 BNB pool:

USDC

    1 USDC testpool:
    10 USDC pool:
    100 USDC pool:
    1000 USDC pool:
    10000 USDC pool:
