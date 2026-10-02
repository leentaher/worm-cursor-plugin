---
name: worm-trade
description: Place or manage a trade on Worm. Use when the user explicitly asks to buy, sell, open a leveraged position, set take-profit/stop-loss, close, cancel, or redeem on worm.wtf.
---

# Worm trade

## When to use

Only when the user asks to act on a specific market. For "what should I trade", use `worm-market-research` instead.

## Prerequisites

Trading needs `WALLET_PRIVATE_KEY` set in the Worm MCP env. If `get_account_summary` fails with an auth error, stop and point the user to the plugin README setup section.

## Instructions

1. Resolve the market (`search` or `get_market`) and confirm it is open.
2. Check `margin_enabled`:
   - **Spot** (`false`): use `place_order`. Read `get_orderbook` to pick a sensible limit price.
   - **Margin** (`true`): call `estimate_margin_position` first. Leverage is 1x to 3x.
3. Check balance with `get_account_assets`.
4. Show a confirmation block and wait for an explicit yes:
   - Market + link, outcome, side, size, price as %
   - Margin only: leverage, collateral, liquidation price
5. Execute. Cursor will also show an approval prompt from the plugin hook.
6. Verify: `get_order` for spot; for margin, the call returns a position-request pubkey, so poll `list_margin_positions` and match `position_request_pubkey`.
7. Optional for margin: `set_tp_sl` (not supported on Hyperliquid-backed markets).

## Managing positions

- Close: `close_margin_position`. Cancel pending: `cancel_order` / `cancel_margin_request`.
- Resolved markets: `redeem` (spot) or `claim_margin_settlement` (margin).
