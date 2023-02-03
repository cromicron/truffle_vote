const Register = artifacts.require("Register");
const studentHashes = [];


module.exports = function (deployer) {
	deployer.deploy(Register,studentHashes);
};