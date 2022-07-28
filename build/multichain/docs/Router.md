
<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router"></a>

# Module `0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2::Router`



-  [Resource `MintCap`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_MintCap)
-  [Resource `BurnCap`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_BurnCap)
-  [Resource `TokenInfo`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_TokenInfo)
-  [Function `set_coin`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_set_coin)
-  [Function `approve_coin`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_approve_coin)
-  [Function `swapout`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_swapout)
-  [Function `swapin`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_swapin)


<pre><code><b>use</b> <a href="">0x1::Coin</a>;
<b>use</b> <a href="">0x1::Errors</a>;
<b>use</b> <a href="">0x1::Signer</a>;
<b>use</b> <a href="">0x1::TypeInfo</a>;
<b>use</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin">0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2::PoolCoin</a>;
</code></pre>



<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_MintCap"></a>

## Resource `MintCap`



<pre><code><b>struct</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_MintCap">MintCap</a>&lt;CoinType: store&gt; <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>cap: <a href="_MintCapability">Coin::MintCapability</a>&lt;CoinType&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_BurnCap"></a>

## Resource `BurnCap`



<pre><code><b>struct</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_BurnCap">BurnCap</a>&lt;CoinType: store&gt; <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>cap: <a href="_BurnCapability">Coin::BurnCapability</a>&lt;CoinType&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_TokenInfo"></a>

## Resource `TokenInfo`



<pre><code><b>struct</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_TokenInfo">TokenInfo</a>&lt;CoinType&gt; <b>has</b> key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>mode: u8</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_set_coin"></a>

## Function `set_coin`



<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_set_coin">set_coin</a>&lt;CoinType: drop&gt;(admin: &signer, mode: u8)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_set_coin">set_coin</a>&lt;CoinType: drop&gt;(admin: &signer, mode: u8) {
    <b>move_to</b>(admin, <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_TokenInfo">TokenInfo</a>&lt;CoinType&gt;{mode});
}
</code></pre>



</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_approve_coin"></a>

## Function `approve_coin`



<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_approve_coin">approve_coin</a>&lt;CoinType: store&gt;(multichain: &signer, mint_cap: <a href="_MintCapability">Coin::MintCapability</a>&lt;CoinType&gt;, burn_cap: <a href="_BurnCapability">Coin::BurnCapability</a>&lt;CoinType&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_approve_coin">approve_coin</a>&lt;CoinType: store&gt;(multichain: &signer, mint_cap: MintCapability&lt;CoinType&gt;, burn_cap: BurnCapability&lt;CoinType&gt;) {
    <b>move_to</b>(multichain, <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_MintCap">MintCap</a>&lt;CoinType&gt; { cap: mint_cap });
    <b>move_to</b>(multichain, <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_BurnCap">BurnCap</a>&lt;CoinType&gt; { cap: burn_cap });
}
</code></pre>



</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_swapout"></a>

## Function `swapout`



<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_swapout">swapout</a>&lt;CoinType: store&gt;(account: &signer, amount: u64, _receiver: vector&lt;u8&gt;, _toChainID: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_swapout">swapout</a>&lt;CoinType: store&gt;(account: &signer, amount: u64, _receiver: vector&lt;u8&gt;, _toChainID: u64) <b>acquires</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_BurnCap">BurnCap</a>, <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_TokenInfo">TokenInfo</a> {
    <b>let</b> type_info = <a href="_type_of">TypeInfo::type_of</a>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_TokenInfo">TokenInfo</a>&lt;CoinType&gt;&gt;();
    <b>let</b> admin_address = <a href="_account_address">TypeInfo::account_address</a>(&type_info);

    <b>let</b> tokenInfo = <b>borrow_global</b>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_TokenInfo">TokenInfo</a>&lt;CoinType&gt;&gt;(admin_address);
    <b>if</b> (tokenInfo.mode == 1) {
        // CoinType is UnderlyingCoin, not <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin">PoolCoin</a>
        <b>let</b> coin = <a href="_withdraw">Coin::withdraw</a>&lt;CoinType&gt;(account, amount);
        <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_depositByVault">PoolCoin::depositByVault</a>&lt;CoinType&gt;(coin);
    };
    <b>let</b> burn_cap = <b>borrow_global</b>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_BurnCap">BurnCap</a>&lt;CoinType&gt;&gt;(admin_address);
    <a href="_burn_from">Coin::burn_from</a>&lt;CoinType&gt;(<a href="_address_of">Signer::address_of</a>(account), amount, &burn_cap.cap);
    // emit LogSwapout(txid, amount, receiver, toChainID)
}
</code></pre>



</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_swapin"></a>

## Function `swapin`



<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_swapin">swapin</a>&lt;CoinType: store&gt;(admin: &signer, receiver: <b>address</b>, amount: u64, _fromEvent: vector&lt;u8&gt;, _fromChainID: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_swapin">swapin</a>&lt;CoinType: store&gt;(admin: &signer, receiver: <b>address</b>, amount: u64, _fromEvent: vector&lt;u8&gt;, _fromChainID: u64) <b>acquires</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_MintCap">MintCap</a>,<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_TokenInfo">TokenInfo</a> {
    <b>let</b> type_info = <a href="_type_of">TypeInfo::type_of</a>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_TokenInfo">TokenInfo</a>&lt;CoinType&gt;&gt;();
    <b>let</b> admin_address = <a href="_account_address">TypeInfo::account_address</a>(&type_info);
    <b>assert</b>!(admin_address == <a href="_address_of">Signer::address_of</a>(admin), <a href="_requires_capability">Errors::requires_capability</a>(2));

    <b>let</b> tokenInfo = <b>borrow_global</b>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_TokenInfo">TokenInfo</a>&lt;CoinType&gt;&gt;(admin_address);
    <b>if</b> (tokenInfo.mode == 1) {
        // CoinType is UnderlyingCoin, not <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin">PoolCoin</a>
        <b>let</b> coin = <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_withdrawByVault">PoolCoin::withdrawByVault</a>&lt;CoinType&gt;(admin, amount);
        <a href="_deposit">Coin::deposit</a>&lt;CoinType&gt;(receiver, coin);
    };
    <b>let</b> mint_cap = <b>borrow_global</b>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_Router_MintCap">MintCap</a>&lt;CoinType&gt;&gt;(admin_address);
    <b>let</b> coins_minted = <a href="_mint">Coin::mint</a>&lt;CoinType&gt;(amount, &mint_cap.cap);
    <a href="_deposit">Coin::deposit</a>&lt;CoinType&gt;(receiver, coins_minted);
    // emit LogSwapin(amount, receiver, fromChainID)
}
</code></pre>



</details>
