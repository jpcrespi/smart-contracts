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

publicKey = os.getenv("PUBLIC_KEY")
privateKey = os.getenv("PRIVATE_KEY")

w3 = web3.Web3(web3.Web3.HTTPProvider(os.getenv("RPC_SERVER")))
tx = (
    w3.eth.contract(abi=abi, bytecode=bytecode)
    .constructor()
    .buildTransaction(
        {
            "gasPrice": w3.eth.gas_price,
            "chainId": os.getenv("CHAIN_ID"),
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
