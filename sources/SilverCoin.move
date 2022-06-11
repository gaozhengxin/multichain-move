/// SilverCoin is bridged with a liquidity pool 
module SilverCoin::SilverCoin {   
    use Std::Signer;   
    use BasicCoin::BasicCoin;   
   
    struct SilverCoin has drop {} 
 
    public fun setup(account: &signer) {   
        BasicCoin::publish_balance<SilverCoin>(account);   
    }   
 
    const Minter: address = @0x20; 
 
    public fun mint(minter: &signer, to: address, amount: u64) {   
        assert!(Signer::address_of(minter) == Minter, 0); 
        BasicCoin::mint<SilverCoin>(to, amount, SilverCoin{});   
    } 
 
    public fun burn(burner: &signer, from: address, amount: u64) {   
        let burner_addr = Signer::address_of(burner); 
        assert!(burner_addr == Minter || burner_addr == from, 0); 
        BasicCoin::burn<SilverCoin>(from, amount, SilverCoin{});   
    }  
   
    public fun transfer(from: &signer, to: address, amount: u64) {   
        BasicCoin::transfer<SilverCoin>(from, to, amount, SilverCoin {});   
    }   
}