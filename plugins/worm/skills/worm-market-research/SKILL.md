---
name: worm-market-research
description: Research Worm prediction markets. Use when the user asks what's trending, wants to find markets on a topic, compare prices, read an orderbook, or understand how a market has moved.
---

# Worm market research

## When to use

- "What's trending on Worm?" / "Find markets about <topic>"
- "What's the price / orderbook / volume on <market>?"
- "How has this market moved this week?"

## Instructions

1. Find markets with `search` (free text plus `state: open`) or `list_markets` (category / sort). For grouped markets use `list_events` and `get_event`. For sports, `list_sports` gives the league catalog.
2. For each candidate, pull `get_market` (outcomes, fees, state, `margin_enabled`) and `get_market_stats` (volume, trade count).
3. Price: `get_market_price` for the mid, `get_orderbook` for depth on spot markets, `get_market_candles` (5m / 30m) for movement, `get_market_trades` for recent fills.
4. Present a compact table: market, YES %, 24h move, volume, spot or margin, link `https://worm.wtf/market/{condition_id}`.
5. Quote prices as percentages. Do not recommend a position. Summarize what the data shows and offer next steps.
