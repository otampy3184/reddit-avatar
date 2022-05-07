const Migrations = artifacts.require("RedditAvatar");

module.exports = function (deployer) {
    deployer.deploy(Migrations);
  };  
