
<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin"></a>

# Module `0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2::PoolCoin`



-  [Resource `PoolCoin`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_PoolCoin)
-  [Resource `Vault`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault)
-  [Resource `Capabilities`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Capabilities)
-  [Function `initialize`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_initialize)
-  [Function `deposit`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_deposit)
-  [Function `withdraw`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_withdraw)
-  [Function `depositByVault`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_depositByVault)
-  [Function `withdrawByVault`](#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_withdrawByVault)


<pre><code><b>use</b> <a href="">0x1::ASCII</a>;
<b>use</b> <a href="">0x1::Coin</a>;
<b>use</b> <a href="">0x1::Errors</a>;
<b>use</b> <a href="">0x1::Signer</a>;
<b>use</b> <a href="">0x1::TypeInfo</a>;
</code></pre>



<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_PoolCoin"></a>

## Resource `PoolCoin`



<pre><code><b>struct</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin">PoolCoin</a>&lt;CoinType&gt; <b>has</b> key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>dummy_field: bool</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault"></a>

## Resource `Vault`



<pre><code><b>struct</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt; <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>coin: <a href="_Coin">Coin::Coin</a>&lt;CoinType&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Capabilities"></a>

## Resource `Capabilities`



<pre><code><b>struct</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Capabilities">Capabilities</a>&lt;CoinType: store&gt; <b>has</b> store, key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>mint_cap: <a href="_MintCapability">Coin::MintCapability</a>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_PoolCoin">PoolCoin::PoolCoin</a>&lt;CoinType&gt;&gt;</code>
</dt>
<dd>

</dd>
<dt>
<code>burn_cap: <a href="_BurnCapability">Coin::BurnCapability</a>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_PoolCoin">PoolCoin::PoolCoin</a>&lt;CoinType&gt;&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_initialize"></a>

## Function `initialize`



<pre><code><b>public</b> <b>fun</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_initialize">initialize</a>&lt;CoinType: store&gt;(admin: &signer, name: vector&lt;u8&gt;, symbol: vector&lt;u8&gt;, decimals: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_initialize">initialize</a>&lt;CoinType: store&gt;(admin: &signer, name: vector&lt;u8&gt;, symbol: vector&lt;u8&gt;, decimals: u64) {
    <b>let</b> (mint_cap, burn_cap) = <a href="_initialize">Coin::initialize</a>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin">PoolCoin</a>&lt;CoinType&gt;&gt;(
        admin,
        <a href="_string">ASCII::string</a>(name),
        <a href="_string">ASCII::string</a>(symbol),
        decimals, /* decimals */
        <b>false</b>, /* monitor_supply */
    );

    <b>move_to</b>(admin, <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Capabilities">Capabilities</a>&lt;CoinType&gt; { mint_cap, burn_cap } );

    <b>let</b> admin_addr = <a href="_address_of">Signer::address_of</a>(admin);

    <b>assert</b>!(
        !<b>exists</b>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt;&gt;(admin_addr),
        <a href="_already_published">Errors::already_published</a>(1),
    );

    <b>let</b> vault = <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt; {
        coin: <a href="_zero">Coin::zero</a>&lt;CoinType&gt;(),
    };
    <b>move_to</b>(admin, vault);
}
</code></pre>



</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_deposit"></a>

## Function `deposit`



<pre><code><b>public</b>(<b>script</b>) <b>fun</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_deposit">deposit</a>&lt;CoinType: store&gt;(account: &signer, amount: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(<b>script</b>) <b>fun</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_deposit">deposit</a>&lt;CoinType: store&gt;(account: &signer, amount: u64) <b>acquires</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>, <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Capabilities">Capabilities</a> {
    <b>let</b> type_info = <a href="_type_of">TypeInfo::type_of</a>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt;&gt;();
    <b>let</b> vault_address = <a href="_account_address">TypeInfo::account_address</a>(&type_info);

    // deposit underlying token
    <b>let</b> vault_coin = &<b>mut</b> <b>borrow_global_mut</b>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt;&gt;(vault_address).coin;
    <b>let</b> deposit_coin = <a href="_withdraw">Coin::withdraw</a>&lt;CoinType&gt;(account, amount);
    <a href="_merge">Coin::merge</a>&lt;CoinType&gt;(vault_coin, deposit_coin);

    // mint pool token
    <b>let</b> cap = <b>borrow_global</b>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Capabilities">Capabilities</a>&lt;CoinType&gt;&gt;(vault_address);
    <b>let</b> coins_minted = <a href="_mint">Coin::mint</a>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin">PoolCoin</a>&lt;CoinType&gt;&gt;(amount, &cap.mint_cap);
    <a href="_deposit">Coin::deposit</a>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin">PoolCoin</a>&lt;CoinType&gt;&gt;(<a href="_address_of">Signer::address_of</a>(account), coins_minted);
}
</code></pre>



</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_withdraw"></a>

## Function `withdraw`



<pre><code><b>public</b>(<b>script</b>) <b>fun</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_withdraw">withdraw</a>&lt;CoinType: store&gt;(account: &signer, amount: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(<b>script</b>) <b>fun</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_withdraw">withdraw</a>&lt;CoinType: store&gt;(account: &signer, amount: u64) <b>acquires</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>, <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Capabilities">Capabilities</a> {
    <b>let</b> type_info = <a href="_type_of">TypeInfo::type_of</a>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt;&gt;();
    <b>let</b> vault_address = <a href="_account_address">TypeInfo::account_address</a>(&type_info);

    // burn pool token
    <b>let</b> cap = <b>borrow_global</b>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Capabilities">Capabilities</a>&lt;CoinType&gt;&gt;(vault_address);
    <b>let</b> coins_burned = <a href="_withdraw">Coin::withdraw</a>(account, amount);
    <a href="_burn">Coin::burn</a>(coins_burned, &cap.burn_cap);

    // withdraw underlying token
    <b>let</b> vault_coin = &<b>mut</b> <b>borrow_global_mut</b>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt;&gt;(vault_address).coin;
    <b>let</b> withdraw_coin = <a href="_extract">Coin::extract</a>(vault_coin, amount);
    <a href="_deposit">Coin::deposit</a>&lt;CoinType&gt;(<a href="_address_of">Signer::address_of</a>(account), withdraw_coin);
}
</code></pre>



</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_depositByVault"></a>

## Function `depositByVault`



<pre><code><b>public</b>(<b>script</b>) <b>fun</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_depositByVault">depositByVault</a>&lt;CoinType: store&gt;(deposit_coin: <a href="_Coin">Coin::Coin</a>&lt;CoinType&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(<b>script</b>) <b>fun</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_depositByVault">depositByVault</a>&lt;CoinType: store&gt;(deposit_coin: <a href="_Coin">Coin::Coin</a>&lt;CoinType&gt;) <b>acquires</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a> {
    <b>let</b> type_info = <a href="_type_of">TypeInfo::type_of</a>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt;&gt;();
    <b>let</b> vault_address = <a href="_account_address">TypeInfo::account_address</a>(&type_info);

    // deposit underlying token
    <b>let</b> vault_coin = &<b>mut</b> <b>borrow_global_mut</b>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt;&gt;(vault_address).coin;
    <a href="_merge">Coin::merge</a>&lt;CoinType&gt;(vault_coin, deposit_coin);
}
</code></pre>



</details>

<a name="0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_withdrawByVault"></a>

## Function `withdrawByVault`



<pre><code><b>public</b>(<b>script</b>) <b>fun</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_withdrawByVault">withdrawByVault</a>&lt;CoinType: store&gt;(account: &signer, amount: u64): <a href="_Coin">Coin::Coin</a>&lt;CoinType&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(<b>script</b>) <b>fun</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_withdrawByVault">withdrawByVault</a>&lt;CoinType: store&gt;(account: &signer, amount: u64): <a href="_Coin">Coin::Coin</a>&lt;CoinType&gt; <b>acquires</b> <a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a> {
    <b>let</b> type_info = <a href="_type_of">TypeInfo::type_of</a>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt;&gt;();
    <b>let</b> vault_address = <a href="_account_address">TypeInfo::account_address</a>(&type_info);

    <b>assert</b>!(
        <a href="_address_of">Signer::address_of</a>(account) == vault_address,
        <a href="_requires_capability">Errors::requires_capability</a>(2),
    );

    // withdraw underlying token
    <b>let</b> vault_coin = &<b>mut</b> <b>borrow_global_mut</b>&lt;<a href="PoolCoin.md#0x4e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2_PoolCoin_Vault">Vault</a>&lt;CoinType&gt;&gt;(vault_address).coin;
    <a href="_extract">Coin::extract</a>(vault_coin, amount)
}
</code></pre>



</details>
