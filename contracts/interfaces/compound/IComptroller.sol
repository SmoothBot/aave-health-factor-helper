// SPDX-License-Identifier: MIT

pragma solidity 0.5.17;
pragma experimental ABIEncoderV2;

interface IComptroller {
//   function _become ( address unitroller ) external;
//   function _borrowGuardianPaused (  ) external view returns ( bool );
//   function _grantQi ( address recipient, uint256 amount ) external;
//   function _mintGuardianPaused (  ) external view returns ( bool );
//   function _setBorrowCapGuardian ( address newBorrowCapGuardian ) external;
//   function _setBorrowPaused ( address qiToken, bool state ) external returns ( bool );
//   function _setCloseFactor ( uint256 newCloseFactorMantissa ) external returns ( uint256 );
//   function _setCollateralFactor ( address qiToken, uint256 newCollateralFactorMantissa ) external returns ( uint256 );
//   function _setLiquidationIncentive ( uint256 newLiquidationIncentiveMantissa ) external returns ( uint256 );
//   function _setMarketBorrowCaps ( address[] qiTokens, uint256[] newBorrowCaps ) external;
//   function _setMintPaused ( address qiToken, bool state ) external returns ( bool );
//   function _setPauseGuardian ( address newPauseGuardian ) external returns ( uint256 );
//   function _setPriceOracle ( address newOracle ) external returns ( uint256 );
//   function _setRewardSpeed ( uint8 rewardType, address qiToken, uint256 supplyRewardSpeed, uint256 borrowRewardSpeed ) external;
//   function _setSeizePaused ( bool state ) external returns ( bool );
//   function _setTransferPaused ( bool state ) external returns ( bool );
//   function _supportMarket ( address qiToken ) external returns ( uint256 );
  function accountAssets ( address, uint256 ) external view returns ( address );
  function admin (  ) external view returns ( address );
  function allMarkets ( uint256 ) external view returns ( address );
  function borrowAllowed ( address qiToken, address borrower, uint256 borrowAmount ) external returns ( uint256 );
  function borrowCapGuardian (  ) external view returns ( address );
  function borrowCaps ( address ) external view returns ( uint256 );
  function borrowGuardianPaused ( address ) external view returns ( bool );
  function borrowRewardSpeeds ( uint8, address ) external view returns ( uint256 );
  function borrowVerify ( address qiToken, address borrower, uint256 borrowAmount ) external;
  function checkMembership ( address account, address qiToken ) external view returns ( bool );
  function claimReward ( uint8 rewardType, address holder ) external;
  // function claimReward ( uint8 rewardType, address holder, address[] qiTokens ) external;
  // function claimReward ( uint8 rewardType, address[] holders, address[] qiTokens, bool borrowers, bool suppliers ) external payable;
  function closeFactorMantissa (  ) external view returns ( uint256 );
  function comptrollerImplementation (  ) external view returns ( address );
  // function enterMarkets ( address[] qiTokens ) external returns ( uint256[] );
  function exitMarket ( address qiTokenAddress ) external returns ( uint256 );
  function getAccountLiquidity ( address account ) external view returns ( uint256, uint256, uint256 );
  function getAllMarkets (  ) external view returns ( address[] memory );
  // function getAssetsIn ( address account ) external view returns ( address[] );
  function getBlockTimestamp (  ) external view returns ( uint256 );
  function getHypotheticalAccountLiquidity ( address account, address qiTokenModify, uint256 redeemTokens, uint256 borrowAmount ) external view returns ( uint256, uint256, uint256 );
  function initialIndexConstant (  ) external view returns ( uint224 );
  function isComptroller (  ) external view returns ( bool );
  function liquidateBorrowAllowed ( address qiTokenBorrowed, address qiTokenCollateral, address liquidator, address borrower, uint256 repayAmount ) external returns ( uint256 );
  function liquidateBorrowVerify ( address qiTokenBorrowed, address qiTokenCollateral, address liquidator, address borrower, uint256 actualRepayAmount, uint256 seizeTokens ) external;
  function liquidateCalculateSeizeTokens ( address qiTokenBorrowed, address qiTokenCollateral, uint256 actualRepayAmount ) external view returns ( uint256, uint256 );
  function liquidationIncentiveMantissa (  ) external view returns ( uint256 );
  function markets ( address ) external view returns ( bool isListed, uint256 collateralFactorMantissa, bool isQied );
  function maxAssets (  ) external view returns ( uint256 );
  function mintAllowed ( address qiToken, address minter, uint256 mintAmount ) external returns ( uint256 );
  function mintGuardianPaused ( address ) external view returns ( bool );
  function mintVerify ( address qiToken, address minter, uint256 actualMintAmount, uint256 mintTokens ) external;
  function oracle (  ) external view returns ( address );
  function pauseGuardian (  ) external view returns ( address );
  function pendingAdmin (  ) external view returns ( address );
  function pendingComptrollerImplementation (  ) external view returns ( address );
  function qiAddress (  ) external view returns ( address );
  function redeemAllowed ( address qiToken, address redeemer, uint256 redeemTokens ) external returns ( uint256 );
  function redeemVerify ( address qiToken, address redeemer, uint256 redeemAmount, uint256 redeemTokens ) external;
  function repayBorrowAllowed ( address qiToken, address payer, address borrower, uint256 repayAmount ) external returns ( uint256 );
  function repayBorrowVerify ( address qiToken, address payer, address borrower, uint256 actualRepayAmount, uint256 borrowerIndex ) external;
  function rewardAccrued ( uint8, address ) external view returns ( uint256 );
  function rewardAvax (  ) external view returns ( uint8 );
  function rewardBorrowState ( uint8, address ) external view returns ( uint224 index, uint32 timestamp );
  function rewardBorrowerIndex ( uint8, address, address ) external view returns ( uint256 );
  function rewardQi (  ) external view returns ( uint8 );
  function rewardSupplierIndex ( uint8, address, address ) external view returns ( uint256 );
  function rewardSupplyState ( uint8, address ) external view returns ( uint224 index, uint32 timestamp );
  function seizeAllowed ( address qiTokenCollateral, address qiTokenBorrowed, address liquidator, address borrower, uint256 seizeTokens ) external returns ( uint256 );
  function seizeGuardianPaused (  ) external view returns ( bool );
  function seizeVerify ( address qiTokenCollateral, address qiTokenBorrowed, address liquidator, address borrower, uint256 seizeTokens ) external;
  function setQiAddress ( address newQiAddress ) external;
  function supplyRewardSpeeds ( uint8, address ) external view returns ( uint256 );
  function transferAllowed ( address qiToken, address src, address dst, uint256 transferTokens ) external returns ( uint256 );
  function transferGuardianPaused (  ) external view returns ( bool );
  function transferVerify ( address qiToken, address src, address dst, uint256 transferTokens ) external;
}
