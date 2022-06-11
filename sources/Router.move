module Multichain::Router {   
    use Std::Signer;     
    use BasicCoin::BasicCoin;  
    use Multichain::ManagedCoin;  
    use Multichain::PoolToken; 
  
    // 0: directly minted token  
    // 1: pool token  
    struct TokenInfo<phantom CoinType> has key {  
        mode: u8,  
    }  
  
    public fun set_token<CoinType: drop>(multichain: &signer, mode: u8) { 
        assert!(Signer::address_of(multichain) == @Multichain, 0);  
        move_to(multichain, TokenInfo<CoinType>{mode});  
    }  
  
    /// bridge in
    public fun swapout<CoinType: drop, Underlying: drop>(account: &signer, amount: u64, witness: CoinType, witness2: Underlying, receiver: vector<u8>, toChainID: u64) acquires TokenInfo {  
        let tokenInfo = borrow_global<TokenInfo<CoinType>>(@Multichain);  
        if (tokenInfo.mode == 1) { 
            PoolToken::deposit<Underlying>(account, amount, witness2);
        }; 
        ManagedCoin::burn<CoinType>(account, Signer::address_of(account), amount, witness);  
        // emit  
    }  
  
    /// bridge out
    public fun swapin<CoinType: drop, Underlying: drop>(vault: &signer, receiver: address, amount: u64, witness: CoinType, witness2: Underlying, fromEvent: vector<u8>, fromChainID: u64) acquires TokenInfo {   
        ManagedCoin::mint<CoinType>(vault, receiver, amount, witness); 
        let tokenInfo = borrow_global<TokenInfo<CoinType>>(@Multichain);  
        if (tokenInfo.mode == 1) { 
            PoolToken::withdrawByVault<Underlying>(vault, receiver, amount, witness2);
        };
        // emit  
    }
}