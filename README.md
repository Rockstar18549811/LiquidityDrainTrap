# LiquidityDrainTrap (Drosera Proof-of-Concept)

## Overview
This trap monitors the liquidity balance in a specified pool and triggers an action if the balance falls below a critical threshold. It is essential for preventing liquidity drain in decentralized finance.

---

## What It Does
* Monitors the liquidity balance in a specified pool.
* Triggers if the liquidity balance falls below 1 ETH.
* It demonstrates the essential Drosera trap pattern using deterministic logic.

---

## Key Files
* `src/LiquidityDrainTrap.sol` - The core trap contract containing the monitoring logic.
* `src/SimpleResponder.sol` - The required external response contract.
* `drosera.toml` - The deployment and configuration file.

---

## Detection Logic

The trap's core monitoring logic is contained in the deterministic `shouldRespond()` function.

solidity
function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
    CollectOutput memory current = abi.decode(data[0], (CollectOutput));
    CollectOutput memory past = abi.decode(data[data.length - 1], (CollectOutput));
    if (past.liquidityBalance < THRESHOLD) return (true, bytes(""));
    return (false, bytes(""));
}


---

## 🧪 Implementation Details and Key Concepts
* **Monitoring Target:** Watching the liquidity balance at the specified pool address.
* **Deterministic Logic:** The logic is executed off-chain by operators to achieve consensus before a transaction is proposed.
* **Calculation/Thresholds:** Uses a fixed threshold of 1 ETH as the trigger point for actions.
* **Response Mechanism:** On trigger, the trap calls the external Responder contract, demonstrating the separation of monitoring and action.

---

## Test It
To verify the trap logic using Foundry, run the following command (assuming a test file has been created):

bash
forge test --match-contract LiquidityDrainTrap
