// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.5.17;

contract BalanceUtil {
    function getBalance(address addr) public view returns (uint256) {
        return addr.balance;
    }
}