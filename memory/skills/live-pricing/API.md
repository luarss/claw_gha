# Finnhub API Reference

Base URL: `https://finnhub.io/api/v1`

Authentication: Pass API key as `token` query parameter

---

## Endpoints

### Real-Time Quote

```
GET /quote?symbol={SYMBOL}&token={API_KEY}
```

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| symbol | string | Yes | Stock ticker (e.g., AAPL) |
| token | string | Yes | Your API key |

**Response:**
```json
{
  "c": 175.50,    // Current price
  "d": 2.30,      // Change
  "dp": 1.33,     // Change percent
  "h": 176.00,    // High price of the day
  "l": 173.20,    // Low price of the day
  "o": 173.50,    // Open price of the day
  "pc": 173.20,   // Previous close price
  "t": 1234567890 // Timestamp (Unix epoch)
}
```

**Example:**
```bash
curl "https://finnhub.io/api/v1/quote?symbol=AAPL&token=$FINNHUB_API_KEY"
```

---

### Stock Candles (Historical Prices)

```
GET /stock/candle?symbol={SYMBOL}&resolution={RES}&from={FROM}&to={TO}&token={API_KEY}
```

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| symbol | string | Yes | Stock ticker |
| resolution | string | Yes | Timeframe: 1, 5, 15, 30, 60, D, W, M |
| from | number | Yes | Unix timestamp (start) |
| to | number | Yes | Unix timestamp (end) |
| token | string | Yes | Your API key |

**Response:**
```json
{
  "c": [175.50, 176.20, 174.80],  // Close prices
  "h": [176.00, 177.50, 175.20],  // High prices
  "l": [173.20, 174.00, 173.50],  // Low prices
  "o": [173.50, 175.00, 174.00],  // Open prices
  "t": [1234567890, 1234654290, 1234740690], // Timestamps
  "v": [50000000, 45000000, 48000000],  // Volumes
  "s": "ok"  // Status
}
```

**Example:**
```bash
# Get last 30 days of daily candles
FROM=$(date -v-30d +%s)
TO=$(date +%s)
curl "https://finnhub.io/api/v1/stock/candle?symbol=AAPL&resolution=D&from=$FROM&to=$TO&token=$FINNHUB_API_KEY"
```

---

### Company Profile

```
GET /stock/profile2?symbol={SYMBOL}&token={API_KEY}
```

**Response:**
```json
{
  "country": "US",
  "currency": "USD",
  "exchange": "NASDAQ",
  "finnhubIndustry": "Technology",
  "ipo": "1980-12-12",
  "logo": "https://static.finnhub.io/logo/...",
  "marketCapitalization": 2800000,
  "name": "Apple Inc",
  "phone": "14089961010",
  "shareOutstanding": 15.5,
  "ticker": "AAPL",
  "weburl": "https://www.apple.com"
}
```

**Example:**
```bash
curl "https://finnhub.io/api/v1/stock/profile2?symbol=AAPL&token=$FINNHUB_API_KEY"
```

---

### Basic Financials

```
GET /stock/metric?symbol={SYMBOL}&metric=all&token={API_KEY}
```

**Response:** Contains extensive financial metrics including P/E, revenue, margins, etc.

**Example:**
```bash
curl "https://finnhub.io/api/v1/stock/metric?symbol=AAPL&metric=all&token=$FINNHUB_API_KEY"
```

---

### Market News

```
GET /company-news?symbol={SYMBOL}&from={FROM}&to={TO}&token={API_KEY}
```

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| symbol | string | Yes | Stock ticker |
| from | string | Yes | Start date (YYYY-MM-DD) |
| to | string | Yes | End date (YYYY-MM-DD) |

**Example:**
```bash
curl "https://finnhub.io/api/v1/company-news?symbol=AAPL&from=2026-03-01&to=2026-03-11&token=$FINNHUB_API_KEY"
```

---

## Rate Limits

| Plan | Calls/Minute | Monthly Limit |
|------|--------------|---------------|
| Free | 60 | 60,000 |
| Starter | 600 | 100,000 |
| Developer | 600 | 300,000 |

---

## Error Responses

| Status Code | Meaning |
|-------------|---------|
| 200 | Success |
| 400 | Bad Request — Invalid parameters |
| 401 | Unauthorized — Invalid API key |
| 403 | Forbidden — Endpoint not available on plan |
| 404 | Not Found — Symbol not found |
| 429 | Too Many Requests — Rate limit exceeded |

**Error Response Format:**
```json
{
  "error": "Invalid API key"
}
```

---

## Best Practices

### Caching
```javascript
// Cache quotes for 60 seconds to avoid rate limits
const quoteCache = new Map();
const CACHE_TTL = 60000;

async function getQuote(symbol) {
  const cached = quoteCache.get(symbol);
  if (cached && Date.now() - cached.timestamp < CACHE_TTL) {
    return cached.data;
  }

  const response = await fetch(
    `https://finnhub.io/api/v1/quote?symbol=${symbol}&token=${API_KEY}`
  );
  const data = await response.json();

  quoteCache.set(symbol, { data, timestamp: Date.now() });
  return data;
}
```

### Batch Requests
```javascript
// Fetch multiple symbols in parallel
async function getQuotes(symbols) {
  return Promise.all(
    symbols.map(symbol =>
      fetch(`https://finnhub.io/api/v1/quote?symbol=${symbol}&token=${API_KEY}`)
        .then(res => res.json())
        .then(data => ({ symbol, ...data }))
    )
  );
}
```

### Error Handling
```javascript
async function safeGetQuote(symbol) {
  try {
    const response = await fetch(
      `https://finnhub.io/api/v1/quote?symbol=${symbol}&token=${API_KEY}`
    );

    if (response.status === 429) {
      console.warn('Rate limit hit, waiting 60s...');
      await new Promise(r => setTimeout(r, 60000));
      return safeGetQuote(symbol); // Retry
    }

    if (!response.ok) {
      throw new Error(`API error: ${response.status}`);
    }

    return await response.json();
  } catch (error) {
    console.error(`Failed to fetch quote for ${symbol}:`, error.message);
    return null;
  }
}
```

---

## SDK Libraries

### JavaScript/Node.js
```bash
npm install finnhub
```

```javascript
const finnhub = require('finnhub');
const api_key = finnhub.ApiClient.instance.authentications['api_key'];
api_key.apiKey = process.env.FINNHUB_API_KEY;

const finnhubClient = new finnhub.DefaultApi();
finnhubClient.quote("AAPL", (error, data, response) => {
  console.log(data);
});
```

### Python
```bash
pip install finnhub-python
```

```python
import finnhub
finnhub_client = finnhub.Client(api_key="YOUR_API_KEY")

print(finnhub_client.quote('AAPL'))
```
