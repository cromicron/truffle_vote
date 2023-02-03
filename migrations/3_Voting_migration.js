const Voting = artifacts.require("VotingContract");
const theQuestion = web3.utils.asciiToHex("what is superior?");
const candidateNames = [web3.utils.asciiToHex("chocolate"), web3.utils.asciiToHex("vanilla")]
const RegistrationContractAddress = "0x05eaB455e5F32e0b087c351101062e3F4e8417F7";
const endElectionTime = 1675431565;

module.exports = function (deployer) {
	deployer.deploy(Voting,theQuestion, candidateNames, RegistrationContractAddress,endElectionTime);
};