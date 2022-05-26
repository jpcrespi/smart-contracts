import { readFileSync } from 'fs'
import * as solc from 'solc'

export interface ContractObject {
    assembly: any[]
    bytecode: string
    functionHashes: any[]
    gasEstimates: any[]
    interface: string
    metadata: string
    opcodes: string
    runtimeBytecode: string
    srcmap: string
    srcmapRuntime: string
}

export interface ContractObjects {
    [key: string]: ContractObject
}

export interface RootObject {
    contracts: ContractObjects
    sourceList: any
    sources: any
}

export class Compiler {

    public contractSource: string

    constructor(contractPath: string) {
        this.contractSource = readFileSync(contractPath, 'utf8');
    }

    compile(): RootObject {
        return solc.compile(this.contractSource)
    }
}