# Pre-Defined Backtesting Strategies

Strategies aligned with the four-investor methodology from `SOUL.md`.

---

## Strategy 1: Low P/E + High ROE (Buffett)

**Philosophy:** Buy wonderful companies at fair prices

| Parameter | Value |
|-----------|-------|
| **Entry Criteria** | P/E < 15, ROE > 15%, D/E < 0.5 |
| **Exit Criteria** | P/E > 25, ROE < 10%, OR 6-month hold |
| **Universe** | S&P 500 |
| **Rebalancing** | Quarterly |
| **Position Size** | Equal weight (max 20 positions) |

**Rationale:**
- P/E < 15 screens for value
- ROE > 15% screens for quality (capital allocation efficiency)
- D/E < 0.5 screens for financial safety
- 6-month hold enforces patience

**Expected Profile:**
- Lower volatility
- Moderate returns
- Works best in flat/down markets

---

## Strategy 2: PEG < 1.0 (Lynch)

**Philosophy:** Growth at reasonable price

| Parameter | Value |
|-----------|-------|
| **Entry Criteria** | PEG < 1.0, Earnings growth 15-30% |
| **Exit Criteria** | PEG > 1.5, Growth < 10%, OR 6-month hold |
| **Universe** | Russell 1000 |
| **Rebalancing** | Quarterly |
| **Position Size** | Equal weight (max 25 positions) |

**Rationale:**
- PEG < 1.0 indicates undervalued growth
- 15-30% growth is sustainable (avoids hypergrowth traps)
- Broad universe captures mid-cap opportunities

**Expected Profile:**
- Higher volatility
- Strong bull market performance
- Risk: Growth deceleration

---

## Strategy 3: Quality Compounders (Hybrid)

**Philosophy:** Long-term compounding with quality metrics

| Parameter | Value |
|-----------|-------|
| **Entry Criteria** | ROE > 20%, FCF yield > 10%, P/E < 25 |
| **Exit Criteria** | ROE < 15%, FCF yield < 5%, OR 12-month hold |
| **Universe** | S&P 500 |
| **Rebalancing** | Semi-annually |
| **Position Size** | Equal weight (max 15 positions) |

**Rationale:**
- ROE > 20% = exceptional capital allocation
- FCF yield > 10% = cash generation vs price
- P/E < 25 = reasonable valuation for quality
- 12-month hold = longer horizon for compounding

**Expected Profile:**
- Lower turnover
- Consistent returns
- Works across market cycles

---

## Strategy 4: Fast Grower (Lynch)

**Philosophy:** Capture explosive growth at reasonable prices

| Parameter | Value |
|-----------|-------|
| **Entry Criteria** | Earnings growth 25-50%, P/E < 30, Revenue growth > 20% |
| **Exit Criteria** | Growth < 15%, P/E > 40, OR 12-month hold |
| **Universe** | Russell 2000 + Nasdaq 100 |
| **Rebalancing** | Quarterly |
| **Position Size** | Equal weight (max 20 positions) |

**Rationale:**
- 25-50% growth captures expansion phase
- P/E < 30 avoids extreme speculation
- Revenue growth confirms earnings quality
- Small/mid-cap universe for growth potential

**Expected Profile:**
- High volatility
- Strong bull market outperformance
- Risk: Multiple compression on growth slowdown

---

## Strategy 5: Oversold Quality (Simons)

**Philosophy:** Quantitative mean reversion on quality stocks

| Parameter | Value |
|-----------|-------|
| **Entry Criteria** | Price 20%+ below 200-day MA, ROE > 15%, Volume spike |
| **Exit Criteria** | Return to 200-day MA, OR 3-month hold |
| **Universe** | S&P 500 |
| **Rebalancing** | Monthly |
| **Position Size** | Risk-weighted (max 15 positions) |

**Rationale:**
- 20% below 200MA = statistically oversold
- ROE > 15% ensures quality (avoids value traps)
- Volume spike confirms selling climax
- Quick 3-month hold for mean reversion

**Expected Profile:**
- Short holding periods
- Works in volatile/sideways markets
- Risk: Catching falling knives (quality filter helps)

---

## Strategy 6: Value + Momentum (Hybrid)

**Philosophy:** Combine value with trend confirmation

| Parameter | Value |
|-----------|-------|
| **Entry Criteria** | P/E < 20, P/B < 3, Price > 50-day MA, RSI < 70 |
| **Exit Criteria** | Price < 200-day MA, P/E > 30, OR 6-month hold |
| **Universe** | S&P 500 |
| **Rebalancing** | Monthly |
| **Position Size** | Equal weight (max 20 positions) |

**Rationale:**
- Value metrics (P/E, P/B) screen for cheap stocks
- Momentum filter (50MA) avoids catching falling knives
- RSI < 70 avoids overbought entries
- Trend-following exit (200MA) protects downside

**Expected Profile:**
- Balanced value/momentum exposure
- Reduced drawdowns vs pure value
- Works across market regimes

---

## Custom Strategy Template

Use this template to define new strategies:

```
### Strategy: [Name]

**Philosophy:** [One-sentence investment thesis]

| Parameter | Value |
|-----------|-------|
| **Entry Criteria** | [List all conditions] |
| **Exit Criteria** | [List all conditions] |
| **Universe** | [Stock pool] |
| **Rebalancing** | [Frequency] |
| **Position Size** | [Method] |

**Rationale:**
- [Why these criteria work together]
- [What market conditions favor this strategy]
- [Key risks]

**Expected Profile:**
- Volatility: [Low/Medium/High]
- Best Market: [Bull/Bear/Sideways/All]
- Key Risk: [Primary risk factor]
```

---

## Strategy Selection Guide

| Market Regime | Best Strategies |
|---------------|-----------------|
| Bull Market | PEG < 1.0, Fast Grower |
| Bear Market | Low P/E + High ROE, Quality Compounders |
| Volatile/Sideways | Oversold Quality, Value + Momentum |
| Rising Rates | Quality Compounders, Low P/E + High ROE |
| Falling Rates | Fast Grower, PEG < 1.0 |

---

## Methodology Alignment

| Strategy | Primary Methodology | Secondary |
|----------|--------------------| ----------|
| Low P/E + High ROE | Buffett | — |
| PEG < 1.0 | Lynch | — |
| Quality Compounders | Buffett | Lynch |
| Fast Grower | Lynch | — |
| Oversold Quality | Simons | Buffett |
| Value + Momentum | Simons | Buffett |
