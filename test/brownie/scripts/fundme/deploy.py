from brownie import config, network, FundMe
from scripts import utils


def deploy():
    account = utils.get_account()
    fund_me = FundMe.deploy(
        utils.get_price_feed(),
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify"),
    )
    return fund_me


def main():
    deploy()
