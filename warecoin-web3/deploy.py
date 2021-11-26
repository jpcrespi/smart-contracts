import os
import web3
import dotenv
import build

dotenv.load_dotenv()

compiled = build.Builder.singleFile("Warecoin", "0.8.7")

bytecode = compiled["contracts"]["Warecoin.sol"]["Warecoin"]["evm"]["bytecode"][
    "object"
]
abi = compiled["contracts"]["Warecoin.sol"]["Warecoin"]["abi"]

publicKey = "0x56637455925C0aDE276B16D261b4F0dB04e1A140"
privateKey = os.getenv("PRIVATE_KEY")

w3 = web3.Web3(web3.Web3.HTTPProvider("http://127.0.0.1:8545"))
tx = (
    w3.eth.contract(abi=abi, bytecode=bytecode)
    .constructor()
    .buildTransaction(
        {
            "gasPrice": w3.eth.gas_price,
            "chainId": 1337,
            "from": publicKey,
            "nonce": w3.eth.getTransactionCount(publicKey),
        }
    )
)

signedTx = w3.eth.account.signTransaction(tx, private_key=privateKey)
txHash = w3.eth.send_raw_transaction(signedTx.rawTransaction)
txReceipt = w3.eth.wait_for_transaction_receipt(txHash)
print(txReceipt.contractAddress)
contract = w3.eth.contract(address=txReceipt.contractAddress, abi=abi)
print(contract.functions.name().call())
