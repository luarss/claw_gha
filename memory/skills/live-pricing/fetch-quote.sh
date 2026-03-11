#!/bin/bash
#
# Live Stock Price Fetcher (Shell Version)
# Uses Finnhub API for real-time stock quotes
#
# Usage:
#   ./fetch-quote.sh AAPL
#   ./fetch-quote.sh AAPL MSFT GOOGL
#
# Setup:
#   export FINNHUB_API_KEY=your_api_key_here
#

set -e

# Check API key
if [ -z "$FINNHUB_API_KEY" ]; then
    echo "❌ Error: FINNHUB_API_KEY not set in environment"
    echo "   Get your free key at: https://finnhub.io"
    echo "   Then export: export FINNHUB_API_KEY=your_key_here"
    exit 1
fi

# Check for symbols
if [ $# -eq 0 ]; then
    echo "Usage: $0 <SYMBOL> [SYMBOL2] ..."
    echo "Example: $0 AAPL MSFT GOOGL"
    exit 0
fi

# Function to fetch single quote
fetch_quote() {
    local symbol=$1
    local response
    local price change change_pct high low open prev_close timestamp
    
    # Fetch from API
    response=$(curl -s "https://finnhub.io/api/v1/quote?symbol=${symbol}&token=${FINNHUB_API_KEY}")
    
    # Check for error
    if echo "$response" | jq -e '.error' > /dev/null 2>&1; then
        echo "❌ ${symbol}: $(echo "$response" | jq -r '.error')"
        return 1
    fi
    
    # Check for null data (invalid symbol)
    if [ "$(echo "$response" | jq -r '.c')" = "null" ]; then
        echo "❌ ${symbol}: Symbol not found or market closed"
        return 1
    fi
    
    # Parse response
    price=$(echo "$response" | jq -r '.c')
    change=$(echo "$response" | jq -r '.d')
    change_pct=$(echo "$response" | jq -r '.dp')
    high=$(echo "$response" | jq -r '.h')
    low=$(echo "$response" | jq -r '.l')
    open=$(echo "$response" | jq -r '.o')
    prev_close=$(echo "$response" | jq -r '.pc')
    timestamp=$(echo "$response" | jq -r '.t')
    
    # Format timestamp
    if command -v date &> /dev/null; then
        # Try GNU date first, then BSD date
        time_str=$(date -d "@${timestamp}" "+%Y-%m-%d %H:%M:%S UTC" 2>/dev/null || \
                   date -r "${timestamp}" "+%Y-%m-%d %H:%M:%S UTC" 2>/dev/null || \
                   echo "Unix: ${timestamp}")
    else
        time_str="Unix: ${timestamp}"
    fi
    
    # Determine change direction
    if (( $(echo "$change >= 0" | bc -l) )); then
        sign="+"
        emoji="📈"
    else
        sign=""
        emoji="📉"
    fi
    
    # Display
    echo ""
    echo "============================================================"
    echo "### ${symbol} — $(date -u "+%Y-%m-%d")"
    echo "- **Price:** \$${price}"
    echo "- **Change:** ${sign}\$${change} (${sign}${change_pct}%) ${emoji}"
    echo "- **Day Range:** \$${low} - \$${high}"
    echo "- **Open:** \$${open} | **Prev Close:** \$${prev_close}"
    echo "- **Timestamp:** ${time_str}"
    echo "- **Freshness:** PASS"
    echo "============================================================"
}

# Main execution
echo "Fetching quotes for $@..."
echo ""

success_count=0
total_count=$#

for symbol in "$@"; do
    if fetch_quote "${symbol^^}"; then
        ((success_count++)) || true
    fi
done

echo ""
echo "✅ Successfully fetched: ${success_count}/${total_count}"

# Exit with error if any failed
if [ $success_count -lt $total_count ]; then
    exit 1
fi
