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
# ./scripts/l2-messaging send-l2 {l2_addr} {l2_selector} {args}
./scripts/l2-messaging send-l2 0x06cbdfb07ce00b58fed3df6eafa8dae46e12908468a7fe9bf8b53614cbcda1d5 0x23ffd27e2c6df33c582785543c1f8b1b3ecf520dea0b4cf6e3168bfce0b58f8 1 2

# L2 > L1 messaging
# TODO (working, not arbitrary): ./scripts/l2-messaging send-l1
./scripts/l2-messaging send-l1
```

You can also check the logs with:
`docker compose logs -f l2_messaging_{eth, stark}`

## Credits

- [ghlim](https://github.com/glihm)'s [starknet-messaging-dev](https://github.com/glihm/starknet-messaging-dev) (initial code was copy/paste of this repository)
