# Valuation Methods & Formulas

Reference guide for stock valuation techniques.

---

## Price Ratios

### Price-to-Earnings (P/E)
```
P/E = Stock Price / Earnings Per Share (EPS)
```

**Interpretation:**
- P/E < 15: Potentially undervalued (or declining business)
- P/E 15-25: Fair value for mature company
- P/E 25-40: Growth premium expected
- P/E > 40: High growth OR overvalued

**Caveats:**
- Use forward P/E for growth companies
- Compare to industry average and historical range
- Negative earnings = P/E meaningless

---

### PEG Ratio (Price/Earnings-to-Growth)
```
PEG = P/E Ratio / EPS Growth Rate (%)
```

**Interpretation (Lynch's Favorite):**
- PEG < 0.5: Significantly undervalued
- PEG 0.5-1.0: Undervalued
- PEG 1.0-1.5: Fair value
- PEG 1.5-2.0: Slightly overvalued
- PEG > 2.0: Overvalued

**Example:**
- Stock with P/E 30 growing at 30% = PEG 1.0 (fair)
- Stock with P/E 30 growing at 15% = PEG 2.0 (expensive)

---

### Price-to-Book (P/B)
```
P/B = Stock Price / Book Value Per Share
```

**Interpretation:**
- P/B < 1.0: Trading below liquidation value (distress or value)
- P/B 1.0-3.0: Reasonable for most companies
- P/B > 5.0: Significant intangible value or overvalued

**Best For:** Banks, insurance, asset-heavy businesses
**Avoid For:** Tech, services (intangible-heavy)

---

### Price-to-Sales (P/S)
```
P/S = Market Cap / Annual Revenue
```

**Interpretation:**
- P/S < 1.0: Deep value (or declining business)
- P/S 1.0-3.0: Reasonable
- P/S > 10.0: Hypergrowth priced in

**Best For:** Unprofitable growth companies (use when P/E is negative)

---

## Enterprise Value Ratios

### EV/EBITDA
```
Enterprise Value = Market Cap + Debt - Cash
EV/EBITDA = Enterprise Value / EBITDA
```

**Interpretation:**
- EV/EBITDA < 8: Potentially undervalued
- EV/EBITDA 8-12: Fair value
- EV/EBITDA > 15: Premium valuation

**Advantages:**
- Capital structure neutral (can compare across debt levels)
- Works for companies with different depreciation policies

---

### EV/Revenue
```
EV/Revenue = Enterprise Value / Annual Revenue
```

**Best For:** High-growth, unprofitable companies
**Interpretation:** Similar to P/S but accounts for debt

---

## Cash Flow Valuation

### Price-to-Free-Cash-Flow (P/FCF)
```
Free Cash Flow = Operating Cash Flow - Capital Expenditures
P/FCF = Market Cap / Free Cash Flow
```

**Interpretation:**
- P/FCF < 15: Undervalued
- P/FCF 15-25: Fair value
- P/FCF > 30: Expensive OR high capex growth phase

**Buffett's Preference:** FCF is the true measure of business quality

---

### Discounted Cash Flow (DCF)
```
Intrinsic Value = Sum of Discounted Future Cash Flows

PV = FCF / (1 + r)^n

Where:
- FCF = Future Free Cash Flow
- r = Discount rate (WACC, typically 8-12%)
- n = Number of years
```

**Simplified DCF Steps:**
1. Project FCF for 5-10 years (use conservative growth)
2. Calculate terminal value (FCF × (1+g) / (r-g))
3. Discount all to present value
4. Divide by shares outstanding

**Margin of Safety:**
- Buy if market price is 25%+ below intrinsic value
- Higher uncertainty = require larger margin

---

## Profitability Metrics

### Return on Equity (ROE)
```
ROE = Net Income / Shareholder's Equity
```

**Buffett's Benchmark:**
- ROE > 15%: Excellent
- ROE 12-15%: Good
- ROE < 10%: Poor (unless special situation)

**DuPont Analysis:**
```
ROE = Net Profit Margin × Asset Turnover × Equity Multiplier
```

---

### Return on Invested Capital (ROIC)
```
ROIC = NOPAT / Invested Capital

NOPAT = Operating Income × (1 - Tax Rate)
Invested Capital = Debt + Equity - Cash
```

**Interpretation:**
- ROIC > 15%: Excellent capital allocation
- ROIC > WACC: Creating value
- ROIC < WACC: Destroying value

---

### Free Cash Flow Margin
```
FCF Margin = Free Cash Flow / Revenue
```

**Interpretation:**
- FCF Margin > 15%: Cash-generating machine
- FCF Margin 5-15%: Healthy
- FCF Margin < 5%: Capital intensive or inefficient

---

## Balance Sheet Metrics

### Current Ratio
```
Current Ratio = Current Assets / Current Liabilities
```

**Interpretation:**
- > 2.0: Strong liquidity
- 1.0-2.0: Adequate
- < 1.0: Potential liquidity issues

---

### Debt-to-Equity (D/E)
```
D/E = Total Debt / Shareholder's Equity
```

**Interpretation:**
- D/E < 0.5: Conservative
- D/E 0.5-1.0: Moderate
- D/E > 1.0: Aggressive (sector dependent)
- D/E > 2.0: High leverage risk

**Buffett's Preference:** D/E < 0.5 for most businesses

---

### Interest Coverage Ratio
```
Interest Coverage = EBIT / Interest Expense
```

**Interpretation:**
- > 5: Safe
- 2-5: Adequate
- < 2: Risk of default if earnings decline

---

## Growth Metrics

### Revenue Growth Rate
```
YoY Growth = (Current Revenue - Prior Revenue) / Prior Revenue × 100
CAGR = (End Value / Start Value)^(1/n) - 1
```

**Sustainable Growth Rates:**
- 0-5%: Mature, slow-growth
- 5-15%: Healthy growth
- 15-30%: High growth (verify sustainability)
- > 30%: Hypergrowth (rarely sustainable long-term)

---

### Earnings Growth Consistency
Look for:
- Consistent growth (not erratic)
- Growth from operations (not one-time gains)
- Earnings quality (cash conversion)

---

## Valuation Quick Reference

| Metric | Undervalued | Fair | Overvalued |
|--------|-------------|------|------------|
| P/E | < 15 | 15-25 | > 40 |
| PEG | < 1.0 | 1.0-1.5 | > 2.0 |
| P/B | < 1.5 | 1.5-3.0 | > 5.0 |
| P/FCF | < 15 | 15-25 | > 30 |
| EV/EBITDA | < 8 | 8-12 | > 15 |
| ROE | > 15% | 10-15% | < 10% |
| D/E | < 0.5 | 0.5-1.0 | > 2.0 |

**Note:** Always compare to industry peers and historical averages. Thresholds vary by sector.
