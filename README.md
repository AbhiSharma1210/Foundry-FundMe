# About

This is a crowd funding App made in solidity. 


# Getting Started

## Requirements

Following are the pre-requisites.

| Requirement | Description                                                                                                                          |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| git         | Check git version by using ```git --version``` or install from [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) |
| Foundry     | Check foundry version by using ```forge --version``` or install from [here](https://getfoundry.sh)                                   |

## Quickstart

```
git clone https://github.com/AbhiSharma1210/Foundry-FundMe
cd Foundry-FundMe
forge build
```

## Features

List the main features.
1. Gets current price feed to convert minimum amount into ETH.
2. Sender needs to send atleast $5 for a successfull transaction.
3. Only the owner of the smart contract can withdraw.
4. Can be deployed on any chain.

# Testing

Following tests are covered.
1. Unit test.
2. Integration test.
3. Forked test.

We can directly run 
```
forge test
```
or, If you want to only run test functions matching the specified regex pattern.

```
"forge test -m testFunctionName" is deprecated. Please use

forge test --mt testFunctionName
```
or
```
forge test --fork-url $SEPOLIA_RPC_URL
```

## Test coverage

Check with the following command.
```
forge coverage
```

# Deploying to a testnet/Mainnet

## 1.Setup environment variable
You'll want to set your ```SEPOLIA_RPC_URL``` and ```PRIVATE_KEY``` as environment variables. You can add them to a ```.env``` file.

* ```PRIVATE_KEY```: The private key of your account(only use test account.)
* ```SEPOLIA_RPC_URL```: You can setup an [Alchemy](https://www.alchemy.com) account to get the URL of the Sepolia testnet node.
* Optional - You can add your ```EHTERSCAN_API_KEY``` if you want to verify the contract on [Etherscan](https://etherscan.io).

## 2.Get testnet ETH
You can get some testnet ETH from [faucets.chain.link](https://faucets.chain.link) to add to your Metamask test account.

## 3.Deploy

```
forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast -- verify --etherscan-api-key $ETHERSCAN_API_KEY
```

## 4.Scripts
After deployment to a testnet/local net. You can run the scripts.

Using ```cast``` deployed locally:
```
cast send <FUNDME_CONTRACT_ADDRESS> "fund()" --value 0.1ether --private-key <PRIVATE_KEY>
```


