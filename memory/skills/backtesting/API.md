# Finnhub API for Backtesting

Historical data endpoints for strategy backtesting.

Base URL: `https://finnhub.io/api/v1`

Authentication: Pass API key as `token` query parameter

---

## Historical Price Data

### Stock Candles

```
GET /stock/candle?symbol={SYMBOL}&resolution={RES}&from={FROM}&to={TO}&token={API_KEY}
```

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| symbol | string | Yes | Stock ticker (e.g., AAPL) |
| resolution | string | Yes | Timeframe: 1, 5, 15, 30, 60, D, W, M |
| from | number | Yes | Unix timestamp (start) |
| to | number | Yes | Unix timestamp (end) |
| token | string | Yes | Your API key |

**Resolution Options:**
| Code | Period |
|------|--------|
| 1 | 1 minute |
| 5 | 5 minutes |
| 15 | 15 minutes |
| 30 | 30 minutes |
| 60 | 1 hour |
| D | Daily |
| W | Weekly |
| M | Monthly |

**Response:**
```json
{
  "c": [175.50, 176.20, 174.80],  // Close prices
  "h": [176.00, 177.50, 175.20],  // High prices
  "l": [173.20, 174.00, 173.50],  // Low prices
  "o": [173.50, 175.00, 174.00],  // Open prices
  "t": [1234567890, 1234654290, 1234740690], // Timestamps (Unix)
  "v": [50000000, 45000000, 48000000],  // Volumes
  "s": "ok"  // Status ("ok" or "no_data")
}
```

**Example: Get 5 years of daily data**
```bash
# 5 years ago
FROM=$(date -v-5y +%s)
# Today
TO=$(date +%s)

curl "https://finnhub.io/api/v1/stock/candle?symbol=AAPL&resolution=D&from=$FROM&to=$TO&token=$FINNHUB_API_KEY"
```

**JavaScript Example:**
```javascript
async function getHistoricalPrices(symbol, from, to) {
  const url = `https://finnhub.io/api/v1/stock/candle?symbol=${symbol}&resolution=D&from=${from}&to=${to}&token=${API_KEY}`;
  const response = await fetch(url);
  const data = await response.json();

  if (data.s !== 'ok') {
    throw new Error(`No data for ${symbol}`);
  }

  // Convert arrays to objects
  return data.t.map((timestamp, i) => ({
    date: new Date(timestamp * 1000).toISOString().split('T')[0],
    open: data.o[i],
    high: data.h[i],
    low: data.l[i],
    close: data.c[i],
    volume: data.v[i]
  }));
}
```

---

## Historical Fundamentals

### Financial Statements

```
GET /stock/financials?symbol={SYMBOL}&statement={TYPE}&freq={FREQ}&token={API_KEY}
```

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| symbol | string | Yes | Stock ticker |
| statement | string | Yes | ic, bs, or cf |
| freq | string | Yes | annual or quarterly |
| token | string | Yes | Your API key |

**Statement Types:**
| Code | Statement |
|------|-----------|
| ic | Income Statement |
| bs | Balance Sheet |
| cf | Cash Flow |

**Response (Income Statement):**
```json
{
  "symbol": "AAPL",
  "financials": [
    {
      "date": "2025-12-31",
      "revenue": 391035000000,
      "costOfRevenue": 210000000000,
      "grossProfit": 181035000000,
      "operatingIncome": 120000000000,
      "netIncome": 95000000000,
      "eps": 6.11
    }
  ]
}
```

**Example: Get quarterly income statements**
```bash
curl "https://finnhub.io/api/v1/stock/financials?symbol=AAPL&statement=ic&freq=quarterly&token=$FINNHUB_API_KEY"
```

---

## Key Constraints

### 1. Metrics Endpoint = Current Only

The `/stock/metric` endpoint returns **current values only**, not historical series.

```
# This gives CURRENT P/E, not historical P/E
GET /stock/metric?symbol=AAPL&metric=all
```

**Solution:** Calculate historical ratios from raw financials:

```javascript
// Calculate historical P/E from price and EPS
function calculateHistoricalPE(priceData, incomeData) {
  return priceData.map(pricePoint => {
    // Find the most recent quarterly EPS available at this date
    const relevantEPS = findEPSAsOfDate(incomeData, pricePoint.date);

    // Apply 45-day lag (quarterly reports filed ~45 days after quarter end)
    const filingLag = 45;
    const adjustedDate = subtractDays(pricePoint.date, filingLag);
    const epsAsOfDate = findEPSAsOfDate(incomeData, adjustedDate);

    return {
      date: pricePoint.date,
      pe: epsAsOfDate ? pricePoint.close / epsAsOfDate : null
    };
  });
}
```

### 2. Reporting Lag

Apply 45-day lag for quarterly data to avoid look-ahead bias:

| Quarter End | Typical Filing Date | Use In Backtest From |
|-------------|---------------------|----------------------|
| Mar 31 | May 15 | May 15 |
| Jun 30 | Aug 14 | Aug 14 |
| Sep 30 | Nov 14 | Nov 14 |
| Dec 31 | Feb 14 | Feb 14 |

**Implementation:**
```javascript
function getAvailableDataDate(decisionDate) {
  // When making decision on decisionDate, what financials were available?
  // Apply 45-day lag from quarter end
  const quarterEnd = getPreviousQuarterEnd(decisionDate);
  const filingDate = addDays(quarterEnd, 45);

  return decisionDate >= filingDate ? quarterEnd : getPreviousQuarterEnd(quarterEnd);
}
```

### 3. Rate Limits

| Plan | Calls/Minute | Monthly Limit |
|------|--------------|---------------|
| Free | 60 | 60,000 |
| Starter | 600 | 100,000 |
| Developer | 600 | 300,000 |

**Batch with Delays:**
```javascript
async function batchFetch(symbols, fetchFn, delayMs = 1100) {
  const results = [];
  for (const symbol of symbols) {
    const data = await fetchFn(symbol);
    results.push(data);
    await sleep(delayMs); // Stay under 60/min
  }
  return results;
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
```

---

## Calculating Historical Ratios

### P/E Ratio
```javascript
// Historical P/E = Price / (Sum of last 4 quarters EPS)
function calculateHistoricalPE(price, quarterlyEPS) {
  // Trailing twelve months (TTM) EPS
  const ttmEPS = quarterlyEPS.slice(0, 4).reduce((sum, q) => sum + q.eps, 0);
  return price / ttmEPS;
}
```

### ROE (Return on Equity)
```javascript
// ROE = Net Income / Shareholders' Equity
function calculateROE(incomeStatement, balanceSheet) {
  const netIncome = incomeStatement.netIncome;
  const shareholdersEquity = balanceSheet.totalAssets - balanceSheet.totalLiabilities;
  return netIncome / shareholdersEquity;
}
```

### D/E (Debt-to-Equity)
```javascript
// D/E = Total Debt / Shareholders' Equity
function calculateDE(balanceSheet) {
  const totalDebt = balanceSheet.longTermDebt + balanceSheet.shortTermDebt;
  const shareholdersEquity = balanceSheet.totalAssets - balanceSheet.totalLiabilities;
  return totalDebt / shareholdersEquity;
}
```

### PEG Ratio
```javascript
// PEG = P/E / Earnings Growth Rate (%)
function calculatePEG(peRatio, earningsGrowthPercent) {
  return peRatio / earningsGrowthPercent;
}

// Earnings growth = (Current EPS - Prior Year EPS) / Prior Year EPS
function calculateEarningsGrowth(currentEPS, priorYearEPS) {
  return ((currentEPS - priorYearEPS) / priorYearEPS) * 100;
}
```

---

## Data Validation

Before running backtest, validate data quality:

```javascript
function validateBacktestData(priceData, financialData) {
  const issues = [];

  // Check for price gaps
  const priceDates = priceData.map(p => p.date);
  const missingDays = findMissingTradingDays(priceDates);
  if (missingDays.length > 0) {
    issues.push(`Missing ${missingDays.length} trading days`);
  }

  // Check for stale financials
  const latestFiling = financialData[0]?.date;
  const daysSinceFiling = daysBetween(latestFiling, new Date());
  if (daysSinceFiling > 120) {
    issues.push(`Financials ${daysSinceFiling} days old`);
  }

  // Check for negative equity (avoid ROE calculation issues)
  const negativeEquityQuarters = financialData.filter(
    f => (f.totalAssets - f.totalLiabilities) < 0
  );
  if (negativeEquityQuarters.length > 0) {
    issues.push(`${negativeEquityQuarters.length} quarters with negative equity`);
  }

  return { valid: issues.length === 0, issues };
}
```

---

## Example: Full Backtest Data Fetch

```javascript
async function fetchBacktestData(symbol, startDate, endDate) {
  const from = Math.floor(new Date(startDate).getTime() / 1000);
  const to = Math.floor(new Date(endDate).getTime() / 1000);

  // Fetch in parallel
  const [prices, income, balance, cashFlow] = await Promise.all([
    fetch(`/stock/candle?symbol=${symbol}&resolution=D&from=${from}&to=${to}`).then(r => r.json()),
    fetch(`/stock/financials?symbol=${symbol}&statement=ic&freq=quarterly`).then(r => r.json()),
    fetch(`/stock/financials?symbol=${symbol}&statement=bs&freq=quarterly`).then(r => r.json()),
    fetch(`/stock/financials?symbol=${symbol}&statement=cf&freq=quarterly`).then(r => r.json())
  ]);

  return {
    symbol,
    prices: formatPriceData(prices),
    income: income.financials,
    balance: balance.financials,
    cashFlow: cashFlow.financials
  };
}
```

---

## Related

- `live-pricing/API.md` — Real-time price endpoints
- `METRICS.md` — How to use this data for performance calculations
