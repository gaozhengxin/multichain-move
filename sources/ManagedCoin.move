module Multichain::ManagedCoin {   
    use BasicCoin::BasicCoin;   
   
    public fun setup<CoinType: drop>(account: &signer) {   
        BasicCoin::publish_balance<CoinType>(account);   
    }   
 
    public fun mint<CoinType: drop>(minter: &signer, to: address, amount: u64, witness: CoinType) {   
        BasicCoin::mint<CoinType>(to, amount, witness);   
    } 
 
    public fun burn<CoinType: drop>(burner: &signer, from: address, amount: u64, witness: CoinType) {   
        BasicCoin::burn<CoinType>(from, amount, witness);   
    }  
}