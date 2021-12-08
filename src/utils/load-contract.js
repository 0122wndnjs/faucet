// var contract = require("@truffle/contract");
import contract from "@truffle/contract"

export const loadContract = async (name, provider) => {
    const res = await fetch(`/contracts/${name}.json`)
    const Artifact = await res.json()

    const _contract = contract(Artifact)
    _contract.setProvider(provider)

<<<<<<< HEAD
    const deployedContract = await _contract.deployed() 
=======
    const deployedContract = await _contract.deployed()
>>>>>>> d05d5204d825c3aae941371fa19b055954d39aee

    return _contract
}