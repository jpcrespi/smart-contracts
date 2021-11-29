from brownie import config, network, Lottery
from scripts import utils
from time import sleep


def deploy_lottery():
    account = utils.get_account()
    lottery = Lottery.deploy(
        utils.get_contract("eth_usd_price_feed").address,
        utils.get_contract("vrf_coordinator").address,
        utils.get_contract("link_token").address,
        config["networks"][network.show_active()]["fee"],
        config["networks"][network.show_active()]["keyhash"],
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify", False),
    )
    print(f"lottery deployed!")
    return lottery


def start_lottery():
    account = utils.get_account()
    lottery = Lottery[-1]
    tx = lottery.start({"from": account})
    tx.wait(1)
    print(f"lottery started!")


def enter_lottery():
    account = utils.get_account()
    lottery = Lottery[-1]
    value = lottery.getEntranceFee() + 100000000
    tx = lottery.enter({"from": account, "value": value})
    tx.wait(1)
    print(f"account {account.address} entered!")


def end_lottery():
    account = utils.get_account()
    lottery = Lottery[-1]
    tx1 = utils.fund_with_link(lottery)
    tx1.wait(1)
    tx2 = lottery.end({"from": account})
    tx2.wait(1)
    print(f"{lottery.lastWinner()} is the new winner")


def main():
    deploy_lottery()
    start_lottery()
    enter_lottery()
    end_lottery()
