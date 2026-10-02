---
name: worm-trending
description: Show the top open Worm markets right now with price, movement, and volume.
---

# Worm trending

1. Use `list_markets` with `sort: trending`, `state: open`, `limit: 10`.
2. For each, get `get_market_price` and `get_market_stats`.
3. Return a table: market, YES %, volume, spot/margin, worm.wtf link.
