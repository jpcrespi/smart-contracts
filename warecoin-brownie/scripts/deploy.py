from brownie import network, accounts, config, Warecoin


def get_account():
    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])


def deploy():
    account = get_account()
    warecoin = Warecoin.deploy({"from": account})
    print(warecoin)


def main():
    deploy()
