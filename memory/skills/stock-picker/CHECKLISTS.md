# Analysis Checklists

Quick-reference checklists for each investment methodology.

---

## Data Quality Checklist (Do First)

Before any analysis, verify data integrity:

- [ ] **Price data is current** (today or prior close)
- [ ] **Financial statement age** (< 90 days for quarterly, < 365 for annual)
- [ ] **No material news** in last 24h that changes thesis
- [ ] **Price verified** from 2+ sources (Yahoo + FinViz/broker)
- [ ] **Key metrics verified** against primary source (SEC filing or company IR)
- [ ] **Timestamp recorded**: Analysis timestamp in UTC format

**If data is stale**: Note limitation prominently, consider delaying analysis

---

## Boundary Zone Checklist

When metrics fall within 10% of thresholds:

- [ ] **Identify boundary cases**: List metrics within tolerance zones
- [ ] **Seek confirmation**: Do 2+ other metrics agree?
- [ ] **Reduce if mixed**: Cut position size 50% for conflicting signals
- [ ] **Wait if uncertain**: Better entry points exist

**Example**: P/E = 16 (boundary of 15 threshold)
- Check PEG, P/B, EV/EBITDA for confirmation
- If 2+ confirm "undervalued": Proceed
- If mixed: Reduce conviction, smaller position
- If most say "overvalued": Skip

---

## Value Investing Checklist (Buffett Style)

### Economic Moat Assessment
- [ ] **Brand Power**: Does the company have strong brand recognition?
- [ ] **Network Effects**: Does value increase with more users?
- [ ] **Switching Costs**: Would customers lose money/time by switching?
- [ ] **Cost Advantages**: Can they produce cheaper than competitors?
- [ ] **Patents/IP**: Protected intellectual property?
- [ ] **Regulatory Moat**: Licenses, permits that are hard to obtain?

**Moat Score**: /6 (Strong: 5-6, Moderate: 3-4, Weak: 0-2)

### Financial Quality
- [ ] ROE consistently > 15% over 5+ years
- [ ] Positive free cash flow for 5+ years
- [ ] Debt-to-equity < 0.5 (or < 1.0 for capital-intensive)
- [ ] Current ratio > 1.5
- [ ] Interest coverage > 5x
- [ ] Earnings stability (no big swings year-to-year)

### Management Quality
- [ ] Insider ownership > 5%
- [ ] Management tenure > 5 years
- [ ] Honest, shareholder-friendly communication
- [ ] Rational capital allocation (dividends, buybacks, M&A)
- [ ] No accounting red flags or restatements
- [ ] Reasonable executive compensation

### Valuation
- [ ] P/E below historical average
- [ ] P/E below industry average
- [ ] Price at least 25% below intrinsic value (DCF)
- [ ] EV/EBITDA < 12

### Margin of Safety
- [ ] Conservative assumptions in valuation
- [ ] Buffer for unexpected events
- [ ] Can hold for 5+ years if needed

---

## Growth Investing Checklist (Lynch Style)

### Stock Classification
First, categorize the stock:

| Category | Characteristics | Strategy |
|----------|----------------|----------|
| **Stalwart** | 10-12% growth, large cap, dividend | Buy on dips, hold long-term |
| **Fast Grower** | 20-25%+ growth, small-mid cap | High conviction, watch for slowdown |
| **Cyclical** | Economy-dependent earnings | Time the cycle, exit before peak |
| **Turnaround** | Distressed, restructuring | Asymmetric bet, small position |
| **Asset Play** | Hidden value on balance sheet | Identify overlooked assets |

### PEG Analysis
- [ ] Calculate PEG ratio: P/E ÷ Growth Rate
- [ ] PEG < 1.0 = Undervalued
- [ ] PEG 1.0-1.5 = Fair value
- [ ] Compare to industry PEG

### Earnings Quality
- [ ] Earnings growth rate 15-30% (sustainable range)
- [ ] Revenue growing alongside earnings
- [ ] Not reliant on one-time gains
- [ ] Consistent earnings beats or meets
- [ ] Strong guidance from management

### "Buy What You Know" Signals
- [ ] Do you understand the product/service?
- [ ] Is it a company you encounter in daily life?
- [ ] Is there a clear growth runway?
- [ ] Is the story simple enough to explain?

### Growth Red Flags
- [ ] Growth rate > 50% (rarely sustainable)
- [ ] Heavy stock-based compensation
- [ ] Dilution from frequent secondary offerings
- [ ] Growth via acquisition (quality risk)
- [ ] Declining margins as they scale

### Lynch's "Perfect Stock" Traits
- [ ] Boring business (less competition)
- [ ] Dull name or industry
- [ ] Doing something unglamorous
- [ ] Institutionally neglected
- [ ] Negative sentiment around it
- [ ] Has a niche or monopoly element
- [ ] Products people keep buying

---

## Macro-Technical Checklist (Druckenmiller Style)

### Top-Down Macro Analysis
- [ ] **Economic Cycle**: Where are we? (Early, Mid, Late, Recession)
- [ ] **Interest Rate Direction**: Rising, falling, or stable?
- [ ] **Sector Rotation**: What sectors are in favor?
- [ ] **Currency Impact**: FX headwinds or tailwinds?
- [ ] **Commodity Trends**: Input cost implications?
- [ ] **Geopolitical Risks**: Trade wars, sanctions, instability?

### Sector Rotation Map
```
Early Cycle: Financials, Consumer Discretionary, Industrials
Mid Cycle: Technology, Basic Materials
Late Cycle: Energy, Materials, Healthcare
Recession: Utilities, Consumer Staples, Healthcare
```

### Risk-Reward Assessment
- [ ] **Upside Target**: Based on fundamentals + catalysts
- [ ] **Downside Risk**: Based on support levels + thesis failure
- [ ] **Ratio**: Upside ÷ Downside ≥ 3:1 required
- [ ] **Probability**: What's the realistic chance of success?

### Conviction Levels
| Conviction | Requirements | Position Size |
|------------|--------------|---------------|
| High | 5:1+ R/R, strong thesis, catalyst visible | 5-10% |
| Medium | 3:1-5:1 R/R, reasonable thesis | 2-5% |
| Low | < 3:1 R/R, uncertain thesis | Watch only |

### Technical Entry Timing
- [ ] Price above 200-day moving average (uptrend)
- [ ] Price above 50-day moving average (short-term strength)
- [ ] RSI not overbought (< 70)
- [ ] Recent pullback to support level
- [ ] Volume confirming price moves
- [ ] No major resistance directly overhead

### Exit Planning
- [ ] Define price target before entry
- [ ] Define stop loss before entry
- [ ] Plan for partial profit-taking
- [ ] Set timeline for thesis to play out

---

## Quantitative Checklist (Simons Style)

### Momentum Indicators

#### RSI (Relative Strength Index)
- [ ] RSI > 70: Overbought (potential reversal down)
- [ ] RSI 40-60: Neutral
- [ ] RSI < 30: Oversold (potential reversal up)
- [ ] Divergence: Price makes new high, RSI doesn't = bearish

#### MACD
- [ ] MACD crosses above signal line = Bullish
- [ ] MACD crosses below signal line = Bearish
- [ ] Histogram expanding = Momentum strengthening
- [ ] Histogram contracting = Momentum weakening

#### Moving Averages
- [ ] Price > 50 MA > 200 MA = Strong uptrend
- [ ] Price < 50 MA < 200 MA = Strong downtrend
- [ ] Golden Cross: 50 MA crosses above 200 MA
- [ ] Death Cross: 50 MA crosses below 200 MA

### Volume Analysis
- [ ] Volume increasing on up days = Accumulation
- [ ] Volume increasing on down days = Distribution
- [ ] Low volume rally = Weak (potential trap)
- [ ] Volume spike on breakout = Confirms move

### Mean Reversion Signals
- [ ] Distance from 200-day MA (extreme = reversion likely)
- [ ] Distance from 52-week high/low
- [ ] Z-score of current price vs historical
- [ ] Bollinger Band position (outside bands = extreme)

### Statistical Patterns
- [ ] Seasonality: Does stock have seasonal patterns?
- [ ] Earnings drift: Post-earnings price movement tendency
- [ ] Day-of-week patterns (if consistent)
- [ ] Options flow: Unusual call/put activity

### Quantitative Screens
```
Momentum Screen:
- Price > 50-day MA
- Price > 200-day MA
- RSI between 40-70
- 3-month return > S&P 500

Mean Reversion Screen:
- Price > 20% below 200-day MA
- RSI < 30
- Near 52-week low
- Fundamentals still intact
```

---

## Pre-Trade Checklist

Before executing any trade:

- [ ] **Data freshness verified** (price current, financials < 90 days)
- [ ] **Output validation passed** (numbers cross-checked)
- [ ] Thesis documented in MEMORY.md with UTC timestamp
- [ ] Entry price defined
- [ ] Stop loss price defined
- [ ] Price target defined
- [ ] Risk-reward ratio ≥ 3:1
- [ ] Position size appropriate (≤ 10% portfolio)
- [ ] No recent major news requiring reassessment
- [ ] Alternative viewpoints considered
- [ ] "What could go wrong" scenarios listed
- [ ] Timeline for thesis to play out defined
- [ ] Boundary zones handled appropriately

---

## Post-Trade Checklist

After executing a trade:

- [ ] Record entry in MEMORY.md with UTC timestamp (YYYY-MM-DD HH:MM UTC)
- [ ] Document data sources used
- [ ] Set price alerts for target and stop
- [ ] Schedule thesis review (monthly)
- [ ] Note any catalysts to watch
- [ ] Define conditions that would trigger exit early

---

## Output Validation Checklist

Before finalizing any analysis:

- [ ] **Number sanity check**: P/E × EPS ≈ Price (within 5%)
- [ ] **Market cap sanity**: Price × Shares ≈ Market Cap
- [ ] **EV sanity**: Market Cap + Debt - Cash ≈ EV
- [ ] **All numbers sourced**: Every metric has attribution
- [ ] **Unverified items flagged**: Uncertain values clearly marked
- [ ] **Confidence assigned**: High/Medium/Low based on source quality
- [ ] **No hallucinations**: Metrics consistent with industry norms
