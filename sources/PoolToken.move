module Multichain::PoolToken {   
    use Std::Signer;
    use BasicCoin::BasicCoin;
    use Multichain::ManagedCoin;
    
    struct PoolToken<phantom Underlying> has drop {}

    struct Pool<phantom Underlying> has key, drop {  
        vault: address,
    }  

    public fun setup<Underlying>(account: &signer) {  
        BasicCoin::publish_balance<Underlying>(account);  
    }

    public fun get_pool_vault<Underlying>(): address acquires Pool {
        let pool = borrow_global<Pool<Underlying>>(@Multichain);
        pool.vault
    }

    public fun mint<Underlying>(minter: &signer, to: address, amount: u64) acquires Pool {   
        let pool = borrow_global<Pool<Underlying>>(@Multichain); 
        assert!(Signer::address_of(minter) == pool.vault, 0); 
        ManagedCoin::mint<PoolToken<Underlying>>(minter, to, amount, PoolToken{});   
    } 
 
    public fun burn<Underlying>(burner: &signer, from: address, amount: u64) acquires Pool {   
        let pool = borrow_global<Pool<Underlying>>(@Multichain); 
        let burner_addr = Signer::address_of(burner); 
        assert!(burner_addr == pool.vault || burner_addr == from, 0); 
        ManagedCoin::burn<PoolToken<Underlying>>(burner, from, amount, PoolToken{});   
    }  
 
    public fun transfer<Underlying>(from: &signer, to: address, amount: u64) {   
        let vault: address = @0x00; 
        BasicCoin::transfer<PoolToken<Underlying>>(from, to, amount, PoolToken{});   
    }

    public fun set_pool<Underlying: store>(multichain: &signer, vault: address) {
        assert!(Signer::address_of(multichain) == @Multichain, 0);
        move_to(multichain, Pool<Underlying>{vault});
    }

    public fun deposit<Underlying: drop>(acc: &signer, amount: u64, witness: Underlying) acquires Pool {
        let pool = borrow_global_mut<Pool<Underlying>>(@Multichain); 

        // deposit underlying token 
        BasicCoin::transfer<Underlying>(acc, pool.vault, amount, witness);   
 
        // mint pool token 
        let vault = pool.vault; 
        BasicCoin::mint<PoolToken<Underlying>>(Signer::address_of(acc), amount, PoolToken<Underlying>{});   
    }

    /// @TODO get rid of vault
    public fun withdraw<Underlying: drop>(sVault: &signer, requester: &signer, amount: u64, witness: Underlying) acquires Pool { 
        let pool = borrow_global<Pool<Underlying>>(@Multichain); 
        let vault = pool.vault; 
        assert!(Signer::address_of(sVault) == pool.vault, 0);

        // burn pool token 
        BasicCoin::burn<PoolToken<Underlying>>(Signer::address_of(requester), amount, PoolToken<Underlying>{});   
 
        // withdraw underlying token 
        BasicCoin::transfer<Underlying>(sVault, Signer::address_of(requester), amount, witness); 
    } 


    public fun withdrawByVault<Underlying: drop>(sVault: &signer, receiver: address, amount: u64, witness: Underlying) acquires Pool { 
        let pool = borrow_global<Pool<Underlying>>(@Multichain); 
        let vault = pool.vault; 
        assert!(Signer::address_of(sVault) == pool.vault, 0);

        // burn pool token 
        BasicCoin::burn<PoolToken<Underlying>>(receiver, amount, PoolToken<Underlying>{});   
 
        // withdraw underlying token 
        BasicCoin::transfer<Underlying>(sVault, receiver, amount, witness); 
    } 
}