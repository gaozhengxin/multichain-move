/// GoldCoin is directly minted by bridge
module GoldCoin::GoldCoin {  
    use Std::Signer;  
    use BasicCoin::BasicCoin;  
    use Multichain::ManagedCoin;  
  
    struct GoldCoin has drop {}

    public fun setup(account: &signer) {  
        BasicCoin::publish_balance<GoldCoin>(account);  
    }  

    const Minter: address = @0x20;

    public fun mint(minter: &signer, to: address, amount: u64) {  
        assert!(Signer::address_of(minter) == Minter, 0);
        ManagedCoin::mint<GoldCoin>(minter, to, amount, GoldCoin{});  
    }

    public fun burn(burner: &signer, from: address, amount: u64) {  
        let burner_addr = Signer::address_of(burner);
        assert!(burner_addr == Minter || burner_addr == from, 0);
        ManagedCoin::burn<GoldCoin>(burner, from, amount, GoldCoin{});  
    } 
  
    public fun transfer(from: &signer, to: address, amount: u64) {  
        BasicCoin::transfer<GoldCoin>(from, to, amount, GoldCoin {});  
    }  
}