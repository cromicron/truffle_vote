const fs = require('fs');
const registerContract = JSON.parse(fs.readFileSync('../build/contracts/Register.json', 'utf8'));

const Voting = artifacts.require("VotingContract");
const theQuestion = web3.utils.asciiToHex("what is superior?");
const candidateNames = [web3.utils.asciiToHex("chocolate"), web3.utils.asciiToHex("vanilla")]
const registrationContractAddress = registerContract.networks[5].address;
const endElectionTime = 1675431565;

module.exports = function (deployer) {
	deployer.deploy(Voting,theQuestion, candidateNames, registrationContractAddress,endElectionTime);
};