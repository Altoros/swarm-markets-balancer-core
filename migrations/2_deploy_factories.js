const TMath = artifacts.require('TMath');
const BToken = artifacts.require('BToken');
const BFactory = artifacts.require('BFactory');
const BPool = artifacts.require('BPool');
const ExchangeProxyMock = artifacts.require('ExchangeProxyMock');
const OperationsRegistryMock = artifacts.require('OperationsRegistryMock');

module.exports = async function (deployer, network, accounts) {
    if (network === 'test' || network === 'development' || network === 'coverage') {
        await deployer.deploy(TMath);
        await deployer.deploy(ExchangeProxyMock);
        await deployer.deploy(OperationsRegistryMock);
    }

    await deployer.deploy(BPool)

    // TODO - this should set the ExchangeProxy and OperationsRegistry addresses from an .env
    await deployer.deploy(BFactory, BPool.address, '0x0000000000000000000000000000000000000000', '0x0000000000000000000000000000000000000000');
};
