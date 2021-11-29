from web3 import Web3
from scripts.utils import fund_with_link, get_account, get_contract, local_networks
from scripts.deploy_lottery import deploy_lottery
from pytest import skip, raises
from brownie import exceptions


def test_get_entrace_fee():
    if local_networks() == False:
        skip("Only local networks")
    lottery = deploy_lottery()
    expected_fee = Web3.toWei(50 / 2000, "ether")
    entrace_fee = lottery.getEntranceFee()
    assert expected_fee == entrace_fee


def test_cannot_enter_unless_starter():
    if local_networks() == False:
        skip("Only local networks")
    lottery = deploy_lottery()
    with raises(exceptions.VirtualMachineError):
        lottery.enter({"from": get_account(), "value": lottery.getEntranceFee()})


def test_can_start_and_enter():
    if local_networks() == False:
        skip("Only local networks")
    lottery = deploy_lottery()
    account = get_account()
    lottery.start({"from": account})
    lottery.enter({"from": account, "value": lottery.getEntranceFee()})
    assert lottery.getPlayer(0) == account


def test_can_end():
    if local_networks() == False:
        skip("Only local networks")
    lottery = deploy_lottery()
    account = get_account()
    lottery.start({"from": account})
    lottery.enter({"from": account, "value": lottery.getEntranceFee()})
    fund_with_link(lottery)
    lottery.end({"from": account})
    assert lottery.getState() == 2


def test_can_pick_winner():
    if local_networks() == False:
        skip("Only local networks")
    lottery = deploy_lottery()
    account = get_account()
    lottery.start({"from": account})
    lottery.enter({"from": account, "value": lottery.getEntranceFee()})
    lottery.enter({"from": get_account(index=1), "value": lottery.getEntranceFee()})
    lottery.enter({"from": get_account(index=2), "value": lottery.getEntranceFee()})
    fund_with_link(lottery)
    tx1 = lottery.end({"from": account})
    requestId = tx1.events["RequestedRandomness"]["requestId"]
    get_contract("vrf_coordinator").callBackWithRandomness(
        requestId, 777, lottery.address, {"from": account}
    )
    assert lottery.lastWinner() == account
    assert lottery.balance() == 0
