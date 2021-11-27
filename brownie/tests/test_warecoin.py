from scripts.utils import get_account
from scripts.deploy_warecoin import deploy_warecoin


def test_deploy():
    warecoin = deploy_warecoin()
    assert warecoin.name() == "Warecoin"
    assert warecoin.symbol() == "WC"
    assert warecoin.decimals() == 8
    assert warecoin.totalSupply() == 0


def test_firt_mint():
    account = get_account()
    warecoin = deploy_warecoin()
    warecoin.mint(account, 50 * 10 ** warecoin.decimals())
    assert warecoin.totalSupply() == 5000000000
    assert warecoin.balanceOf(account) == 5000000000
