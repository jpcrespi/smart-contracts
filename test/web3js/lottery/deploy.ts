import HDWalletProvider from '@truffle/hdwallet-provider'
import { exit } from 'process'
import { App } from '../src/app'
import rootObject from './compile'

class Deploy {

    public app: App

    constructor(name: string) {
        this.app = new App(this.provider(), rootObject.contracts[name])
    }

    provider(): HDWalletProvider {
        return new HDWalletProvider(
            'solar year smart area current until firm apple foam all garment knock', 
            'http://127.0.0.1:7545') 
            // 'http://127.0.0.1:8548) 
            // 'https://rinkeby.infura.io/v3/0bc7acab265a42a69eddf9ecb63d6df9')
    }

    async run() {
        await this.app.getAccounts()
        console.log('Attempting to deploy form account ', this.app.account())
        await this.app.newContract()
        console.log('Contract deployed to ', this.app.contract?.options.address)
        exit(0)
    }
}

let deploy = new Deploy(':Lottery')
deploy.run()