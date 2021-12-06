// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

    // this is a special function
    // it's called when you make a transaction that doesn't specify 
    // function name to call

    // External function is part of the contract interface
    // which means they can be called via contracts and other transactions

    uint public numOfFunders;
    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;

    modifier limitWithdraw(uint withdrawAmount) {
        require(withdrawAmount <= 100000000000000000, 
        "Cannot withdraw more than 0.1 ether"
        );
        _;
    }

    receive() external payable {}

    function addFunds() external payable {
        // uint index = numOfFunders++;
        // funders[index] = msg.sender;
        address funder = msg.sender;
        if (!funders[funder]) {
            uint index = numOfFunders++;
            funders[funder] = true;
            lutFunders[index] = funder;
        }
    }

    function withdraw(uint withdrawAmount) external limitWithdraw(withdrawAmount) {
        // require(withdrawAmount <= 100000000000000000, "Cannot withdraw more than 0.1 ether");
        // if (withdrawAmount < 1000000000000000000) {
        payable(msg.sender).transfer(withdrawAmount);
        // }
    }

    function getAllFunders() external view returns (address[] memory) {
        address[] memory _funders = new address[](numOfFunders);

        for (uint i = 0; i < numOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }

        return _funders;
    }

    // function getAllFunders() public view returns (address[] memory) {
    //     return funders;
    // }

    function getFunderAtIndex(uint8 index) external view returns (address) {
        // address[] memory _funders = getAllFunders();
        return lutFunders[index];
    }

    // const instance = await Faucet.deployed()
    // instance.addFunds({from: accounts[0], value: "2000000000000000000"})
    // instance.getFunderAtIndex(1)
    // instance.withdraw("500000000000000000", {from: accounts[1]})

    // function justTesting() external pure returns(uint) {
    //     return 2 + 2;
    // }

    // pure, view - read-only call, no gas fee
    // view - it indicates that the function will not alter the storage state in any way
    // pure - even more strict, indicating that it won't even read the storage state

    // Transaction (can generate state changes) and require gas fee
    // read-only call, no gas fee

    // to talk to the node on the network you can make JSON-RPC http calls
}

// Block info
// Nonce - a hash that when combined with the minHash proofs that
// the block has gone through proof of work(POW)
// 8 bytes => 64 bits