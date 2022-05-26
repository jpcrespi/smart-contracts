import * as ganache from 'ganache-cli'
import { App } from '../../src/app'
import rootObject from '../compile'
import { notStrictEqual, ok, strictEqual } from 'assert'
import { assert } from 'console'

class Test {

    public app: App

    constructor(name: string) {
        this.app = new App(this.provider(), rootObject.contracts[name])
    }

    provider(): any {
        return ganache.provider()
    }

    async run() {
        await this.app.getAccounts()
        await this.app.newContract()
    }
}


let test = new Test(':Lottery')

beforeEach(async () => {
    await test.app.getAccounts()
    await test.app.newContract()
})

describe('Lottery', () => {
    it('Deploy contract', () => {
        ok(test.app.contract?.options.address)
    })
    it ('Has owner', async () => {
        const owner = await test.app.contract?.methods.getOwner().call()
        strictEqual(owner, test.app.account());
    })
    it ('Allows one account to enter', async () => {
        await test.app.contract?.methods.enter().send({
            from: test.app.account(1),
            value: test.app.web3.utils.toWei('0.01', 'ether')
        })
        const players = await test.app.contract?.methods.getPlayers().call({
            from: test.app.account(1)
        })
        strictEqual(test.app.account(1), players[0])
        strictEqual(1, players.length)
    })
    it ('Allows multiple accounts to enter', async () => {
        await test.app.contract?.methods.enter().send({
            from: test.app.account(1),
            value: test.app.web3.utils.toWei('0.01', 'ether')
        })
        await test.app.contract?.methods.enter().send({
            from: test.app.account(2),
            value: test.app.web3.utils.toWei('0.01', 'ether')
        })
        await test.app.contract?.methods.enter().send({
            from: test.app.account(3),
            value: test.app.web3.utils.toWei('0.01', 'ether')
        })
        const players = await test.app.contract?.methods.getPlayers().call({
            from: test.app.account(1)
        })
        strictEqual(test.app.account(1), players[0])
        strictEqual(test.app.account(2), players[1])
        strictEqual(test.app.account(3), players[2])
        strictEqual(3, players.length)
    })
    it ('Requires a minimum amount of ether to enter', async () => {
        try {
            await test.app.contract?.methods.enter().send({
                from: test.app.account(1),
                value: test.app.web3.utils.toWei('0.001', 'ether')
            })
            throw new Error('works');
        } catch (error) {
            notStrictEqual(error.message, 'works')
        }
    })
    it ('Only Owner', async () => {
        try {
            await test.app.contract?.methods.enter().send({
                from: test.app.account(1),
                value: test.app.web3.utils.toWei('1', 'ether')
            })
            await test.app.contract?.methods.raffle('secret').send({
                from: test.app.account(1)
            })
            throw new Error('works');
        } catch (error) {
            notStrictEqual(error.message, 'works')
        }
    })
    it ('Not raffle empty players', async () => {
        try {
            await test.app.contract?.methods.raffle('secret').send({
                from: test.app.account(0)
            })
            throw new Error('works');
        } catch (error) {
            notStrictEqual(error.message, 'works')
        }
    })
    it ('Send mony to a winner and reset the players array', async () => {
        await test.app.contract?.methods.enter().send({
            from: test.app.account(1),
            value: test.app.web3.utils.toWei('1', 'ether')
        })
        const initialBalance = await test.app.web3.eth.getBalance(test.app.account(1))
        await test.app.contract?.methods.raffle('secret').send({
            from: test.app.account(0)
        })
        const finalBalance = await test.app.web3.eth.getBalance(test.app.account(1))
        const difference = Number(finalBalance) - Number(initialBalance)
        ok(difference == Number(test.app.web3.utils.toWei('1', 'ether')))
    })
})