# Worm for Cursor

Cursor Marketplace plugin for [Worm](https://worm.wtf), the permissionless prediction market on Solana. It wraps [`worm-mcp`](https://github.com/wormwtf/worm-mcp) and adds the agent guidance and safety rails around it.

## What's inside

| Component | Path | What it does |
|---|---|---|
| MCP server | `plugins/worm/mcp.json` | Launches `worm-mcp` (38 tools) via `uvx` |
| Rules | `plugins/worm/rules/` | Trading safety (always on) + API lookup tips when coding |
| Skills | `plugins/worm/skills/` | `worm-market-research`, `worm-trade`, `worm-portfolio` |
| Agent | `plugins/worm/agents/worm-analyst.md` | Read-only market analyst |
| Commands | `plugins/worm/commands/` | `/worm-trending`, `/worm-portfolio` |
| Hook | `plugins/worm/hooks/hooks.json` | Forces an approval prompt on every money-moving Worm tool |

## Setup

Requires [`uv`](https://docs.astral.sh/uv/).

- **Browse only:** install the plugin. Public tools (search, prices, orderbooks, candles, docs) need no credentials.
- **Trade:** set the plugin's `WALLET_PRIVATE_KEY` variable (Cursor → Plugins → Worm → Configure) to a base58 Solana private key exported from Phantom/Solflare. Leave it empty for read-only use.

  Use a dedicated wallet funded with only what you intend to trade. The key signs locally and never leaves your machine.

Verify by asking the agent: *"List trending markets on Worm."*

## Safety model

- The `worm-trading-safety` rule tells the agent to confirm every action and to run `estimate_margin_position` before any leveraged position (Worm caps leverage at 3x).
- The `beforeMCPExecution` hook returns `ask` for `place_order`, `cancel_order`, `open_margin_position`, `close_margin_position`, `cancel_margin_request`, `set_tp_sl`, `remove_tp_sl`, `claim_margin_settlement`, `redeem`, and `revoke_api_key`, so Cursor shows an approval prompt even if the agent skips the rule. It is `failClosed`, so a broken hook blocks writes instead of letting them through.

## Note on the `mcp<2` pin

`worm-mcp` 0.3.0 declares `mcp>=1.2.0` with no upper bound, and MCP Python SDK 2.x removed `mcp.server.fastmcp`, so a bare `uvx worm-mcp` crashes on import. `mcp.json` pins `--with "mcp<2"` until `worm-mcp` ships an upper bound or mcp 2 support.

## Develop

```bash
node scripts/validate-template.mjs
```

To test locally, copy the plugin into Cursor's local plugin folder, then restart Cursor (or run **Developer: Reload Window**):

```bash
cp -R plugins/worm ~/.cursor/plugins/local/worm
```

## Submit

Submit the public repo link at [cursor.com/marketplace/publish](https://cursor.com/marketplace/publish).

## License

MIT
