const UserDatabase = artifacts.require('UserDatabase.sol');
const UserController = artifacts.require('UserController.sol');

module.exports = async function(deployer,network,accounts) {
    deployer.deploy(UserDatabase).then(function (userDB) {
        return deployer.deploy(UserController, userDB.address);
    })
};
