script {  
    use Multichain::TestCoin;  
    use AptosFramework::Coin; 
  
    fun claim_mint_cap(account: signer) {  
        TestCoin::claim_mint_capability(&account);  
    }  
}

script {  
    use Multichain::TestCoin;  
    use AptosFramework::Coin; 
    fun mint_coin(account: signer, to: address, amount: u64) {  
        TestCoin::mint(&account, to, amount);  
    }  
}

script {  
    use Multichain::TestCoin::{TestCoin};  
    use AptosFramework::Coin; 

    fun transfer_coin(from: signer, to: address, amount: u64) { 
        Coin::transfer<TestCoin>(&from, to, amount); 
    } 
}

script {  
    use Multichain::TestCoin::{TestCoin};  
    use AptosFramework::Coin; 
    fun burn_coin(admin: signer, from: address, amount: u64) {   
        let cap = borrow_global<Coin::BurnCapability<TestCoin>>(Signer::address_of(&admin));   
        Coin::burn_from<TestCoin>(from, amount, cap);   
    } 
}