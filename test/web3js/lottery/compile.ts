import { resolve } from 'path'
import { Compiler } from '../src/compiler'

class LotteryCompiler {

    public compiler: Compiler

    constructor(contractName: string) {
        this.compiler = new Compiler(resolve(__dirname, 'contracts', contractName))
    }
}

let lottery = new LotteryCompiler('lottery.sol')
export default lottery.compiler.compile()