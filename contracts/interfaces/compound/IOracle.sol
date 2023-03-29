// SPDX-License-Identifier: MIT

pragma solidity 0.5.17;
pragma experimental ABIEncoderV2;

interface IOracle {
  function admin (  ) external view returns ( address );
  function assetPrices ( address asset ) external view returns ( uint256 );
//   function getFeed ( string symbol ) external view returns ( address );
  function getUnderlyingPrice ( address qiToken ) external view returns ( uint256 );
  function isPriceOracle (  ) external view returns ( bool );
  function setAdmin ( address newAdmin ) external;
  function setDirectPrice ( address asset, uint256 price ) external;
//   function setFeed ( string symbol, address feed ) external;
  function setUnderlyingPrice ( address qiToken, uint256 underlyingPriceMantissa ) external;
}
