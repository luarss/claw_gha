# Live Pricing Skill

## Purpose
Fetch real-time (or delayed) stock prices using either Finnhub API or financialdata.net as a backup provider for stock analysis workflows.

---

## Supported Providers

| Feature | Finnhub (Primary) | financialdata.net (Backup) |
|---------|------------------|----------------------------|
| **Free Tier** | 60,000 calls/month | 300 calls/day |
| **Real-time** | Yes | Premium only |
| **Data Latency** | Real-time | Delayed (~15 min) |
| **US Stocks** | Yes | Yes |
| **Intl Stocks** | No | Yes (Standard+) |
| **Crypto** | Yes | Yes (Standard+) |

---

## Why Dual Providers

1. **Reliability** — If Finnhub fails, automatically fall back to financialdata.net
2. **International Coverage** — financialdata.net supports international stocks
3. **Rate Limit Buffer** — 300 extra calls/day via backup provider
4. **No Single Point of Failure** — Critical analysis never stalls

---

## Capabilities

1. **Real-time Quotes** — Current price, change, day high/low (Finnhub)
2. **Delayed Quotes** — Current price with ~15 min delay (financialdata.net free tier)
3. **Batch Quotes** — Multiple symbols in parallel
4. **Price History** — Historical candles for technical analysis
5. **Fallback Logic** — Try Finnhub first, then financialdata.net

---

## Setup

### 1. Get API Keys

#### Finnhub (Primary)
1. Visit [finnhub.io](https://finnhub.io)
2. Sign up with email (no credit card required)
3. Navigate to Dashboard → API Keys
4. Copy your API key

#### financialdata.net (Backup)
1. Visit [financialdata.net](https://financialdata.net)
2. Sign up for free tier
3. Get your API key from dashboard
4. Free tier: 300 requests/day (delayed data)

### 2. Configure Environment

Add to your `.env` file:
```bash
FINNHUB_API_KEY=your_finnhub_key_here
FINANCIALDATA_API_KEY=your_financialdata_key_here
```

### 3. Verify Setup

Test Finnhub (primary):
```bash
curl "https://finnhub.io/api/v1/quote?symbol=AAPL&token=$FINNHUB_API_KEY"
```

Test financialdata.net (backup):
```bash
curl "https://api.financialdata.net/api/v0/intraday/$AAPL?token=$FINANCIALDATA_API_KEY"
```

---

## Usage in Analysis Workflow

### When to Use

Use this skill in **Phase 0: Data Freshness Check** of the stock-picker workflow:

1. **Before any analysis** — Fetch current price
2. **Timestamp verification** — Confirm data is from current trading day
3. **Price validation** — Cross-check against other sources
4. **Fallback** — Try backup if primary fails

### Integration Pattern

```
1. Check FINNHUB_API_KEY is available
2. Fetch quote for target symbol
3. If Finnhub fails, try FINANCIALDATA_API_KEY
4. Log price with timestamp and source
5. Proceed with stock-picker analysis
```

---

## Response Interpretation

### Finnhub Quote Response Fields

| Field | Meaning | Example |
|-------|---------|---------|
| `c` | Current price | 175.50 |
| `d` | Change | 2.30 |
| `dp` | Change percent | 1.33 |
| `h` | Day high | 176.00 |
| `l` | Day low | 173.20 |
| `o` | Open price | 173.50 |
| `pc` | Previous close | 173.20 |
| `t` | Timestamp (Unix) | 1234567890 |

### financialdata.net Quote Response Fields

| Field | Meaning | Example |
|-------|---------|---------|
| `symbol` | Ticker symbol | "AAPL" |
| `price` | Current price | 175.50 |
| `change` | Change amount | 2.30 |
| `changePercent` | Change percent | 1.33 |
| `high` | Day high | 176.00 |
| `low` | Day low | 173.20 |
| `open` | Open price | 173.50 |
| `previousClose` | Previous close | 173.20 |
| `timestamp` | ISO timestamp | "2026-03-11T20:00:00" |

---

## Implementation Scripts

| File | Language | Provider |
|------|----------|----------|
| `fetch-quote.js` | JavaScript | Finnhub |
| `fetch-quote-fd.js` | JavaScript | financialdata.net |
| `fetch_quote.py` | Python | Finnhub |
| `fetch_quote_fd.py` | Python | financialdata.net |

### Using Backup Provider Directly

```bash
# JavaScript
node fetch-quote-fd.js AAPL

# Python
python fetch_quote_fd.py AAPL
```

---

## Error Handling

### Common Errors

| Status | Provider | Meaning | Action |
|--------|----------|---------|--------|
| 401 | Finnhub | Invalid API key | Check FINNHUB_API_KEY |
| 401 | FD.net | Invalid API key | Check FINANCIALDATA_API_KEY |
| 429 | Finnhub | Rate limit hit | Wait 1 minute, retry |
| 429 | FD.net | Rate limit hit | Wait and retry |
| 404 | Either | Symbol not found | Verify ticker symbol |

### Fallback Strategy

```javascript
async function getQuoteWithFallback(symbol) {
  // Try Finnhub first (real-time)
  const finnhubQuote = await getFinnhubQuote(symbol);
  if (finnhubQuote.success) {
    return { ...finnhubQuote, source: 'Finnhub' };
  }

  // Fall back to financialdata.net (delayed)
  console.log('Finnhub failed, trying financialdata.net...');
  const fdQuote = await getFDQuote(symbol);
  if (fdQuote.success) {
    return { ...fdQuote, source: 'financialdata.net (delayed)' };
  }

  // Both failed
  return { symbol, error: 'All providers failed', success: false };
}
```

---

## Rate Limits

| Provider | Free Tier Limit |
|----------|-----------------|
| Finnhub | 60,000 calls/month (~2,000/day) |
| financialdata.net | 300 calls/day |

**Best practice**: Cache responses, don't re-query same symbol within 1 minute.

---

## Related Files

| File | Purpose |
|------|---------|
| `API.md` | Full API reference for both providers |
| `SETUP.md` | Detailed setup instructions |
| `EXAMPLES.md` | Usage examples |

---

## Related Skills

- **stock-picker** — Uses live-pricing for Phase 0 data freshness checks