from pathlib import Path
from brownie import project, network, config, accounts, ZERO_ADDRESS


class Utils(object):
    @classmethod
    def localNetworks(cls):
        return network.show_active() in ["development", "ganache"]

    @classmethod
    def forkNetworks(cls):
        return network.show_active() in ["mainnet-fork", "mainnet-fork-infura"]

    @classmethod
    def getAccount(cls, index=None, id=None):
        if cls.localNetworks() or cls.forkNetworks():
            if index:
                return accounts[index]
            return accounts[0]
        if id:
            accounts.load(id)
        return accounts.add(config["wallets"]["from_key"])

    @classmethod
    def getContract(cls, name):
        return config["networks"][network.show_active()][name]

    @classmethod
    def getAccountZero(cls):
        return accounts.at(ZERO_ADDRESS, force=True)

    @classmethod
    def mainProject(cls):
        name = "NativasEvmProject"
        if hasattr(project, name):
            return project.NativasEvmProject
        else:
            proj = project.load(name=name)
            proj.load_config()
            print(f" * {name} loaded!")
            return proj

    @classmethod
    def openZeppelinProject(cls):
        name = "OpenzeppelinContracts450Project"
        if hasattr(project, name):
            return project.OpenzeppelinContracts450Project
        else:
            path = Path.home().joinpath(
                ".brownie", "packages", config["dependencies"][0]
            )
            proj = project.load(project_path=path)
            proj.load_config()
            print(f" * {name} loaded!")
            return proj
