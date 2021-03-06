// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is disstributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.7.0;

// Builds new BPools, logging their addresses and providing `isBPool(address) -> (bool)`

import "./BColor.sol";
import "./BPoolExtend.sol";
import "./IERC20.sol";

interface IBpool {
    function initialize() external;
    function setController(address manager) external;
}

contract BFactory is BBronze {
    event LOG_NEW_POOL(
        address indexed caller,
        address indexed pool
    );

    event LOG_BLABS(
        address indexed caller,
        address indexed blabs
    );

    event LOG_POOLIMPL(
        address indexed caller,
        address indexed poolImpl
    );

    event LOG_EXCHPROXY(
        address indexed caller,
        address indexed exchProxy
    );

    event LOG_OPERATIONREGISTRY(
        address indexed caller,
        address indexed operationsRegistry
    );

    mapping(address=>bool) private _isBPool;

    function isBPool(address b)
        external view returns (bool)
    {
        return _isBPool[b];
    }

    function newBPool()
        external
        returns (BPoolExtend)
    {
        BPoolExtend bpool = new BPoolExtend(_poolImpl, _operationsRegistry, _exchProxy, abi.encodeWithSignature("initialize()"));
        _isBPool[address(bpool)] = true;
        emit LOG_NEW_POOL(msg.sender, address(bpool));
        IBpool(address(bpool)).setController(msg.sender);
        return bpool;
    }

    address private _blabs;
    address public _poolImpl;
    address public _exchProxy;
    address public _operationsRegistry;

    constructor(address poolImpl, address exchProxy, address operationsRegistry) public {
        _blabs = msg.sender;
        _poolImpl = poolImpl;
        _exchProxy = exchProxy;
        _operationsRegistry = operationsRegistry;
    }

    function getBLabs()
        external view
        returns (address)
    {
        return _blabs;
    }

    function setBLabs(address b)
        external
    {
        require(msg.sender == _blabs, "ERR_NOT_BLABS");
        emit LOG_BLABS(msg.sender, b);
        _blabs = b;
    }

    function setPoolImpl(address poolImpl)
        external
    {
        require(msg.sender == _blabs, "ERR_NOT_BLABS");
        emit LOG_POOLIMPL(msg.sender, poolImpl);
        _poolImpl = poolImpl;
    }

    function setExchProxy(address exchProxy)
        external
    {
        require(msg.sender == _blabs, "ERR_NOT_BLABS");
        emit LOG_EXCHPROXY(msg.sender, exchProxy);
        _exchProxy = exchProxy;
    }

    function setOperationsRegistry(address operationsRegistry)
        external
    {
        require(msg.sender == _blabs, "ERR_NOT_BLABS");
        emit LOG_OPERATIONREGISTRY(msg.sender, operationsRegistry);
        _operationsRegistry = operationsRegistry;
    }

    function collect(IERC20 pool)
        external
    {
        require(msg.sender == _blabs, "ERR_NOT_BLABS");
        uint collected = pool.balanceOf(address(this));
        bool xfer = pool.transfer(_blabs, collected);
        require(xfer, "ERR_ERC20_FAILED");
    }
}
