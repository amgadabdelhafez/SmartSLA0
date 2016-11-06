contract('ITCoin', function(accounts) {
  it("should put 10000 ITCoin in the first account", function() {
    var itc = ITCoin.deployed();

    return itc.getBalance.call(accounts[0]).then(function(balance) {
      assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
    });
  });
  it("should call a function that depends on a linked library", function() {
    var itc = ITCoin.deployed();
    var ITCoinBalance;
    var ITCoinEthBalance;

    return itc.getBalance.call(accounts[0]).then(function(outCoinBalance) {
      ITCoinBalance = outCoinBalance.toNumber();
      return itc.getBalanceInEth.call(accounts[0]);
    }).then(function(outCoinBalanceEth) {
      ITCoinEthBalance = outCoinBalanceEth.toNumber();
    }).then(function() {
      assert.equal(ITCoinEthBalance, 2 * ITCoinBalance, "Library function returned unexpeced function, linkage may be broken");
    });
  });
  it("should create a new incident", function() {
      var itc = ITCoin.deployed();
      var inc_requester = accounts[0];
      var inc_sys_id = "f41a73a5db3a2200d38cd170cf9619f1";
      var inc_created = "2016-10-31 08:48:27";

      return itc.newIncident.call(accounts[0], inc_sys_id, inc_created).then(function(isIncCreated) {
        console.log("numOfIncs: ");
        itc.numOfIncs.call().then(console.log());
        console.log("itc.incidents is ", itc.incidents[inc_sys_id]);
        console.log(itc.incidents[inc_sys_id].requester.call());

//        assert(isIncCreated, "Incident not created!");
//        assert(itc.incidents[inc_sys_id].requester === accounts[1], "not our incident!!")
    });
  });
  it("should send coin correctly", function() {
    var itc = ITCoin.deployed();

    // Get initial balances of first and second account.
    var account_one = accounts[0];
    var account_two = accounts[1];

    var account_one_starting_balance;
    var account_two_starting_balance;
    var account_one_ending_balance;
    var account_two_ending_balance;

    var amount = 10;

    return itc.getBalance.call(account_one).then(function(balance) {
      account_one_starting_balance = balance.toNumber();
      return itc.getBalance.call(account_two);
    }).then(function(balance) {
      account_two_starting_balance = balance.toNumber();
      return itc.sendCoin(account_two, amount, {from: account_one});
    }).then(function() {
      return itc.getBalance.call(account_one);
    }).then(function(balance) {
      account_one_ending_balance = balance.toNumber();
      return itc.getBalance.call(account_two);
    }).then(function(balance) {
      account_two_ending_balance = balance.toNumber();

      assert.equal(account_one_ending_balance, account_one_starting_balance - amount, "Amount wasn't correctly taken from the sender");
      assert.equal(account_two_ending_balance, account_two_starting_balance + amount, "Amount wasn't correctly sent to the receiver");
    });
  });
});
