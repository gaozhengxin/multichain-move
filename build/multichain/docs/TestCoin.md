
<a name="0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin"></a>

# Module `0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5::testCoin`

The module to show how to create a new coin on Aptos network.


-  [Struct `MyCoin`](#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_MyCoin)
-  [Resource `Capability`](#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability)
-  [Constants](#@Constants_0)
-  [Function `initialize_internal`](#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_initialize_internal)
-  [Function `initialize`](#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_initialize)
-  [Function `extract_capability`](#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_extract_capability)
-  [Function `put_capability`](#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_put_capability)


<pre><code><b>use</b> <a href="">0x1::coin</a>;
<b>use</b> <a href="">0x1::signer</a>;
<b>use</b> <a href="">0x1::string</a>;
</code></pre>



<a name="0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_MyCoin"></a>

## Struct `MyCoin`

Represents new user coin.
Indeeed this type will be used as CoinType for your new coin.


<pre><code><b>struct</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_MyCoin">MyCoin</a>
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

<a name="0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability"></a>

## Resource `Capability`

The struct to store capability: mint and burn.


<pre><code><b>struct</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability">Capability</a>&lt;CapType: store&gt; <b>has</b> key
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


<a name="0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_ERR_CAP_EXISTS"></a>

When capability already exists on account.


<pre><code><b>const</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_ERR_CAP_EXISTS">ERR_CAP_EXISTS</a>: u64 = 101;
</code></pre>



<a name="0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_ERR_CAP_MISSED"></a>

When capability is missed on account.


<pre><code><b>const</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_ERR_CAP_MISSED">ERR_CAP_MISSED</a>: u64 = 100;
</code></pre>



<a name="0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_initialize_internal"></a>

## Function `initialize_internal`

Initializing <code><a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_MyCoin">MyCoin</a></code> as coin in Aptos network.


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_initialize_internal">initialize_internal</a>(account: &<a href="">signer</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_initialize_internal">initialize_internal</a>(account: &<a href="">signer</a>) {
    // Initialize `<a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_MyCoin">MyCoin</a>` <b>as</b> <a href="">coin</a> type using Aptos Framework.
    <b>let</b> (mint_cap, burn_cap) = <a href="_initialize">coin::initialize</a>&lt;<a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_MyCoin">MyCoin</a>&gt;(
        account,
        <a href="_utf8">string::utf8</a>(b"<a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_MyCoin">MyCoin</a>"),
        <a href="_utf8">string::utf8</a>(b"MC"),
        10,
        <b>true</b>,
    );

    // Store mint and burn capabilities under user account.
    <b>move_to</b>(account, <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability">Capability</a> { cap: mint_cap });
    <b>move_to</b>(account, <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability">Capability</a> { cap: burn_cap });
}
</code></pre>



</details>

<a name="0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_initialize"></a>

## Function `initialize`

Similar to <code>initialize_internal</code> but can be executed as script.


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_initialize">initialize</a>(account: &<a href="">signer</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_initialize">initialize</a>(account: &<a href="">signer</a>) {
    <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_initialize_internal">initialize_internal</a>(account);
}
</code></pre>



</details>

<a name="0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_extract_capability"></a>

## Function `extract_capability`

Extract mint or burn capability from user account.
Returns extracted capability.


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_extract_capability">extract_capability</a>&lt;CapType: store&gt;(account: &<a href="">signer</a>): CapType
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_extract_capability">extract_capability</a>&lt;CapType: store&gt;(account: &<a href="">signer</a>): CapType <b>acquires</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability">Capability</a> {
    <b>let</b> account_addr = <a href="_address_of">signer::address_of</a>(account);

    // Check <b>if</b> capability stored under account.
    <b>assert</b>!(<b>exists</b>&lt;<a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability">Capability</a>&lt;CapType&gt;&gt;(account_addr), <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_ERR_CAP_MISSED">ERR_CAP_MISSED</a>);

    // Get capability stored under account.
    <b>let</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability">Capability</a> { cap } =  <b>move_from</b>&lt;<a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability">Capability</a>&lt;CapType&gt;&gt;(account_addr);
    cap
}
</code></pre>



</details>

<a name="0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_put_capability"></a>

## Function `put_capability`

Put mint or burn <code>capability</code> under user account.


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_put_capability">put_capability</a>&lt;CapType: store&gt;(account: &<a href="">signer</a>, capability: CapType)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_put_capability">put_capability</a>&lt;CapType: store&gt;(account: &<a href="">signer</a>, capability: CapType) {
    <b>let</b> account_addr = <a href="_address_of">signer::address_of</a>(account);

    // Check <b>if</b> capability doesn't exist under account so we can store.
    <b>assert</b>!(!<b>exists</b>&lt;<a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability">Capability</a>&lt;CapType&gt;&gt;(account_addr), <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_ERR_CAP_EXISTS">ERR_CAP_EXISTS</a>);

    // Store capability.
    <b>move_to</b>(account, <a href="TestCoin.md#0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5_testCoin_Capability">Capability</a>&lt;CapType&gt; {
        cap: capability
    });
}
</code></pre>



</details>
