from scripts.utils import Utils
from scripts.contracts.erc20.presets.erc20_preset import ERC20Preset


class Contracts(object):
    __token: ERC20Preset

    def load(self):
        address = Utils.getContract("erc20preset")
        self.__token = ERC20Preset(address=address)

    def deploy(self):
        self.__token = ERC20Preset(
            name="TestToken",
            symbol="TST",
            decimals=8,
            sender=Utils.getAccount(),
        )

    def token(self) -> ERC20Preset:
        return self.__token


contracts = Contracts()
