## L1 -> L2
We don't like to overcomplicate stuff and usually, L2s have really good support for native L1 -> L2 communication.

The payload should be formatted thinking about possible extra L1 arguments that might be needed to process the transaction in case the L2 lacks that information (e.g. sender address).

<div align="center">
  <img width="555" alt="image" src="https://github.com/kaizokulabs/l2-messaging/assets/5263301/096db5e5-c234-464e-8424-3c7c937a3f22">
</div>

## L2 -> L1
L2 -> L1 communication usually is handled with the L2 settlement mechanism. This works out of the box but it's limited to the time needed to settle the transactions on the L1 plus the time required for finality in the L1. In optimistic rollups, it might take 1 week for the transaction to be processed, while on validity rollups it can be done without any delay (usually it has some delay for cost optimization).

The goal is to have an L1/L2 Messaging smart contract to send/receive arbitrary messages. This enables us to extend it to work with any L1<>L2 and L2<>L2 communication (assuming that all the L2s are settling on the L1), using only the following parameters:
- Chain ID
- Receiver Address
- Function Selector
- Arguments of the function

To accelerate the process of sending messages we can encourage third parties to actively poll the L2 Messaging smart contract for new messages and let the L1 Messaging smart contract know about them before the L2 settles on the L1 and the message is consumed. The whole process is incentivized in exchange for a fee that is given to the executor, on the L2, after the message is consumed on the L1.

<div align="center">
  <img src="https://github.com/kaizokulabs/l2-messaging/assets/5263301/be13c77e-9c41-4092-8fd8-2797ec9a1464" />
</div>
