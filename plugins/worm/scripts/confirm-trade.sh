#!/usr/bin/env bash
# beforeMCPExecution: force a human approval on every worm tool that moves
# money or changes account state. Read-only tools pass straight through.
input="$(cat)"

tool="$(printf '%s' "$input" | sed -n 's/.*"tool_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)"
server="$(printf '%s' "$input" | sed -n 's/.*"mcp_server_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)"

# Only police the worm server (by name, or by its launch command).
case "$server" in
  worm) ;;
  *) printf '%s' "$input" | grep -q 'worm-mcp' || { echo '{"permission":"allow"}'; exit 0; } ;;
esac

case "$tool" in
  place_order|cancel_order|open_margin_position|close_margin_position|\
  cancel_margin_request|set_tp_sl|remove_tp_sl|claim_margin_settlement|\
  redeem|revoke_api_key)
    cat <<JSON
{"permission":"ask","user_message":"Worm: the agent wants to run ${tool}. This acts on your wallet. Check the market, side, size and price before approving.","agent_message":"${tool} requires explicit user approval. Before retrying, show the user the market, side, size, price and (for margin) leverage and liquidation price from estimate_margin_position."}
JSON
    ;;
  *)
    echo '{"permission":"allow"}'
    ;;
esac
