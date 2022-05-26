from scripts.utils import local_networks, get_account, fund_with_link
from scripts.lottery.deploy import deploy
from pytest import skip
from time import sleep


def test_can_pick_winner():
    if local_networks() == True:
        skip("Only remote networks")
    lottery = deploy()
    account = get_account()
    lottery.start({"from": account})
    lottery.enter({"from": account, "value": lottery.getEntranceFee()})
    lottery.enter({"from": account, "value": lottery.getEntranceFee()})
    fund_with_link(lottery)
    lottery.end({"from": account})
    sleep(60)
    assert lottery.lastWinner() == account
    assert lottery.balance() == 0
