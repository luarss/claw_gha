# Live Pricing API Setup Guide

Quick start guide to get real-time stock data working in your workspace.

---

## Step 1: Get Your API Key

### Finnhub (Recommended)
1. Visit [https://finnhub.io](https://finnhub.io)
2. Click "Sign Up" (top right)
3. Register with email (no credit card required)
4. Go to Dashboard → API Keys
5. Copy your API key

**Free Tier Limits:**
- 60 API calls per minute
- 60,000 calls per month
- Real-time US stock prices
- Company profiles & fundamentals

---

## Step 2: Configure Environment

### Option A: Export in Shell Session
```bash
export FINNHUB_API_KEY=your_api_key_here
```

### Option B: Add to .env File
Create `.env` in workspace root:
```bash
FINNHUB_API_KEY=your_api_key_here
```

Then load it:
```bash
source .env
```

### Option C: Add to Shell Profile
Add to `~/.bashrc` or `~/.zshrc`:
```bash
export FINNHUB_API_KEY=your_api_key_here
```

Then reload:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

---

## Step 3: Verify Setup

### Test with curl
```bash
curl "https://finnhub.io/api/v1/quote?symbol=AAPL&token=$FINNHUB_API_KEY"
```

Expected response:
```json
{"c":175.50,"d":2.30,"dp":1.33,"h":176.00,"l":173.20,"o":173.50,"pc":173.20,"t":1234567890}
```

### Test with Script
```bash
# Make script executable
chmod +x skills/live-pricing/fetch-quote.sh

# Run test
./skills/live-pricing/fetch-quote.sh AAPL
```

Or with Node.js:
```bash
node skills/live-pricing/fetch-quote.js AAPL MSFT GOOGL
```

---

## Step 4: Integration with Stock Picker

### In Analysis Workflow

The live-pricing skill integrates with the stock-picker workflow at **Phase 0: Data Freshness Check**.

**Example Integration:**
```javascript
// At start of any stock analysis
const { execSync } = require('child_process');

function getLivePrice(symbol) {
  try {
    const output = execSync(
      `node skills/live-pricing/fetch-quote.js ${symbol}`,
      { encoding: 'utf8' }
    );
    
    // Parse price from output
    const priceMatch = output.match(/\*\*Price:\*\* \$(\d+\.\d+)/);
    return priceMatch ? parseFloat(priceMatch[1]) : null;
  } catch (error) {
    console.error('Failed to fetch live price:', error.message);
    return null;
  }
}

// Usage
const currentPrice = getLivePrice('AAPL');
console.log(`Current price: $${currentPrice}`);
```

### In Shell Scripts
```bash
#!/bin/bash
# Add to your analysis scripts

source .env  # Load API key

# Fetch price before analysis
./skills/live-pricing/fetch-quote.sh $SYMBOL > price-check.md
cat price-check.md
```

---

## Alternative APIs

If you want redundancy or different features:

### Alpha Vantage
- **Free Tier:** 5 API calls/minute, 500 calls/day
- **Features:** Stocks, forex, crypto, technical indicators
- **Get Key:** [https://www.alphavantage.co](https://www.alphavantage.co)
- **Best For:** Historical data, technical indicators

### Polygon.io
- **Free Tier:** Limited (requires paid for real-time)
- **Features:** Comprehensive market data
- **Get Key:** [https://polygon.io](https://polygon.io)
- **Best For:** Professional-grade data

### Yahoo Finance (Unofficial)
- **Free:** Yes (no API key needed)
- **Features:** Quotes, historical data
- **Library:** `yfinance` (Python)
- **Best For:** Quick prototypes, no signup

---

## Troubleshooting

### "Invalid API Key"
- Double-check you copied the full key
- Ensure no extra spaces in environment variable
- Test with curl first

### "Rate Limit Exceeded"
- Wait 60 seconds and retry
- Reduce frequency of calls
- Cache results in your application

### "Symbol Not Found"
- Verify ticker symbol is correct
- Some symbols may not be available on free tier
- Try uppercase (AAPL not aapl)

### "Market Closed"
- Prices may be delayed or show previous close
- Weekend/holiday markets are closed
- Pre-market/after-hours data may be limited

---

## Best Practices

### 1. Cache Responses
Don't query the same symbol multiple times within a minute:
```javascript
const cache = new Map();
const CACHE_TTL = 60000; // 1 minute

async function getCachedQuote(symbol) {
  const cached = cache.get(symbol);
  if (cached && Date.now() - cached.time < CACHE_TTL) {
    return cached.data;
  }
  
  const data = await getQuote(symbol);
  cache.set(symbol, { data, time: Date.now() });
  return data;
}
```

### 2. Batch Requests
Fetch multiple symbols efficiently:
```javascript
const symbols = ['AAPL', 'MSFT', 'GOOGL'];
const quotes = await Promise.all(
  symbols.map(s => getQuote(s))
);
```

### 3. Error Handling
Always handle API failures gracefully:
```javascript
try {
  const quote = await getQuote(symbol);
  if (!quote.success) {
    console.warn(`Using fallback data for ${symbol}`);
    // Use cached or estimated data
  }
} catch (error) {
  console.error(`API failed: ${error.message}`);
}
```

### 4. Log Data Source
Always timestamp and source your data:
```markdown
### Data Quality Check — 2026-03-11 01:30 UTC
- **Source:** Finnhub API
- **Price:** $175.50 (as of 2026-03-11 01:29:45 UTC)
- **Freshness:** PASS (1 min old)
```

---

## Next Steps

1. ✅ Get API key
2. ✅ Set environment variable
3. ✅ Test with sample script
4. ✅ Integrate into your stock-picker workflow
5. ✅ Add to MEMORY.md when you make trades

For detailed API documentation, see `API.md`.
For usage examples, see `EXAMPLES.md`.
