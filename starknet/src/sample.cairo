//! A simple contract that sends and receives messages from/to
//! the L1 (Ethereum).
//!
//! The reception of the messages is done using the `l1_handler` functions.
//! The messages are sent by using the `send_message_to_l1_syscall` syscall.

/// A custom struct, which is already
/// serializable as `felt252` is serializable.
#[derive(Drop, Serde)]
struct Message {
    dest_address: felt252,
    selector: felt252,
    amount: felt252,
    payload: Array<felt252>,
}

#[derive(Drop, Serde)]
struct RecvMessage {
    origin_address: felt252,
    a: felt252,
    b: felt252,
}

#[starknet::interface]
trait IContractL1<T> {
    fn send_message(ref self: T, payload: Message);
}

#[starknet::contract]
mod contract_msg {
    use super::{IContractL1, Message, RecvMessage};
    use starknet::SyscallResultTrait;

    #[storage]
    struct Storage {
        eth_messaging_address: felt252,
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        self.eth_messaging_address.write(0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512);
    }

    /// Handles a message received from L1.
    #[l1_handler]
    fn msg_handler(ref self: ContractState, from_address: felt252, payload: RecvMessage) {
        // Do stuff (e.g. sum and send_message)

        let sum = payload.a + payload.b;
        let msg: Message = Message {
            dest_address: payload.origin_address,
            //result
            selector: 8243121641139480617,
            amount: 0,
            payload: array![sum],
        };

        self.send_message(msg);
    }

    #[external(v0)]
    impl ContractL1Impl of IContractL1<ContractState> {
        fn send_message(ref self: ContractState, payload: Message) {
            let mut buf: Array<felt252> = array![];
            payload.serialize(ref buf);

            starknet::send_message_to_l1_syscall(
                    self.eth_messaging_address.read().into(),
                    buf.span()
                )
                .unwrap_syscall();
        }
    }
}
