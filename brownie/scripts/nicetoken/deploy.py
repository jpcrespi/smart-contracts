from brownie import config, network, Nicetoken
from scripts.utils import get_account
from web3 import Web3

initial_supply = Web3.toWei(1000, "ether")


def main():
    account = get_account()
    nice = Nicetoken.deploy(
        initial_supply,
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify", False),
    )
    print(f"{nice.name()} deployed!")
