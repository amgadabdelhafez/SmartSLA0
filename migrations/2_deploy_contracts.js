module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.autolink();
  deployer.deploy(ITCoin);
  deployer.deploy(DateTime);
//  deployer.deploy(DateTimeAPI);
};
