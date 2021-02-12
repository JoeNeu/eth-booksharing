const UserController = artifacts.require('UserController.sol');
const UserDatabase = artifacts.require('UserDatabase.sol');
const BookController = artifacts.require('BookController.sol');
const BookDatabase = artifacts.require('BookDatabase.sol');

module.exports = async function(deployer,network,accounts) {
    deployer.deploy(UserDatabase).then( function(userDB) {
        return deployer.deploy(UserController, userDB.address).then( function (userController) {
            userDB.setAccessor(userController.address);
            return deployer.deploy(BookDatabase).then( function(bookDB) {
                return deployer.deploy(BookController, bookDB.address, userController.address).then( function (bookController) {
                    return bookDB.setAccessor(bookController.address);
                })
            })
        })
    })
};
