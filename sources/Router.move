module multichain::router {
    use std::errors;
    use std::signer;
    use aptos_framework::coin::{Self, BurnCapability, MintCapability};
    use aptos_framework::type_info;
    use multichain::poolCoin;

    struct MintCap<phantom CoinType: store> has key, store {
        cap: MintCapability<CoinType>,
    }

    struct BurnCap<phantom CoinType: store> has key, store {
        cap: BurnCapability<CoinType>,
    }

    // 0: directly minted token  
    // 1: pool token  
    struct TokenInfo<phantom CoinType> has key {  
        mode: u8,  
    }  
  
    public fun set_coin<CoinType: drop>(admin: &signer, mode: u8) { 
        move_to(admin, TokenInfo<CoinType>{mode});  
    }  

    public fun approve_coin<CoinType: store>(multichain: &signer, mint_cap: MintCapability<CoinType>, burn_cap: BurnCapability<CoinType>) {
        move_to(multichain, MintCap<CoinType> { cap: mint_cap });
        move_to(multichain, BurnCap<CoinType> { cap: burn_cap });
    }

    public entry fun swapout<CoinType: store>(account: &signer, amount: u64, _receiver: vector<u8>, _toChainID: u64) acquires BurnCap, TokenInfo {  
        let typeInfo = type_info::type_of<TokenInfo<CoinType>>();
        let admin_address = type_info::account_address(&typeInfo);

        let tokenInfo = borrow_global<TokenInfo<CoinType>>(admin_address);  
        if (tokenInfo.mode == 1) { 
            // CoinType is UnderlyingCoin, not PoolCoin
            let coin = coin::withdraw<CoinType>(account, amount);
            poolCoin::depositByVault<CoinType>(coin);
        };
        let burn_cap = borrow_global<BurnCap<CoinType>>(admin_address);  
        coin::burn_from<CoinType>(signer::address_of(account), amount, &burn_cap.cap);  
        // emit LogSwapout(txid, amount, receiver, toChainID)
    } 

    public entry fun swapin<CoinType: store>(admin: &signer, receiver: address, amount: u64, _fromEvent: vector<u8>, _fromChainID: u64) acquires MintCap,TokenInfo {   
        let typeInfo = type_info::type_of<TokenInfo<CoinType>>();
        let admin_address = type_info::account_address(&typeInfo);
        assert!(admin_address == signer::address_of(admin), errors::requires_capability(2));

        let tokenInfo = borrow_global<TokenInfo<CoinType>>(admin_address);  
        if (tokenInfo.mode == 1) { 
            // CoinType is UnderlyingCoin, not PoolCoin
            let coin = poolCoin::withdrawByVault<CoinType>(admin, amount);
            coin::deposit<CoinType>(receiver, coin);
        };
        let mint_cap = borrow_global<MintCap<CoinType>>(admin_address);
        let coins_minted = coin::mint<CoinType>(amount, &mint_cap.cap);
        coin::deposit<CoinType>(receiver, coins_minted);
        // emit LogSwapin(amount, receiver, fromChainID)
    }
}