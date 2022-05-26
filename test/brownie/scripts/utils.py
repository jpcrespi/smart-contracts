from brownie import (
    accounts,
    network,
    config,
    Contract,
    interface,
    MockV3Aggregator,
    VRFCoordinatorMock,
    LinkToken,
)

LOCAL_NETWORKS = ["development", "ganache"]
FORK_NETWORKS = ["mainnet-fork", "mainnet-fork-infura"]
contract_to_mock = {
    "eth_usd_price_feed": MockV3Aggregator,
    "vrf_coordinator": VRFCoordinatorMock,
    "link_token": LinkToken,
}


def local_networks():
    return network.show_active() in LOCAL_NETWORKS


def fork_networks():
    return network.show_active() in FORK_NETWORKS


def get_account(index=None, id=None):
    if local_networks() or fork_networks():
        if index:
            return accounts[index]
        return accounts[0]
    if id:
        accounts.load(id)
    return accounts.add(config["wallets"]["from_key"])


def get_price_feed():
    if local_networks():
        if len(MockV3Aggregator) <= 0:
            MockV3Aggregator.deploy(8, 2000 * 10 ** 8, {"from": get_account()})
        return MockV3Aggregator[-1]
    else:
        return config["networks"][network.show_active()].get("eth_usd_price_feed")


def get_contract(contract_name):
    contract_type = contract_to_mock[contract_name]
    if local_networks() == True:
        if len(contract_type) <= 0:
            deploy_mocks()
        return contract_type[-1]
    else:
        contract_address = config["networks"][network.show_active()].get(contract_name)
        return Contract.from_abi(
            contract_type._name, contract_address, contract_type.abi
        )


def deploy_mocks():
    account = get_account()
    if len(MockV3Aggregator) <= 0:
        MockV3Aggregator.deploy(8, 2000 * 10 ** 8, {"from": account})
    if len(LinkToken) <= 0:
        LinkToken.deploy({"from": account})
    if len(VRFCoordinatorMock) <= 0:
        VRFCoordinatorMock.deploy(LinkToken[-1].address, {"from": account})


def fund_with_link(
    contract_address, account=None, link_token=None, amount=1 * 10 ** 17
):
    account = account if account else get_account()
    link_token = link_token if link_token else get_contract("link_token")
    # link_token_contract = interface.LinkTokenInterface(link_token.address)
    tx = link_token.transfer(contract_address, amount, {"from": account})
    tx.wait(1)
    return tx
