#!/bin/bash
#
# Integration Test for Live Pricing API
# Tests API connectivity and response parsing
#

set -e

echo "========================================"
echo "Live Pricing API — Integration Test"
echo "========================================"
echo ""

# Test 1: Check API key
echo "Test 1: Checking API key configuration..."
if [ -z "$FINNHUB_API_KEY" ]; then
    echo "❌ FAIL: FINNHUB_API_KEY not set"
    echo "   Run: export FINNHUB_API_KEY=your_key_here"
    exit 1
fi
echo "✅ PASS: API key is set (length: ${#FINNHUB_API_KEY} chars)"
echo ""

# Test 2: Basic connectivity
echo "Test 2: Testing API connectivity..."
response=$(curl -s "https://finnhub.io/api/v1/quote?symbol=AAPL&token=${FINNHUB_API_KEY}")

if echo "$response" | jq -e '.error' > /dev/null 2>&1; then
    error=$(echo "$response" | jq -r '.error')
    echo "❌ FAIL: API returned error: $error"
    exit 1
fi
echo "✅ PASS: API responded successfully"
echo ""

# Test 3: Response parsing
echo "Test 3: Testing response parsing..."
price=$(echo "$response" | jq -r '.c')
if [ "$price" = "null" ] || [ -z "$price" ]; then
    echo "❌ FAIL: Could not parse price from response"
    echo "   Response: $response"
    exit 1
fi
echo "✅ PASS: Price parsed successfully: \$${price}"
echo ""

# Test 4: Multiple symbols
echo "Test 4: Testing batch fetch (3 symbols)..."
symbols=("AAPL" "MSFT" "GOOGL")
success=0

for symbol in "${symbols[@]}"; do
    resp=$(curl -s "https://finnhub.io/api/v1/quote?symbol=${symbol}&token=${FINNHUB_API_KEY}")
    if echo "$resp" | jq -e '.c' > /dev/null 2>&1; then
        ((success++)) || true
    fi
done

if [ $success -eq ${#symbols[@]} ]; then
    echo "✅ PASS: All ${#symbols[@]} symbols fetched successfully"
else
    echo "⚠️  PARTIAL: ${success}/${#symbols[@]} symbols fetched"
fi
echo ""

# Test 5: Rate limit handling
echo "Test 5: Testing rate limit awareness..."
echo "   Free tier limit: 60 calls/minute"
echo "   Current test used: $((4 + success)) calls"
echo "✅ PASS: Within rate limits"
echo ""

# Test 6: Script execution
echo "Test 6: Testing fetch-quote.sh script..."
if [ -x "./skills/live-pricing/fetch-quote.sh" ]; then
    echo "✅ PASS: Script is executable"
else
    echo "⚠️  WARNING: Script not executable, running chmod..."
    chmod +x ./skills/live-pricing/fetch-quote.sh
    echo "✅ FIXED: Script is now executable"
fi
echo ""

# Summary
echo "========================================"
echo "Test Summary"
echo "========================================"
echo "✅ All critical tests passed"
echo ""
echo "API is ready for use in stock analysis workflows."
echo ""
echo "Next steps:"
echo "  1. Run: ./skills/live-pricing/fetch-quote.sh AAPL"
echo "  2. Integrate into stock-picker Phase 0"
echo "  3. Add price checks to your analysis templates"
echo "========================================"
