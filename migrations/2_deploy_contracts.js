const UserDatabase = artifacts.require('UserDatabase.sol');

module.exports = async function(deployer,network,accounts) {
    deployer.deploy(UserDatabase);
};
