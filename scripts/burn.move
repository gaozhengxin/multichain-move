script {  
    use GoldCoin::GoldCoin;  
  
    /// Script to mint coins and deposit coins to account.  
    /// Recipient should has created `Balance` resource on his account, so see `create_balance.move` script.  
    fun burn(minter: signer, from: address, amount: u64) {  
        GoldCoin::burn(&minter, from, amount);  
    }  
}