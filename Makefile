-include .env

build:; forge build # This ';' is when we want to write command in 1 line.

deploy-sepolia:  # Without ';' we can write multiline commands.
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
