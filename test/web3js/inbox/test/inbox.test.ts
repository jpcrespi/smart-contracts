import * as ganache from 'ganache-cli'
import * as assert from 'assert'
import { App } from '../../src/app'
import rootObject from '../compile'

class Test {

    public app: App

    constructor(name: string, args: [any]) {
        this.app = new App(this.provider(), rootObject.contracts[name], args)
    }

    provider(): any {
        return ganache.provider()
    }

    async run() {
        await this.app.getAccounts()
        await this.app.newContract()
    }
}


let test = new Test(':Inbox', ['Hi!'])

beforeEach(async () => {
    await test.app.getAccounts()
    await test.app.newContract()
})

describe('Inbox', () => {
    it('Deploy contract', () => {
        assert.ok(test.app.contract?.options.address)
    })
    it ('Has default message', async () => {
        const message = await test.app.contract?.methods.getMessage().call()
        assert.strictEqual(message, 'Hi!');
    })
    it ('Can change message', async () => {
        await test.app.contract?.methods.setMessage('Bye!').send({
            from: test.app.account()
        })
        const message = await test.app.contract?.methods.getMessage().call()
        assert.strictEqual(message, 'Bye!');
    })
})