
<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router"></a>

# Module `0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2::router`



-  [Resource `MintCap`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_MintCap)
-  [Resource `BurnCap`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_BurnCap)
-  [Resource `TokenInfo`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_TokenInfo)
-  [Function `set_coin`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_set_coin)
-  [Function `approve_coin`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_approve_coin)
-  [Function `swapout`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_swapout)
-  [Function `swapin`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_swapin)


<pre><code><b>use</b> <a href="">0x1::coin</a>;
<b>use</b> <a href="">0x1::errors</a>;
<b>use</b> <a href="">0x1::signer</a>;
<b>use</b> <a href="">0x1::type_info</a>;
<b>use</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_poolCoin">0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2::poolCoin</a>;
</code></pre>



<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_MintCap"></a>

## Resource `MintCap`



<pre><code><b>struct</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_MintCap">MintCap</a>&lt;CoinType: store&gt; <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>cap: <a href="_MintCapability">coin::MintCapability</a>&lt;CoinType&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_BurnCap"></a>

## Resource `BurnCap`



<pre><code><b>struct</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_BurnCap">BurnCap</a>&lt;CoinType: store&gt; <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>cap: <a href="_BurnCapability">coin::BurnCapability</a>&lt;CoinType&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_TokenInfo"></a>

## Resource `TokenInfo`



<pre><code><b>struct</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_TokenInfo">TokenInfo</a>&lt;CoinType&gt; <b>has</b> key
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

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_set_coin"></a>

## Function `set_coin`



<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_set_coin">set_coin</a>&lt;CoinType: drop&gt;(admin: &<a href="">signer</a>, mode: u8)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_set_coin">set_coin</a>&lt;CoinType: drop&gt;(admin: &<a href="">signer</a>, mode: u8) {
    <b>move_to</b>(admin, <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_TokenInfo">TokenInfo</a>&lt;CoinType&gt;{mode});
}
</code></pre>



</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_approve_coin"></a>

## Function `approve_coin`



<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_approve_coin">approve_coin</a>&lt;CoinType: store&gt;(multichain: &<a href="">signer</a>, mint_cap: <a href="_MintCapability">coin::MintCapability</a>&lt;CoinType&gt;, burn_cap: <a href="_BurnCapability">coin::BurnCapability</a>&lt;CoinType&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_approve_coin">approve_coin</a>&lt;CoinType: store&gt;(multichain: &<a href="">signer</a>, mint_cap: MintCapability&lt;CoinType&gt;, burn_cap: BurnCapability&lt;CoinType&gt;) {
    <b>move_to</b>(multichain, <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_MintCap">MintCap</a>&lt;CoinType&gt; { cap: mint_cap });
    <b>move_to</b>(multichain, <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_BurnCap">BurnCap</a>&lt;CoinType&gt; { cap: burn_cap });
}
</code></pre>



</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_swapout"></a>

## Function `swapout`



<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_swapout">swapout</a>&lt;CoinType: store&gt;(account: &<a href="">signer</a>, amount: u64, _receiver: <a href="">vector</a>&lt;u8&gt;, _toChainID: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_swapout">swapout</a>&lt;CoinType: store&gt;(account: &<a href="">signer</a>, amount: u64, _receiver: <a href="">vector</a>&lt;u8&gt;, _toChainID: u64) <b>acquires</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_BurnCap">BurnCap</a>, <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_TokenInfo">TokenInfo</a> {
    <b>let</b> typeInfo = <a href="_type_of">type_info::type_of</a>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_TokenInfo">TokenInfo</a>&lt;CoinType&gt;&gt;();
    <b>let</b> admin_address = <a href="_account_address">type_info::account_address</a>(&typeInfo);

    <b>let</b> tokenInfo = <b>borrow_global</b>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_TokenInfo">TokenInfo</a>&lt;CoinType&gt;&gt;(admin_address);
    <b>if</b> (tokenInfo.mode == 1) {
        // CoinType is UnderlyingCoin, not PoolCoin
        <b>let</b> <a href="">coin</a> = <a href="_withdraw">coin::withdraw</a>&lt;CoinType&gt;(account, amount);
        <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_poolCoin_depositByVault">poolCoin::depositByVault</a>&lt;CoinType&gt;(<a href="">coin</a>);
    };
    <b>let</b> burn_cap = <b>borrow_global</b>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_BurnCap">BurnCap</a>&lt;CoinType&gt;&gt;(admin_address);
    <a href="_burn_from">coin::burn_from</a>&lt;CoinType&gt;(<a href="_address_of">signer::address_of</a>(account), amount, &burn_cap.cap);
    // emit LogSwapout(txid, amount, receiver, toChainID)
}
</code></pre>



</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_swapin"></a>

## Function `swapin`



<pre><code><b>public</b> <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_swapin">swapin</a>&lt;CoinType: store&gt;(admin: &<a href="">signer</a>, receiver: <b>address</b>, amount: u64, _fromEvent: <a href="">vector</a>&lt;u8&gt;, _fromChainID: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_swapin">swapin</a>&lt;CoinType: store&gt;(admin: &<a href="">signer</a>, receiver: <b>address</b>, amount: u64, _fromEvent: <a href="">vector</a>&lt;u8&gt;, _fromChainID: u64) <b>acquires</b> <a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_MintCap">MintCap</a>,<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_TokenInfo">TokenInfo</a> {
    <b>let</b> typeInfo = <a href="_type_of">type_info::type_of</a>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_TokenInfo">TokenInfo</a>&lt;CoinType&gt;&gt;();
    <b>let</b> admin_address = <a href="_account_address">type_info::account_address</a>(&typeInfo);
    <b>assert</b>!(admin_address == <a href="_address_of">signer::address_of</a>(admin), <a href="_requires_capability">errors::requires_capability</a>(2));

    <b>let</b> tokenInfo = <b>borrow_global</b>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_TokenInfo">TokenInfo</a>&lt;CoinType&gt;&gt;(admin_address);
    <b>if</b> (tokenInfo.mode == 1) {
        // CoinType is UnderlyingCoin, not PoolCoin
        <b>let</b> <a href="">coin</a> = <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_poolCoin_withdrawByVault">poolCoin::withdrawByVault</a>&lt;CoinType&gt;(admin, amount);
        <a href="_deposit">coin::deposit</a>&lt;CoinType&gt;(receiver, <a href="">coin</a>);
    };
    <b>let</b> mint_cap = <b>borrow_global</b>&lt;<a href="Router.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_router_MintCap">MintCap</a>&lt;CoinType&gt;&gt;(admin_address);
    <b>let</b> coins_minted = <a href="_mint">coin::mint</a>&lt;CoinType&gt;(amount, &mint_cap.cap);
    <a href="_deposit">coin::deposit</a>&lt;CoinType&gt;(receiver, coins_minted);
    // emit LogSwapin(amount, receiver, fromChainID)
}
</code></pre>



</details>
