import TrieMap "mo:base/TrieMap";
import Nat "mo:base/Nat";
import Account "account";
import Result "mo:base/Result";

actor {
  type myResult = Result.Result<Nat, Text>;
  let ledger = TrieMap.TrieMap<Account.Account, Nat>(Account.accountsEqual, Account.accountsHash);

  // Returns the name of the token
  public query func name() : async Text {
    return "MotoCoin";
  };

  // Returns the symbol of the token
  public query func symbol() : async Text {
    return "MOC";
  };

  // Returns the the total number of tokens on all accounts
  public query func totalSupply() : async Nat {
    // find the sum of all the values
    var sum = 0;
    for (key in ledger.vals()) {
      sum += key;
    };
    sum;
  };

  // Returns the balance of the account
  public query func balanceOf(account : Account.Account) : async (Nat) {
    let acc = ledger.get(account);
    switch (acc) {
      case (?acc) {
        return acc;
      };
      case (null) {
        return 0;
      };
    };
  };
};
