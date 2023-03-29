import pytest
from brownie import config
from brownie import CompHealthFactorHelper
# from brownie import accounts


@pytest.fixture
def comptroller():
    yield '0x486Af39519B4Dc9a7fCcd318217352830E8AD9b4'
    
@pytest.fixture
def acc(accounts):
    yield accounts[0]
    
@pytest.fixture
def helper(comptroller, acc):
    helper = CompHealthFactorHelper.deploy(comptroller, {'from': acc})
    yield helper

