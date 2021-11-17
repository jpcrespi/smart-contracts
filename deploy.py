import json
from solcx import compile_standard

with open("Warecash.sol", "r") as file:
    warecash = file.read()

compiled_sol = compile_standard({
    "language": "Solidity",
    "sources": {
        "Warecash.sol": {
            "content": warecash
        }
    },
    "settings": {
        "outputSelection": {
            "*": {
                "*": ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]
            }
        }
    }
}, solc_version="0.8.7")

with open("Warecash.json", "w") as file:
    json.dump(compiled_sol, file)