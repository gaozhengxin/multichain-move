#!/usr/bin/env python3

# SPDX-License-Identifier: Apache-2.0

from hello_blockchain import HelloBlockchainClient
from typing import Optional
import sys

from first_transaction import Account, FaucetClient, RestClient, TESTNET_URL, FAUCET_URL

class TestRouter(RestClient):
    def initialize_coin(self, account_from: Account) -> Optional[str]:
        payload = {
            "type": "script_function_payload",
            "function": f"0x{account_from.address()}::TestCoin::initialize",
            "type_arguments": [f"0x{account_from.address()}::TestCoin::MyCoin"],
            "arguments": [f"0x{account_from.address()}"]
        }
        print(payload)
        res = self.execute_transaction_with_payload(account_from, payload)
        return str(res["hash"])

if __name__ == "__main__":
    #assert len(sys.argv) == 2, "Expecting an argument that points to the modules needed"

    client = TestRouter(TESTNET_URL)
    faucet_client = FaucetClient(FAUCET_URL, client)

    #Multichain: 0x04e0dc7e597ace235edaa4498f6e09f47dc9fd6a0e93df278b0d11d5080e44f2
    #Alice: 0xbfeddfe5a95aad33c04bf13ce38c1cee03d0af727d7ea938ca1bdf377db240b5
    #Bob: 0xf0ff70c04f552410ffbf8234c1291e155c5c68e059b36959cac30381a6341fe9
    seed1 = "ABABABABCDCDCDCDABABABAB00000100ABABABABCDCDCDCDABABABABCDCDCDCD"
    seed2 = "ABABABABCDCDCDCDABABABAB00000200ABABABABCDCDCDCDABABABABCDCDCDCD"
    seed3 = "ABABABABCDCDCDCDABABABAB00000300ABABABABCDCDCDCDABABABABCDCDCDCD"
    
    multichain = Account(bytes.fromhex(seed1))
    alice = Account(bytes.fromhex(seed2))
    bob = Account(bytes.fromhex(seed3))

    print("\n=== Addresses ===")
    print(f"Multichain: {multichain.address()}")
    print(f"Alice: {alice.address()}")
    print(f"Bob: {bob.address()}")

    #faucet_client.fund_account(multichain.address(), 10_000_000)
    #faucet_client.fund_account(alice.address(), 10_000_000)
    #faucet_client.fund_account(bob.address(), 10_000_000)

    input("\nUpdate the module with Alice's address, build, copy to the provided path, and press enter.")
    module_path = sys.argv[1]
    with open(module_path, "rb") as f:
        module_hex = f.read().hex()

    print("Publishing TestCoin module...")
    hello_blockchain_client = HelloBlockchainClient(TESTNET_URL)
    tx_hash = hello_blockchain_client.publish_module(alice, module_hex)
    res = hello_blockchain_client.wait_for_transaction(tx_hash)
    print(res)

    #print("Alice will initialize the new coin")
    #tx_hash = client.initialize_coin(alice)
    #client.wait_for_transaction(tx_hash)
    #print(tx_hash)