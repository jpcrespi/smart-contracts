import Web3 from 'web3'
import { Contract } from 'web3-eth-contract'
import { ContractObject } from './compiler'
import { exit } from 'process'

export class App {

    public web3: Web3
    public source: ContractObject
    public args: any[] | undefined

    public contract: Contract | null = null
    private accounts: string[] | null = null

    constructor(provider: any, source: ContractObject, args: any[] | undefined = undefined) {
        this.web3 = new Web3(provider)
        this.source = source
        this.args = args
    }

    abi(): any {
        return JSON.parse(this.source.interface)
    }

    account(index: number = 0): string {
        if (this.accounts == null) {
            exit(1)
        }
        return this.accounts[index]
    }

    async getAccounts() {
        this.accounts = await this.web3.eth.getAccounts()
    }

    async newContract() {
        this.contract = await new this.web3.eth.Contract(this.abi())
        .deploy({
            data: this.source.bytecode,
            arguments: this.args
        })
        .send({
            from: this.account(),
            gas: 1000000
        })
    }
}