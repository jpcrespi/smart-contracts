from brownie import accounts, network, config, MockV3Aggregator

LOCAL_NETWORKS = ["development", "ganache"]
FORK_NETWORKS = ["mainnet-fork", "mainnet-fork-infura"]


def local_networks():
    return network.show_active() in LOCAL_NETWORKS


def fork_networks():
    return network.show_active() in FORK_NETWORKS


def get_account():
    if local_networks() or fork_networks():
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])


def get_price_feed():
    if local_networks():
        if len(MockV3Aggregator) <= 0:
            MockV3Aggregator.deploy(8, 2000 * 10 ** 8, {"from": get_account()})
        return MockV3Aggregator[-1]
    else:
        return config["networks"][network.show_active()].get("eth_usd_price_feed")
