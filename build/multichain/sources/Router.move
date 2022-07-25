module Multichain::Router {
    use Std::Errors;
    use Std::Signer;
    use AptosFramework::Coin::{Self, BurnCapability, MintCapability};
    use AptosFramework::TypeInfo;
    use Multichain::PoolCoin;

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

    public(script) fun swapout<CoinType: store>(account: &signer, amount: u64, _receiver: vector<u8>, _toChainID: u64) acquires BurnCap, TokenInfo {  
        let type_info = TypeInfo::type_of<TokenInfo<CoinType>>();
        let admin_address = TypeInfo::account_address(&type_info);

        let tokenInfo = borrow_global<TokenInfo<CoinType>>(admin_address);  
        if (tokenInfo.mode == 1) { 
            // CoinType is UnderlyingCoin, not PoolCoin
            let coin = Coin::withdraw<CoinType>(account, amount);
            PoolCoin::depositByVault<CoinType>(coin);
        };
        let burn_cap = borrow_global<BurnCap<CoinType>>(admin_address);  
        Coin::burn_from<CoinType>(Signer::address_of(account), amount, &burn_cap.cap);  
        // emit LogSwapout(txid, amount, receiver, toChainID)
    } 

    public(script) fun swapin<CoinType: store>(admin: &signer, receiver: address, amount: u64, _fromEvent: vector<u8>, _fromChainID: u64) acquires MintCap,TokenInfo {   
        let type_info = TypeInfo::type_of<TokenInfo<CoinType>>();
        let admin_address = TypeInfo::account_address(&type_info);
        assert!(admin_address == Signer::address_of(admin), Errors::requires_capability(2));

        let tokenInfo = borrow_global<TokenInfo<CoinType>>(admin_address);  
        if (tokenInfo.mode == 1) { 
            // CoinType is UnderlyingCoin, not PoolCoin
            let coin = PoolCoin::withdrawByVault<CoinType>(admin, amount);
            Coin::deposit<CoinType>(receiver, coin);
        };
        let mint_cap = borrow_global<MintCap<CoinType>>(admin_address);
        let coins_minted = Coin::mint<CoinType>(amount, &mint_cap.cap);
        Coin::deposit<CoinType>(receiver, coins_minted);
        // emit LogSwapin(amount, receiver, fromChainID)
    }
}