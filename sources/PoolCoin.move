module multichain::poolCoin { 
    use std::string;   
    use std::signer; 
    use std::errors;
    use aptos_framework::coin::{Self, BurnCapability, MintCapability}; 
    use aptos_framework::type_info;
     
    struct PoolCoin<phantom CoinType> has key {
    } 

    struct Vault<phantom CoinType> has key, store {
        coin: coin::Coin<CoinType>,
    } 

    struct Capabilities<phantom CoinType: store> has key, store {
        mint_cap: MintCapability<PoolCoin<CoinType>>,
        burn_cap: BurnCapability<PoolCoin<CoinType>>,
    }

    public fun initialize<CoinType: store>(admin: &signer, name: vector<u8>, symbol: vector<u8>, decimals: u64) {
        let (mint_cap, burn_cap) = coin::initialize<PoolCoin<CoinType>>(
            admin,
            string::utf8(name),
            string::utf8(symbol),
            decimals, /* decimals */
            false, /* monitor_supply */
        );

        move_to(admin, Capabilities<CoinType> { mint_cap, burn_cap } );

        let admin_addr = signer::address_of(admin);

        assert!(
            !exists<Vault<CoinType>>(admin_addr),
            errors::already_published(1),
        );

        let vault = Vault<CoinType> {
            coin: coin::zero<CoinType>(),
        };
        move_to(admin, vault);
    }
 
    public entry fun deposit<CoinType: store>(account: &signer, amount: u64) acquires Vault, Capabilities {  
        let typeInfo = type_info::type_of<Vault<CoinType>>();
        let vault_address = type_info::account_address(&typeInfo);
        
        // deposit underlying token  
        let vault_coin = &mut borrow_global_mut<Vault<CoinType>>(vault_address).coin;  
        let deposit_coin = coin::withdraw<CoinType>(account, amount);
        coin::merge<CoinType>(vault_coin, deposit_coin);
  
        // mint pool token  
        let cap = borrow_global<Capabilities<CoinType>>(vault_address);  
        let coins_minted = coin::mint<PoolCoin<CoinType>>(amount, &cap.mint_cap); 
        coin::deposit<PoolCoin<CoinType>>(signer::address_of(account), coins_minted); 
    } 
 
    public entry fun withdraw<CoinType: store>(account: &signer, amount: u64) acquires Vault, Capabilities {  
        let typeInfo = type_info::type_of<Vault<CoinType>>();
        let vault_address = type_info::account_address(&typeInfo);

        // burn pool token
        let cap = borrow_global<Capabilities<CoinType>>(vault_address);  
        let coins_burned = coin::withdraw(account, amount);
        coin::burn(coins_burned, &cap.burn_cap);

        // withdraw underlying token  
        let vault_coin = &mut borrow_global_mut<Vault<CoinType>>(vault_address).coin;  
        let withdraw_coin = coin::extract(vault_coin, amount);
        coin::deposit<CoinType>(signer::address_of(account), withdraw_coin);
    }

    // liquidity providers should not use this function, or coin will get lost
    public entry fun depositByVault<CoinType: store>(deposit_coin: coin::Coin<CoinType>) acquires Vault {  
        let typeInfo = type_info::type_of<Vault<CoinType>>();
        let vault_address = type_info::account_address(&typeInfo);
        
        // deposit underlying token  
        let vault_coin = &mut borrow_global_mut<Vault<CoinType>>(vault_address).coin;  
        coin::merge<CoinType>(vault_coin, deposit_coin);
    }
 
    public entry fun withdrawByVault<CoinType: store>(account: &signer, amount: u64): coin::Coin<CoinType> acquires Vault {  
        let typeInfo = type_info::type_of<Vault<CoinType>>();
        let vault_address = type_info::account_address(&typeInfo);

        assert!(
            signer::address_of(account) == vault_address,
            errors::requires_capability(2),
        );

        // withdraw underlying token  
        let vault_coin = &mut borrow_global_mut<Vault<CoinType>>(vault_address).coin;  
        coin::extract(vault_coin, amount)
    }  
}