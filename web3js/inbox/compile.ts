import { resolve } from 'path'
import { Compiler } from '../src/compiler'

class InboxCompiler {

    public compiler: Compiler

    constructor(contractName: string) {
        this.compiler = new Compiler(resolve(__dirname, 'contracts', contractName))
    }
}

let inbox = new InboxCompiler('inbox.sol')
export default inbox.compiler.compile()