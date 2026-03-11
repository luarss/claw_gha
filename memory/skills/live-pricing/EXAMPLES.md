# Live Pricing Examples

Practical examples for using the Finnhub API in stock analysis workflows.

---

## Command Line (curl)

### Get Current Price

```bash
# Basic quote
curl "https://finnhub.io/api/v1/quote?symbol=AAPL&token=$FINNHUB_API_KEY"

# Parse with jq for cleaner output
curl -s "https://finnhub.io/api/v1/quote?symbol=AAPL&token=$FINNHUB_API_KEY" | jq '{
  price: .c,
  change: .d,
  changePercent: "\(.dp)%",
  high: .h,
  low: .l,
  open: .o,
  previousClose: .pc
}'
```

### Multiple Symbols

```bash
# Fetch quotes for multiple symbols
for symbol in AAPL MSFT GOOGL AMZN; do
  echo "=== $symbol ==="
  curl -s "https://finnhub.io/api/v1/quote?symbol=$symbol&token=$FINNHUB_API_KEY" | jq '{price: .c, change: .dp}'
done
```

### Historical Data

```bash
# Last 7 days of daily candles
FROM=$(date -v-7d +%s)
TO=$(date +%s)

curl -s "https://finnhub.io/api/v1/stock/candle?symbol=AAPL&resolution=D&from=$FROM&to=$TO&token=$FINNHUB_API_KEY" | jq '.'
```

### Company Profile

```bash
curl -s "https://finnhub.io/api/v1/stock/profile2?symbol=AAPL&token=$FINNHUB_API_KEY" | jq '{
  name: .name,
  ticker: .ticker,
  industry: .finnhubIndustry,
  marketCap: .marketCapitalization,
  exchange: .exchange
}'
```

---

## JavaScript / Node.js

### Basic Quote Fetcher

```javascript
const API_KEY = process.env.FINNHUB_API_KEY;

async function getQuote(symbol) {
  const url = `https://finnhub.io/api/v1/quote?symbol=${symbol}&token=${API_KEY}`;
  const response = await fetch(url);

  if (!response.ok) {
    throw new Error(`API error: ${response.status}`);
  }

  const data = await response.json();

  return {
    symbol,
    price: data.c,
    change: data.d,
    changePercent: data.dp,
    high: data.h,
    low: data.l,
    open: data.o,
    previousClose: data.pc,
    timestamp: new Date(data.t * 1000)
  };
}

// Usage
const quote = await getQuote('AAPL');
console.log(`${quote.symbol}: $${quote.price} (${quote.changePercent}%)`);
```

### Quote with Freshness Check

```javascript
async function getFreshQuote(symbol, maxAgeMinutes = 15) {
  const quote = await getQuote(symbol);
  const now = new Date();
  const quoteTime = quote.timestamp;
  const ageMinutes = (now - quoteTime) / (1000 * 60);

  return {
    ...quote,
    isStale: ageMinutes > maxAgeMinutes,
    ageMinutes: Math.round(ageMinutes)
  };
}

// Usage with freshness check
const quote = await getFreshQuote('AAPL');
if (quote.isStale) {
  console.warn(`Warning: Price data is ${quote.ageMinutes} minutes old`);
}
```

### Batch Quotes with Rate Limiting

```javascript
async function getBatchQuotes(symbols, delayMs = 1000) {
  const results = [];

  for (const symbol of symbols) {
    try {
      const quote = await getQuote(symbol);
      results.push(quote);
    } catch (error) {
      results.push({ symbol, error: error.message });
    }

    // Delay to respect rate limits (60 calls/min = ~1 call/sec)
    if (symbols.indexOf(symbol) < symbols.length - 1) {
      await new Promise(r => setTimeout(r, delayMs));
    }
  }

  return results;
}

// Usage
const quotes = await getBatchQuotes(['AAPL', 'MSFT', 'GOOGL']);
quotes.forEach(q => {
  if (q.error) {
    console.error(`${q.symbol}: ${q.error}`);
  } else {
    console.log(`${q.symbol}: $${q.price}`);
  }
});
```

---

## Python

### Basic Quote Fetcher

```python
import os
import requests
from datetime import datetime

API_KEY = os.environ.get('FINNHUB_API_KEY')

def get_quote(symbol):
    """Fetch real-time quote for a symbol."""
    url = f"https://finnhub.io/api/v1/quote?symbol={symbol}&token={API_KEY}"
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()

    return {
        'symbol': symbol,
        'price': data['c'],
        'change': data['d'],
        'change_percent': data['dp'],
        'high': data['h'],
        'low': data['l'],
        'open': data['o'],
        'previous_close': data['pc'],
        'timestamp': datetime.fromtimestamp(data['t'])
    }

# Usage
quote = get_quote('AAPL')
print(f"{quote['symbol']}: ${quote['price']} ({quote['change_percent']}%)")
```

### Quote with Fallback

```python
import time

def get_quote_with_fallback(symbol, max_retries=3):
    """Fetch quote with retry and fallback handling."""
    for attempt in range(max_retries):
        try:
            return get_quote(symbol)
        except requests.HTTPError as e:
            if e.response.status_code == 429:
                # Rate limited - wait and retry
                wait_time = 60 * (attempt + 1)
                print(f"Rate limited, waiting {wait_time}s...")
                time.sleep(wait_time)
            elif e.response.status_code == 404:
                # Symbol not found - don't retry
                return {'symbol': symbol, 'error': 'Symbol not found'}
            else:
                raise

    return {'symbol': symbol, 'error': 'Max retries exceeded'}
```

### Integration with Stock Analysis

```python
def check_price_freshness(symbol):
    """Phase 0: Data freshness check for stock-picker workflow."""
    quote = get_quote(symbol)

    now = datetime.now()
    quote_time = quote['timestamp']
    age = now - quote_time

    # Check if market is open (simplified)
    is_trading_day = now.weekday() < 5  # Mon-Fri
    is_market_hours = 9.5 <= now.hour + now.minute/60 <= 16  # 9:30 AM - 4 PM ET

    status = 'PASS'
    if age.total_seconds() > 86400:  # > 24 hours
        status = 'STALE'
    elif is_trading_day and is_market_hours and age.total_seconds() > 900:
        # During market hours, 15+ min old is concerning
        status = 'RETRY'

    return {
        'symbol': symbol,
        'price': quote['price'],
        'timestamp': quote_time.isoformat(),
        'age_minutes': age.total_seconds() / 60,
        'status': status
    }

# Usage in analysis workflow
freshness = check_price_freshness('AAPL')
print(f"### Data Quality Check — {datetime.now().isoformat()}")
print(f"- Price: ${freshness['price']} (as of {freshness['timestamp']})")
print(f"- FRESHNESS: {freshness['status']}")
```

---

## Shell Script for Analysis

Save as `fetch-price.sh`:

```bash
#!/bin/bash
# Fetch real-time price for stock analysis

SYMBOL=${1:-AAPL}

if [ -z "$FINNHUB_API_KEY" ]; then
    echo "Error: FINNHUB_API_KEY not set"
    exit 1
fi

# Fetch quote
RESPONSE=$(curl -s "https://finnhub.io/api/v1/quote?symbol=$SYMBOL&token=$FINNHUB_API_KEY")

# Check for error
if echo "$RESPONSE" | jq -e '.error' > /dev/null 2>&1; then
    echo "Error: $(echo "$RESPONSE" | jq -r '.error')"
    exit 1
fi

# Format output for analysis
PRICE=$(echo "$RESPONSE" | jq -r '.c')
CHANGE=$(echo "$RESPONSE" | jq -r '.d')
CHANGE_PCT=$(echo "$RESPONSE" | jq -r '.dp')
TIMESTAMP=$(echo "$RESPONSE" | jq -r '.t')

# Convert timestamp to readable format
TIME_STR=$(date -r "$TIMESTAMP" "+%Y-%m-%d %H:%M:%S UTC" 2>/dev/null || date -d @"$TIMESTAMP" "+%Y-%m-%d %H:%M:%S UTC" 2>/dev/null)

echo "### Data Quality Check — $(date -u "+%Y-%m-%d %H:%M UTC")"
echo "- Price: \$${PRICE} (as of ${TIME_STR})"
echo "- Change: \$${CHANGE} (${CHANGE_PCT}%)"
echo "- FRESHNESS: PASS"
```

Usage:
```bash
chmod +x fetch-price.sh
./fetch-price.sh AAPL
```

---

## Integration Example: Stock Picker Workflow

```javascript
/**
 * Phase 0: Data Freshness Check
 * Call this before any stock analysis
 */
async function dataFreshnessCheck(symbol) {
  console.log(`\n### Data Quality Check — ${new Date().toISOString()}`);

  try {
    const quote = await getQuote(symbol);

    // Calculate age
    const now = Date.now();
    const quoteTime = quote.timestamp.getTime();
    const ageMinutes = (now - quoteTime) / (1000 * 60);

    // Determine freshness
    let freshness;
    if (ageMinutes > 1440) { // > 24 hours
      freshness = 'STALE';
    } else if (ageMinutes > 15) {
      freshness = 'RETRY';
    } else {
      freshness = 'PASS';
    }

    console.log(`- Price: $${quote.price} (as of ${quote.timestamp.toISOString()})`);
    console.log(`- FRESHNESS: ${freshness}`);

    return {
      price: quote.price,
      timestamp: quote.timestamp,
      freshness,
      proceed: freshness !== 'STALE'
    };

  } catch (error) {
    console.log(`- FRESHNESS: ERROR (${error.message})`);
    return {
      price: null,
      freshness: 'ERROR',
      proceed: false,
      error: error.message
    };
  }
}

// Usage in stock-picker workflow
const check = await dataFreshnessCheck('AAPL');
if (!check.proceed) {
  console.log('WARNING: Data is stale, analysis may be unreliable');
}
```
