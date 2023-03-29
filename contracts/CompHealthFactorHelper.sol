// SPDX-License-Identifier: MIT

pragma solidity 0.5.17;
pragma experimental ABIEncoderV2;

import {IComptroller} from './interfaces/compound/IComptroller.sol';
import {ICToken} from './interfaces/compound/ICToken.sol';
import {IOracle} from './interfaces/compound/IOracle.sol';
import './Expotential.sol';
import './ExponentialNoError.sol';

contract CompHealthFactorHelper is ExponentialNoError {

    struct AccountLiquidityLocalVars {
        uint sumCollateral;
        uint sumBorrow;
        uint qiTokenBalance;
        uint borrowBalance;
        uint exchangeRateMantissa;
        uint oraclePriceMantissa;
        Exp collateralFactor;
        Exp exchangeRate;
        Exp oraclePrice;
        Exp tokensToDenom;
    }

    function compHealthFactor(address _comptroller, address account) public view returns(uint256) {
        uint oErr;
        AccountLiquidityLocalVars memory vars;
        IComptroller comptroller = IComptroller(_comptroller);
        address[] memory cTokens = comptroller.getAllMarkets();
        for (uint i = 0; i < cTokens.length; i++) {
            ICToken asset = ICToken(cTokens[i]);

            // Read the balances and exchange rate from the qiToken
            (oErr, vars.qiTokenBalance, vars.borrowBalance, vars.exchangeRateMantissa) = asset.getAccountSnapshot(account);
            require(oErr == 0);// semi-opaque error code, we assume NO_ERROR == 0 is invariant between upgrades
            (,uint256 collateralFactorMantissa, ) = comptroller.markets(address(asset));
            vars.collateralFactor = Exp({mantissa: collateralFactorMantissa});
            vars.exchangeRate = Exp({mantissa: vars.exchangeRateMantissa});

            // Get the normalized price of the asset
            vars.oraclePriceMantissa = IOracle(comptroller.oracle()).getUnderlyingPrice(address(asset));
            require(vars.oraclePriceMantissa != 0);

            vars.oraclePrice = Exp({mantissa: vars.oraclePriceMantissa});

            // Pre-compute a conversion factor from tokens -> avax (normalized price value)
            vars.tokensToDenom = mul_(mul_(vars.collateralFactor, vars.exchangeRate), vars.oraclePrice);

            // sumCollateral += tokensToDenom * qiTokenBalance
            vars.sumCollateral = mul_ScalarTruncateAddUInt(vars.tokensToDenom, vars.qiTokenBalance, vars.sumCollateral);

            // sumBorrow += oraclePrice * borrowBalance
            vars.sumBorrow = mul_ScalarTruncateAddUInt(vars.oraclePrice, vars.borrowBalance, vars.sumBorrow);
        }
		if (vars.sumBorrow == 0) {
			return uint256(-1);
		} else {
			return div_(mul_(vars.sumCollateral, 1e18), vars.sumBorrow);
		}
    }

    function compHealthFactorForCToken(address _comptroller, address account, address ctoken) public view returns(uint256) {
        uint oErr;
        AccountLiquidityLocalVars memory vars;
        IComptroller comptroller = IComptroller(_comptroller);
        // address[] memory cTokens = comptroller.getAllMarkets();
		ICToken asset = ICToken(ctoken);

		// Read the balances and exchange rate from the qiToken
		(oErr, vars.qiTokenBalance, vars.borrowBalance, vars.exchangeRateMantissa) = asset.getAccountSnapshot(account);
		require(oErr == 0);// semi-opaque error code, we assume NO_ERROR == 0 is invariant between upgrades
		(,uint256 collateralFactorMantissa, ) = comptroller.markets(address(asset));
		vars.collateralFactor = Exp({mantissa: collateralFactorMantissa});
		vars.exchangeRate = Exp({mantissa: vars.exchangeRateMantissa});

		// Get the normalized price of the asset
		vars.oraclePriceMantissa = IOracle(comptroller.oracle()).getUnderlyingPrice(address(asset));
		require(vars.oraclePriceMantissa != 0);

		vars.oraclePrice = Exp({mantissa: vars.oraclePriceMantissa});

		// Pre-compute a conversion factor from tokens -> avax (normalized price value)
		vars.tokensToDenom = mul_(mul_(vars.collateralFactor, vars.exchangeRate), vars.oraclePrice);

		// sumCollateral += tokensToDenom * qiTokenBalance
		vars.sumCollateral = mul_ScalarTruncateAddUInt(vars.tokensToDenom, vars.qiTokenBalance, vars.sumCollateral);

		// sumBorrow += oraclePrice * borrowBalance
		vars.sumBorrow = mul_ScalarTruncateAddUInt(vars.oraclePrice, vars.borrowBalance, vars.sumBorrow);

		if (vars.sumBorrow == 0) {
			return uint256(-1);
		} else {
			return div_(mul_(vars.sumCollateral, 1e18), vars.sumBorrow);
		}
        
    }
}
