import brownie


def get_account():
    if brownie.network.show_active() == "development":
        return brownie.accounts[0]
    else:
        return brownie.accounts.add(brownie.config["wallets"]["from_key"])
