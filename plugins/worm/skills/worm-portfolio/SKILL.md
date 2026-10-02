---
name: worm-portfolio
description: Summarize the user's Worm account. Use when the user asks about their positions, balances, PnL, open orders, or anything to claim on worm.wtf.
---

# Worm portfolio

## Instructions

1. `get_account_summary` (confirms auth) and `get_account_assets` (balances, share holdings).
2. `get_account_pnl` for realized and unrealized PnL.
3. Open activity: `list_orders`, `list_margin_positions`, `list_margin_requests`.
4. Anything to collect: `list_margin_settlements` and resolved markets in assets that can be redeemed.
5. Report as: balance, open positions (market, side, entry %, current %, PnL), open orders, claimable items. Flag margin positions near liquidation.
6. Offer actions (close, set TP/SL, redeem) but do not run them without a yes.
