module Multichain::PoolCoin { 
    use Std::ASCII;   
    use Std::Signer; 
    use Std::Errors;
    use AptosFramework::Coin::{Self, BurnCapability, MintCapability}; 
    use AptosFramework::TypeInfo;
     
    struct PoolCoin<CoinType> has key {
    } 

    struct Vault<CoinType> has key, store {
        coin: Coin::Coin<CoinType>,
    } 

    struct Capabilities<CoinType: store> has key, store {
        mint_cap: MintCapability<PoolCoin<CoinType>>,
        burn_cap: BurnCapability<PoolCoin<CoinType>>,
    }

    public fun initialize<CoinType: store>(admin: &signer, name: vector<u8>, symbol: vector<u8>, decimals: u64) {
        let (mint_cap, burn_cap) = Coin::initialize<PoolCoin<CoinType>>(
            admin,
            ASCII::string(name),
            ASCII::string(symbol),
            decimals, /* decimals */
            false, /* monitor_supply */
        );

        move_to(admin, Capabilities<CoinType> { mint_cap, burn_cap } );

        let admin_addr = Signer::address_of(admin);

        assert!(
            !exists<Vault<CoinType>>(admin_addr),
            Errors::already_published(1),
        );

        let vault = Vault<CoinType> {
            coin: Coin::zero<CoinType>(),
        };
        move_to(admin, vault);
    }
 
    public(script) fun deposit<CoinType: store>(account: &signer, amount: u64) acquires Vault, Capabilities {  
        let type_info = TypeInfo::type_of<Vault<CoinType>>();
        let vault_address = TypeInfo::account_address(&type_info);
        
        // deposit underlying token  
        let vault_coin = &mut borrow_global_mut<Vault<CoinType>>(vault_address).coin;  
        let deposit_coin = Coin::withdraw<CoinType>(account, amount);
        Coin::merge<CoinType>(vault_coin, deposit_coin);
  
        // mint pool token  
        let cap = borrow_global<Capabilities<CoinType>>(vault_address);  
        let coins_minted = Coin::mint<PoolCoin<CoinType>>(amount, &cap.mint_cap); 
        Coin::deposit<PoolCoin<CoinType>>(Signer::address_of(account), coins_minted); 
    } 
 
    public(script) fun withdraw<CoinType: store>(account: &signer, amount: u64) acquires Vault, Capabilities {  
        let type_info = TypeInfo::type_of<Vault<CoinType>>();
        let vault_address = TypeInfo::account_address(&type_info);

        // burn pool token
        let cap = borrow_global<Capabilities<CoinType>>(vault_address);  
        let coins_burned = Coin::withdraw(account, amount);
        Coin::burn(coins_burned, &cap.burn_cap);

        // withdraw underlying token  
        let vault_coin = &mut borrow_global_mut<Vault<CoinType>>(vault_address).coin;  
        let withdraw_coin = Coin::extract(vault_coin, amount);
        Coin::deposit<CoinType>(Signer::address_of(account), withdraw_coin);
    }

    // liquidity providers should not use this function, or coin will get lost
    public(script) fun depositByVault<CoinType: store>(deposit_coin: Coin::Coin<CoinType>) acquires Vault {  
        let type_info = TypeInfo::type_of<Vault<CoinType>>();
        let vault_address = TypeInfo::account_address(&type_info);
        
        // deposit underlying token  
        let vault_coin = &mut borrow_global_mut<Vault<CoinType>>(vault_address).coin;  
        Coin::merge<CoinType>(vault_coin, deposit_coin);
    }
 
    public(script) fun withdrawByVault<CoinType: store>(account: &signer, amount: u64): Coin::Coin<CoinType> acquires Vault {  
        let type_info = TypeInfo::type_of<Vault<CoinType>>();
        let vault_address = TypeInfo::account_address(&type_info);

        assert(
            Signer::address_of(account) == vault_address,
            Errors::requires_capability(2),
        );

        // withdraw underlying token  
        let vault_coin = &mut borrow_global_mut<Vault<CoinType>>(vault_address).coin;  
        Coin::extract(vault_coin, amount)
    }  
}