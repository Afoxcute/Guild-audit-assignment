## Proof of Concept (POC) for Multiple Claim Vulnerability in SafeNFT Contract

This POC demonstrates how an attacker can exploit the vulnerability in the original `SafeNFT` contract to claim multiple NFTs for the price of one.

**Steps:**

1. **Attacker Setup:**
    - The attacker deploys a script that monitors transactions on the blockchain.
    - The script specifically looks for calls to the `buyNFT` function of the target `SafeNFT` contract.

2. **Attacker Initiates Purchase:**
    - The attacker sends a transaction to the `buyNFT` function with the correct `price` (e.g., 0.01 ETH).
    - This transaction sets the `canClaim` mapping for the attacker's address to `true`. 

3. **Attacker Monitors for Claim Transaction:**
    - The attacker's script waits for another user (victim) to initiate a claim transaction by calling the `claim` function.

4. **Attacker Exploits the Vulnerability:**
    - Once the attacker detects a claim transaction from the victim, they immediately call the `claim` function themselves.
    - Since the attacker's `canClaim` is still `true`, they can successfully claim an NFT.

5. **Repeat the Attack:**
    - The attacker can repeat steps 2-4 as long as there are remaining victims who call `buyNFT`. This allows them to claim multiple NFTs despite only paying the price once.

**Impact:**

* This attack undermines the intended functionality of the contract, where each purchase should only allow claiming one NFT.
* The attacker gains an unfair advantage by acquiring multiple NFTs for the intended price of a single one.

**Mitigation:**

The improved `SafeNFT` contract with the `claimedNFTs` mapping addresses this vulnerability. Here's why:

* By tracking claimed NFTs per address, the contract ensures that an address can only claim once after a purchase.
* Even if the attacker monitors victim transactions, their `claim` attempt will fail because `claimedNFTs[msg.sender]` will already be 0 after their initial claim.

**Note:** This is a simplified POC for demonstration purposes. Real-world attacks can be more sophisticated and might involve automation tools.
