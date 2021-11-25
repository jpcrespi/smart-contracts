import brownie
from scripts import utils


def deploy():
    account = utils.get_account()
    warecoin = brownie.Warecoin.deploy({"from": account}, publish_source=True)
    print(f"Contract Deployed to {warecoin.address}")


def main():
    deploy()
