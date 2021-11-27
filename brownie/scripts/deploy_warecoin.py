from brownie import config, network, Warecoin
from scripts import utils


def deploy_warecoin():
    account = utils.get_account()
    warecoin = Warecoin.deploy(
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify"),
    )
    return warecoin


def main():
    deploy_warecoin()
