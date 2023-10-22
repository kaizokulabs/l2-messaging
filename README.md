# L2 Messaging

> <picture>
>   <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/Mqxx/GitHub-Markdown/main/blockquotes/badge/light-theme/danger.svg">
>   <img alt="Danger" src="https://raw.githubusercontent.com/Mqxx/GitHub-Markdown/main/blockquotes/badge/dark-theme/danger.svg">
> </picture><br>
>
> The contracts in this repository are highly experimental, be careful when deploying them!

This repository is intended to create a base messaging layer between L1 <> L2 and L2 <> L2, based on each L2 messaging mechanism.

## How to test it?

```bash
./scripts/l2-messaging run-all

# L1 > L2 messaging
#./scripts/l2-messaging send-l2 <address> <selector> <args>
./scripts/l2-messaging send-l2 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0

# L2 > L1 messaging
#./scripts/l2-messaging send-l1 <address> <selector> <args>
./scripts/l2-messaging send-l1 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
```

## Credits

- [ghlim](https://github.com/glihm)'s [starknet-messaging-dev](https://github.com/glihm/starknet-messaging-dev) (initial code was copy/paste of this repository)
