script { 
    use GoldCoin::GoldCoin; 
 
    fun transfer(from: signer, to: address, amount: u64) { 
        GoldCoin::transfer(&from, to, amount); 
    } 
}