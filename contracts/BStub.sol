// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.5.11;

import "contracts/BColor.sol";
import "contracts/BMath.sol";

// BStub exposes BMath internal functions

contract BStub is BBronze, BMath
{
    function calc_SpotPrice( uint Bi, uint Wi, uint Bo, uint Wo, uint f )
      public pure
        returns ( uint price ) 
    {
        return (price = _calc_SpotPrice(Bi, Wi, Bo, Wo, f));
    }

    function calc_SpotRate( uint Bi, uint Wi, uint Bo, uint Wo, uint f )
      public pure
        returns ( uint rate ) 
    {
        return (rate = _calc_SpotRate(Bi, Wi, Bo, Wo, f));
    }

    function calc_OutGivenIn( uint Bi, uint Wi
                            , uint Bo, uint Wo
                            , uint Ai
                            , uint fee
                            )
      public pure
        returns ( uint Ao )
    {
        return _calc_OutGivenIn(Bi, Wi, Bo, Wo, Ai, fee);
    }

    function calc_InGivenOut( uint Bi, uint Wi
                            , uint Bo, uint Wo
                            , uint Ao
                            , uint fee
                            )
      public pure
        returns ( uint Ai )
    {
        return _calc_InGivenOut(Bi, Wi, Bo, Wo, Ao, fee);
    }

    function calc_InGivenPrice( uint Bi, uint Wi
                              , uint Bo , uint Wo
                              , uint SER1
                              , uint fee)
      public pure
        returns ( uint Ai )
    {
        return _calc_InGivenPrice(Bi, Wi, Bo, Wo, SER1, fee);
    }

    function calc_PoolOutGivenSingleIn( uint balance, uint weight
                                      , uint poolBalance, uint totalWeight
                                      , uint tAi, uint fee )
      public pure
        returns (uint pAo)
    {
        return  _calc_PoolOutGivenSingleIn( balance, weight, poolBalance, totalWeight , tAi, fee );
    }

    function calc_SingleInGivenPoolOut( uint balance, uint weight
                                      , uint poolSupply, uint totalWeight
                                      , uint pAo, uint fee)
      public pure
        returns (uint tokenIn)
    {
        return _calc_SingleInGivenPoolOut( balance, weight, poolSupply, totalWeight, pAo, fee);
    }

    function calc_SingleOutGivenPoolIn( uint balance, uint weight
                                       , uint poolSupply, uint totalWeight
                                       , uint pAi, uint fee, uint exitFee)
      public pure
        returns (uint tAo)
    {
        return _calc_SingleOutGivenPoolIn( balance, weight, poolSupply, totalWeight, pAi, fee, exitFee);
    }

    function calc_PoolInGivenSingleOut( uint balance, uint weight
                                      , uint poolSupply, uint totalWeight
                                      , uint tAo, uint swapFee, uint exitFee)
      public pure
        returns (uint pAi)
    {
        return calc_PoolInGivenSingleOut( balance, weight, poolSupply, totalWeight, tAo, swapFee, exitFee);
    }


    function calc_bpow(uint base, uint exp)
      public pure
        returns (uint)
    {
        return bpow(base, exp);
    }

    function calc_bpowK(uint base, uint exp, uint K)
      public pure
        returns (uint)
    {
        return bpowK(base, exp, K);
    }

}