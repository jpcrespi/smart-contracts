import json
import typing
import solcx


class Builder:
    @classmethod
    def singleFile(self, file_name: str, solc_version: str) -> typing.Dict:

        with open(file_name + ".sol", "r") as file:
            data = file.read()

        compiled = solcx.compile_standard(
            {
                "language": "Solidity",
                "sources": {file_name + ".sol": {"content": data}},
                "settings": {
                    "outputSelection": {
                        "*": {"*": ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]}
                    }
                },
            },
            solc_version=solc_version,
        )

        with open(file_name + ".json", "w") as file:
            json.dump(compiled, file)

        return compiled
