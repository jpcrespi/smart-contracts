from scripts.utils import get_account, local_networks
from scripts.fundme.deploy import deploy
from pytest import skip, raises
from brownie import accounts, exceptions


def test_can_fund_and_withdraw():
    fundMe = deploy()
    account = get_account()
    entrance_fee = fundMe.getEntranceFee() + 100
    tx1 = fundMe.fund({"from": account, "value": entrance_fee})
    tx1.wait(1)
    assert fundMe.addressToAmountFunded(account.address) == entrance_fee
    tx2 = fundMe.withdraw({"from": account})
    tx2.wait(1)
    assert fundMe.addressToAmountFunded(account.address) == 0


def test_only_owner_can_withdraw():
    if local_networks() == False:
        skip("Only local networks")
    fundMe = deploy()
    bad_actor = accounts.add()
    with raises(exceptions.VirtualMachineError):
        fundMe.withdraw({"from": bad_actor})
