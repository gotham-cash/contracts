# Official GothamCash contracts

Gotham Cash mixers were built using simple and secured solidity functions.
Encryption is generated off-chain in a collision-resistant manner, using a combination of SHA256 and Keccak256. We do not use ZKSNARK/STARK nor MerkleTree configuration, but the multiple-layers encryption combined to a strong anonymity set (high amount of deposits) still makes it a good privacy tool for end-users.

Security features of the contracts:
- Variables are hardcoded (cannot be changed)
- Deposits/withdrawals cannot be paused or cancelled by a third-party
- The contracts cannot self-destruct, and cannot be called via a delegatecall.
- The contracts are not deployed behind a proxy, so they are not immutable and not upgradeable.
- The funds cannot be withdrawn without a valid note: if the note is lost, the associated funds are lost forever.
- The contract has been secured against frontrunning, no third-party can steal your funds during withdrawal.
- There is no expiration on deposits. Your deposit can lay in the contract as long as you want.
- All the contracts are public and verified on the blockchains, ensuring transparency and security.

The protocol takes a 1% mixing fee.

The full source code of GothamCash contracts is available in the contracts files. You will also find the official deployments on BSC testnet/mainnet (more chains will be added, but the MVP is deployed on BSC):

## BSC Mainnet
### BNB

    0.01 BNB testpool: 0xE75eB24177CeabAfA957ECd117066ed71C500b44
    0.1 BNB pool: 0x53830CC903C4bCeF34d94CEFCbbc18341d90EcC6
    1 BNB pool: 0xb9757850Ab6F8c39B55752790ABF77Ed5faD463d
    10 BNB pool: 0x26494d081c33019965effBfeF3BD5B963e635B09
    100 BNB pool: 0x39E84646FC3653b255568e11B44F8e80eda5043D

### USDC

    1 USDC testpool: 0x5fCeC66b63Cc8e9d38E8183fad396656bb687B00
    10 USDC pool: 0x7e95a6b17d9F84E59a703C7e4ECD3ab1b466e61F
    100 USDC pool: 0x567703b577C4f7aa4cC9680d968Ca22c1706f2b0
    1000 USDC pool: 0x55B1B469a993bd5D7F50B14b78F83bd275E788C3
    10000 USDC pool: 0xFED0B9bbAad31fbc3f0112225749494d97abE464

## BSC Testnet
### BNB

    0.01 BNB testpool: 0xa08340aB4bbBba7d3C390c4a86C013a6DBf28EB5
    0.1 BNB pool: 0x2edD6AC4518118fB97c4B5bA44cC4Ce9AAb7FF70
    1 BNB pool: 0xc2F27fdE6CFA18bf4DF9fEe12b16A2DA7AB3022f
    10 BNB pool: 0x0a1ef6afEBE2a592F92F4c3396C7c0C5422491f3
    100 BNB pool: 0x299341E77824560A5e16D78E56a39cdD7C822b37

### USDC

    1 USDC testpool: 0xa99Ae5Db4D6dD863F2c3E0d4a493E11be1bc34C2
    10 USDC pool: 0xd726c2339De01E7509749DA5C00F63FE4073E065
    100 USDC pool: 0xf7194104278eFE27D97Ec1A8d335a31C15211D6E
    1000 USDC pool: 0x4424bf66dAF6842eAb66353220274f0B067b99fF
    10000 USDC pool: 0x2B61BBf4d59d1BB8e9e7F4B1ac0d55E0Ba002B59
