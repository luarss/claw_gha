# Live Pricing Skill

## Purpose
Fetch real-time stock prices via the Finnhub API for fast, reliable price data retrieval in stock analysis workflows.

---

## Why Finnhub

| Feature | Details |
|---------|---------|
| **Free Tier** | 60 API calls/minute (generous for individual use) |
| **Real-time** | US stock prices with minimal delay |
| **Simple API** | Clean REST endpoints, easy to integrate |
| **No Credit Card** | Required for free tier signup |
| **Reliability** | Well-maintained with good uptime |

---

## Capabilities

1. **Real-time Quotes** — Current price, change, day high/low
2. **Batch Quotes** — Multiple symbols in parallel
3. **Price History** — Historical candles for technical analysis
4. **Company Profile** — Basic company information

---

## Setup

### 1. Get API Key

1. Visit [finnhub.io](https://finnhub.io)
2. Sign up with email (no credit card required)
3. Navigate to Dashboard → API Keys
4. Copy your API key

### 2. Configure Environment

Add to your `.env` file:
```bash
FINNHUB_API_KEY=your_api_key_here
```

### 3. Verify Setup

Test the API:
```bash
curl "https://finnhub.io/api/v1/quote?symbol=AAPL&token=$FINNHUB_API_KEY"
```

Expected response:
```json
{"c":175.50,"d":2.30,"dp":1.33,"h":176.00,"l":173.20,"o":173.50,"pc":173.20,"t":1234567890}
```

---

## Usage in Analysis Workflow

### When to Use

Use this skill in **Phase 0: Data Freshness Check** of the stock-picker workflow:

1. **Before any analysis** — Fetch current price
2. **Timestamp verification** — Confirm data is from current trading day
3. **Price validation** — Cross-check against other sources

### Integration Pattern

```
1. Check FINNHUB_API_KEY is available
2. Fetch quote for target symbol
3. Log price with timestamp
4. Proceed with stock-picker analysis
5. Fall back to web search if API unavailable
```

---

## Response Interpretation

### Quote Response Fields

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

### Price Freshness Check

```python
import time

# Check if price is stale (> 24 hours old)
current_time = time.time()
price_age_hours = (current_time - response['t']) / 3600

if price_age_hours > 24:
    print("WARNING: Price data may be stale")
```

---

## Error Handling

### Common Errors

| Status | Meaning | Action |
|--------|---------|--------|
| 401 | Invalid API key | Check FINNHUB_API_KEY |
| 429 | Rate limit hit | Wait 1 minute, retry |
| 404 | Symbol not found | Verify ticker symbol |

### Fallback Strategy

If Finnhub is unavailable:
1. Log the error
2. Fall back to web search (Yahoo Finance, FinViz)
3. Note data source limitation in analysis

---

## Rate Limits

- **Free tier**: 60 calls/minute
- **Best practice**: Cache responses, don't re-query same symbol within 1 minute
- **Batch requests**: Make multiple symbol calls in parallel (counts toward limit)

---

## Related Files

| File | Purpose |
|------|---------|
| `API.md` | Full API reference and endpoints |
| `EXAMPLES.md` | Usage examples with curl and JavaScript |

---

## Related Skills

- **stock-picker** — Uses live-pricing for Phase 0 data freshness checks
