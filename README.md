# About

This is a basic project made in solidity for crowd funding. 


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

# Testing

Following tests are covered.
1. Unit test.
2. Integration test.
3. Forked test.

We can directly run 
```
forge test
```

## License

Specify the license under which your project is released. Mention the license type (e.g., MIT, Apache, GNU, etc.) and include a link to the full license file in your repository.
