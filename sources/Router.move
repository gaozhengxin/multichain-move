module Multichain::Router {
    use Std::Errors;
    use Std::Signer;
    use AptosFramework::Coin::{Self, BurnCapability, MintCapability};

    struct MintCap<CoinType: store> has key, store {
        cap: MintCapability<CoinType>,
    }

    struct BurnCap<CoinType: store> has key, store {
        cap: BurnCapability<CoinType>,
    }

    // 0: directly minted token  
    // 1: pool token  
    struct TokenInfo<phantom CoinType> has key {  
        mode: u8,  
    }  
  
    public fun set_coin<CoinType: drop>(multichain: &signer, mode: u8) { 
        assert!(Signer::address_of(multichain) == @Multichain, 0);  
        move_to(multichain, TokenInfo<CoinType>{mode});  
    }  

    public fun approve_coin<CoinType: store>(mint_cap: MintCapability<CoinType>, burn_cap: BurnCapability<CoinType>) {
        move_to(@Multichain, MintCap<CoinType> { cap: copy mint_cap });
        move_to(@Multichain, BurnCap<CoinType> { cap: copy burn_cap });
    }

    public(script) fun swapout<CoinType: store>(account: &signer, amount: u64, receiver: vector<u8>, toChainID: u64) acquires BurnCap, TokenInfo {  
        let tokenInfo = borrow_global<TokenInfo<CoinType>>(@Multichain);  
        if (tokenInfo.mode == 1) { 
            // TODO
        };
        let burn_cap = borrow_global<BurnCap<CoinType>>(@Multichain);  
        Coin::burn_from<CoinType>(Signer::address_of(account), amount, &burn_cap.cap);  
        // emit  
    } 

    public(script) fun swapin<CoinType: store>(receiver: address, amount: u64, fromEvent: vector<u8>, fromChainID: u64) acquires MintCap,TokenInfo {   
        let tokenInfo = borrow_global<TokenInfo<CoinType>>(@Multichain);  
        if (tokenInfo.mode == 1) { 
            // TODO
        };
        let mint_cap = borrow_global<MintCap<CoinType>>(@Multichain);
        let coins_minted = Coin::mint<CoinType>(amount, &mint_cap.cap);
        Coin::deposit<CoinType>(receiver, coins_minted);
        // emit
    }
}