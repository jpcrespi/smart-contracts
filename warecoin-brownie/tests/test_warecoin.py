from brownie import accounts, Warecoin


def get_account():
    return accounts[0]


def test_deploy():
    account = get_account()
    warecoin = Warecoin.deploy({"from": account})
    assert warecoin.name() == "Warecoin"
    assert warecoin.symbol() == "WC"
    assert warecoin.decimals() == 8
    assert warecoin.totalSupply() == 0


def test_firtMint():
    account = get_account()
    warecoin = Warecoin.deploy({"from": account})
    warecoin.mint(account, 50 * 10 ** warecoin.decimals())
    assert warecoin.totalSupply() == 5000000000
    assert warecoin.balanceOf(account) == 5000000000
