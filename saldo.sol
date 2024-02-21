// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import "./ierc20.sol";

contract Saldo {
    function obtemSaldo(address token_, address pessoa_)  public view returns (uint256) {
        IERC20 token = IERC20(token_);
        return token.balanceOf(pessoa_);
    }

    function saldoMoeda(address pessoa_) public view returns (uint256) {
        return pessoa_.balance;
    }
}