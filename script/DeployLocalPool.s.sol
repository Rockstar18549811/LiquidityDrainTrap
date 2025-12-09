// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/TestToken.sol";
import "../src/SimplePool.sol";

contract DeployLocalPool is Script {
    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(pk);

        TestToken token = new TestToken();
        SimplePool pool = new SimplePool();

        // fund the pool so collect() can read a real balance
        token.transfer(address(pool), 200_000 ether);

        vm.stopBroadcast();

        console2.log("TOKEN:", address(token));
        console2.log("POOL:",  address(pool));
    }
}
