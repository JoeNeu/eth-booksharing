const UserController = artifacts.require('UserController.sol');
const UserDatabase = artifacts.require('UserDatabase.sol');
const BookShelfController = artifacts.require('BookShelfController.sol');
const BookDatabase = artifacts.require('BookDatabase.sol');
const BookShelfEvents = artifacts.require('BookShelfEvents.sol');

module.exports = async function(deployer,network,accounts) {
    deployer.deploy(UserDatabase).then( function(userDB) {
        return deployer.deploy(UserController, userDB.address).then( function (userController) {
            return userDB.setAccessor(userController.address);
        })
    })
    deployer.deploy(BookShelfEvents).then( function(bookEvents) {
        return deployer.deploy(BookDatabase).then( function(bookDB) {
            return deployer.deploy(BookShelfController, bookDB.address, bookEvents.address).then( function (bookController) {
                bookEvents.setAccessor(bookController.address);
                return bookDB.setAccessor(bookController.address);
            })
        })
    })
};
