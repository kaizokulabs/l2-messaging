//! A simple contract that sends and receives messages from/to
//! the L1 (Ethereum).
//!
//! The reception of the messages is done using the `l1_handler` functions.
//! The messages are sent by using the `send_message_to_l1_syscall` syscall.

/// A custom struct, which is already
/// serializable as `felt252` is serializable.
#[derive(Drop, Serde)]
struct MyData {
    dest_address: felt252,
    selector: felt252,
    // TODO: change it to array
    payload: felt252,
}

#[starknet::interface]
trait IContractL1<T> {
    fn send_message(ref self: T);
}

#[starknet::contract]
mod contract_msg {
    use super::{IContractL1, MyData};
    use starknet::{EthAddress, SyscallResultTrait};

    #[storage]
    struct Storage {}

    /// Handles a message received from L1.
    #[l1_handler]
    fn msg_handler(ref self: ContractState, from_address: felt252, value: felt252) {
        assert(value == 123, 'Invalid value');
    }

    #[external(v0)]
    impl ContractL1Impl of IContractL1<ContractState> {
        fn send_message(ref self: ContractState) {
            let to_address = 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512;
            starknet::send_message_to_l1_syscall(
                    to_address.into(),
                    array![1, 2, 3].span()
                )
                .unwrap_syscall();
        }
    }
}
