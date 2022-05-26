from scripts.utils import get_account
from scripts.warecoin.deploy import deploy


def test_deploy():
    warecoin = deploy()
    assert warecoin.name() == "Warecoin"
    assert warecoin.symbol() == "WC"
    assert warecoin.decimals() == 8
    assert warecoin.totalSupply() == 0


def test_firt_mint():
    account = get_account()
    warecoin = deploy()
    warecoin.mint(account, 50 * 10 ** warecoin.decimals())
    assert warecoin.totalSupply() == 5000000000
    assert warecoin.balanceOf(account) == 5000000000
