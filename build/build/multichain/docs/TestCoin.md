
<a name="0x2_TestCoin"></a>

# Module `0x2::TestCoin`

The module to show how to create a new coin on Aptos network.


-  [Struct `MyCoin`](#0x2_TestCoin_MyCoin)
-  [Resource `Capability`](#0x2_TestCoin_Capability)
-  [Constants](#@Constants_0)
-  [Function `initialize_internal`](#0x2_TestCoin_initialize_internal)
-  [Function `initialize`](#0x2_TestCoin_initialize)
-  [Function `extract_capability`](#0x2_TestCoin_extract_capability)
-  [Function `put_capability`](#0x2_TestCoin_put_capability)


<pre><code><b>use</b> <a href="">0x1::ASCII</a>;
<b>use</b> <a href="">0x1::Coin</a>;
<b>use</b> <a href="">0x1::Signer</a>;
</code></pre>



<a name="0x2_TestCoin_MyCoin"></a>

## Struct `MyCoin`

Represents new user coin.
Indeeed this type will be used as CoinType for your new coin.


<pre><code><b>struct</b> <a href="TestCoin.md#0x2_TestCoin_MyCoin">MyCoin</a>
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

<a name="0x2_TestCoin_Capability"></a>

## Resource `Capability`

The struct to store capability: mint and burn.


<pre><code><b>struct</b> <a href="TestCoin.md#0x2_TestCoin_Capability">Capability</a>&lt;CapType: store&gt; <b>has</b> key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>cap: CapType</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="0x2_TestCoin_ERR_CAP_EXISTS"></a>

When capability already exists on account.


<pre><code><b>const</b> <a href="TestCoin.md#0x2_TestCoin_ERR_CAP_EXISTS">ERR_CAP_EXISTS</a>: u64 = 101;
</code></pre>



<a name="0x2_TestCoin_ERR_CAP_MISSED"></a>

When capability is missed on account.


<pre><code><b>const</b> <a href="TestCoin.md#0x2_TestCoin_ERR_CAP_MISSED">ERR_CAP_MISSED</a>: u64 = 100;
</code></pre>



<a name="0x2_TestCoin_initialize_internal"></a>

## Function `initialize_internal`

Initializing <code><a href="TestCoin.md#0x2_TestCoin_MyCoin">MyCoin</a></code> as coin in Aptos network.


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0x2_TestCoin_initialize_internal">initialize_internal</a>(account: &signer)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0x2_TestCoin_initialize_internal">initialize_internal</a>(account: &signer) {
    // Initialize `<a href="TestCoin.md#0x2_TestCoin_MyCoin">MyCoin</a>` <b>as</b> coin type using Aptos Framework.
    <b>let</b> (mint_cap, burn_cap) = <a href="_initialize">Coin::initialize</a>&lt;<a href="TestCoin.md#0x2_TestCoin_MyCoin">MyCoin</a>&gt;(
        account,
        string(b"<a href="TestCoin.md#0x2_TestCoin_MyCoin">MyCoin</a>"),
        string(b"MC"),
        10,
        <b>true</b>,
    );

    // Store mint and burn capabilities under user account.
    <b>move_to</b>(account, <a href="TestCoin.md#0x2_TestCoin_Capability">Capability</a> { cap: mint_cap });
    <b>move_to</b>(account, <a href="TestCoin.md#0x2_TestCoin_Capability">Capability</a> { cap: burn_cap });
}
</code></pre>



</details>

<a name="0x2_TestCoin_initialize"></a>

## Function `initialize`

Similar to <code>initialize_internal</code> but can be executed as script.


<pre><code><b>public</b>(<b>script</b>) <b>fun</b> <a href="TestCoin.md#0x2_TestCoin_initialize">initialize</a>(account: &signer)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(<b>script</b>) <b>fun</b> <a href="TestCoin.md#0x2_TestCoin_initialize">initialize</a>(account: &signer) {
    <a href="TestCoin.md#0x2_TestCoin_initialize">initialize</a>(account);
}
</code></pre>



</details>

<a name="0x2_TestCoin_extract_capability"></a>

## Function `extract_capability`

Extract mint or burn capability from user account.
Returns extracted capability.


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0x2_TestCoin_extract_capability">extract_capability</a>&lt;CapType: store&gt;(account: &signer): CapType
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0x2_TestCoin_extract_capability">extract_capability</a>&lt;CapType: store&gt;(account: &signer): CapType <b>acquires</b> <a href="TestCoin.md#0x2_TestCoin_Capability">Capability</a> {
    <b>let</b> account_addr = <a href="_address_of">Signer::address_of</a>(account);

    // Check <b>if</b> capability stored under account.
    <b>assert</b>!(<b>exists</b>&lt;<a href="TestCoin.md#0x2_TestCoin_Capability">Capability</a>&lt;CapType&gt;&gt;(account_addr), <a href="TestCoin.md#0x2_TestCoin_ERR_CAP_MISSED">ERR_CAP_MISSED</a>);

    // Get capability stored under account.
    <b>let</b> <a href="TestCoin.md#0x2_TestCoin_Capability">Capability</a> { cap } =  <b>move_from</b>&lt;<a href="TestCoin.md#0x2_TestCoin_Capability">Capability</a>&lt;CapType&gt;&gt;(account_addr);
    cap
}
</code></pre>



</details>

<a name="0x2_TestCoin_put_capability"></a>

## Function `put_capability`

Put mint or burn <code>capability</code> under user account.


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0x2_TestCoin_put_capability">put_capability</a>&lt;CapType: store&gt;(account: &signer, capability: CapType)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0x2_TestCoin_put_capability">put_capability</a>&lt;CapType: store&gt;(account: &signer, capability: CapType) {
    <b>let</b> account_addr = <a href="_address_of">Signer::address_of</a>(account);

    // Check <b>if</b> capability doesn't exist under account so we can store.
    <b>assert</b>!(!<b>exists</b>&lt;<a href="TestCoin.md#0x2_TestCoin_Capability">Capability</a>&lt;CapType&gt;&gt;(account_addr), <a href="TestCoin.md#0x2_TestCoin_ERR_CAP_EXISTS">ERR_CAP_EXISTS</a>);

    // Store capability.
    <b>move_to</b>(account, <a href="TestCoin.md#0x2_TestCoin_Capability">Capability</a>&lt;CapType&gt; {
        cap: capability
    });
}
</code></pre>



</details>
