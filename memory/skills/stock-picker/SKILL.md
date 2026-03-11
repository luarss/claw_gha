# Stock Picker Skill

## Purpose
Analyze stocks using a synthesis of world-class investor methodologies to identify high-quality opportunities with favorable risk-reward profiles.

---

## Investment Philosophy

This skill synthesizes four proven approaches with **equal emphasis**:

| Methodology | Originator | Core Focus |
|-------------|------------|------------|
| Value Investing | Warren Buffett | Economic moats, margin of safety, quality at fair price |
| Growth at Reasonable Price | Peter Lynch | PEG ratio, earnings growth, "buy what you know" |
| Macro-Technical | Stanley Druckenmiller | Top-down analysis, asymmetric risk-reward, timing |
| Quantitative | Jim Simons | Pattern recognition, momentum, statistical signals |

---

## Analysis Workflow

### Phase 0: Data Freshness Check (1 minute)
**CRITICAL: Do this before any analysis**

Before proceeding, verify data is current:

1. **Price Data Timestamp**
   - Price must be from current trading day (or prior close if pre-market)
   - If price is > 1 trading day old: HALT and fetch fresh data

2. **Financial Data Age**
   - 10-Q data: Should be < 90 days old
   - 10-K data: Should be < 365 days old
   - If data is stale: Note limitation in analysis

3. **News Recency**
   - Check for material news in last 24 hours
   - Earnings, guidance, M&A can invalidate prior analysis

**Data Quality Log Format:**
```
### Data Quality Check — [YYYY-MM-DD HH:MM UTC]
- Price: $X.XX (as of [timestamp])
- Financials: 10-Q dated [date]
- News scan: [clear/material news found]
- FRESHNESS: [PASS/STALE/RETRY]
```

---

### Phase 1: Quick Screen (2 minutes)
Purpose: Rapid viability check before deep analysis

1. **Basic Health Check**
   - Market cap > $1B (avoid micro-caps)
   - Average daily volume > 1M shares
   - No imminent bankruptcy risk (current ratio > 1)
   - Not in delisting or major regulatory trouble

2. **Valuation Sanity Check**
   - P/E < 50 (unless hypergrowth with clear path to profitability)
   - PEG < 2.0 (growth stocks)
   - P/B < 10 (value stocks)

3. **Momentum Filter**
   - Price above 200-day MA OR
   - RSI not extreme (< 80 overbought, > 20 oversold)

**Outcome**: PASS → Continue to Deep Dive | FAIL → Document and skip

---

### Phase 2: Deep Dive Analysis (15 minutes)

Apply all four methodology checklists:

#### A. Value Investing Analysis (Buffett Style)
Reference: `CHECKLISTS.md` → Value Checklist

Key metrics:
- **Economic Moat**: Brand, network effects, switching costs, patents
- **ROE**: Target > 15% consistently
- **Free Cash Flow**: Positive and growing
- **Debt-to-Equity**: < 0.5 preferred, < 1.0 acceptable
- **Margin of Safety**: Buy at 25%+ discount to intrinsic value

#### B. Growth Analysis (Lynch Style)
Reference: `CHECKLISTS.md` → Growth Checklist

Key metrics:
- **PEG Ratio**: < 1.0 = undervalued, 1.0-1.5 = fair, > 1.5 = expensive
- **Earnings Growth**: 20-30% ideal (sustainable), > 50% watch for slowdown
- **Category Classification**:
  - Stalwart: 10-12% growth, reliable dividend
  - Fast Grower: 20-25%+ growth, small-mid cap
  - Cyclical: Economy-dependent, timing critical
  - Turnaround: Distressed but recoverable
  - Asset Play: Hidden value on balance sheet

#### C. Macro-Technical Analysis (Druckenmiller Style)
Reference: `CHECKLISTS.md` → Macro Checklist

Key factors:
- **Sector Rotation**: Is money flowing into/out of this sector?
- **Interest Rate Sensitivity**: How do rate changes affect this business?
- **Economic Cycle Position**: Early/mid/late cycle, recession
- **Risk-Reward Ratio**: Minimum 3:1 upside:downside required
- **Conviction Level**: High conviction = larger position sizing

#### D. Quantitative Signals (Simons Style)
Reference: `CHECKLISTS.md` → Quantitative Checklist

Key indicators:
- **RSI**: > 70 overbought, < 30 oversold
- **MACD**: Crossovers and divergence
- **Moving Averages**: 50-day vs 200-day (golden cross / death cross)
- **Volume Patterns**: Unusual volume on price moves
- **Mean Reversion**: Distance from 52-week high/low

---

### Phase 3: Risk Assessment

**Downside Scenarios**
1. What could go wrong? (List top 3 risks)
2. Maximum realistic downside? (Price target if thesis fails)
3. Time horizon risk? (Catalyst timing)

**Position Sizing Framework**
| Conviction | Risk-Reward | Suggested Max Position |
|------------|-------------|------------------------|
| High | > 5:1 | 5-10% of portfolio |
| Medium | 3:1 to 5:1 | 2-5% of portfolio |
| Low | < 3:1 | Watch only, no position |

---

### Phase 4: Verdict & Action

**Output Format:**
```
## [TICKER] Analysis — [YYYY-MM-DD HH:MM UTC]

### Data Quality
- Price timestamp: [source, time]
- Financials source: [filing date]
- Freshness: [PASS/STALE]

### Quick Stats
- Price: $X | Market Cap: $XB | P/E: X | PEG: X
- 52-Week Range: $X - $X | YTD: +X%

### Methodology Scores (1-10)
- Value: X/10 — [brief rationale]
- Growth: X/10 — [brief rationale]
- Macro: X/10 — [brief rationale]
- Quant: X/10 — [brief rationale]
- **Composite: X/10**

### Thesis
[2-3 sentence investment thesis]

### Catalysts (Bull Case)
1. [Primary catalyst with timeline]
2. [Secondary catalyst]

### Risks (Bear Case)
1. [Primary risk]
2. [Secondary risk]

### Verdict
- **Action**: STRONG BUY / BUY / WATCH / AVOID
- **Entry Zone**: $X - $X
- **Price Target**: $X (X% upside)
- **Stop Loss**: $X (X% downside)
- **Risk-Reward**: X:1
- **Time Horizon**: [Short/Medium/Long term]

### Position Sizing
- Conviction: [High/Medium/Low]
- Suggested Max: X% of portfolio

### Confidence & Sources
- Data confidence: [High/Medium/Low]
- Key sources: [list with timestamps]
- Metrics requiring verification: [list any uncertain values]
```

---

### Phase 5: Output Validation
**After generating analysis, perform self-check:**

1. **Number Cross-Check**
   - P/E × EPS ≈ Stock Price (within 5%)
   - Market Cap ≈ Price × Shares Outstanding
   - EV ≈ Market Cap + Debt - Cash

2. **Source Attribution**
   - Every specific number must have a source
   - If source is uncertain: Flag as "requires verification"
   - Never fabricate or guess financial metrics

3. **Confidence Scoring**
   - High: Data from primary sources (SEC, company IR)
   - Medium: Data from aggregators (Yahoo, FinViz)
   - Low: Data from secondary sources or estimates

4. **Hallucination Check**
   - Are P/E, P/B, P/S internally consistent?
   - Does growth rate match historical trends?
   - Are margins reasonable for the industry?

**Validation Output:**
```
### Validation — [PASS/FAIL]
- Cross-check: [OK/ISSUES]
- Unverified metrics: [list or "none"]
- Confidence: [H/M/L]
```

---

## Memory & Learning System

### Prediction Tracking
After each analysis, update `MEMORY.md`:

```
### [DATE] — [TICKER]
- **Verdict**: [Action] at $X
- **Target**: $X | **Stop**: $X
- **Thesis**: [One-liner]
- **Outcome**: [Fill in after 3-6 months]
```

### Quarterly Review
Every quarter:
1. Score prediction accuracy (hit target, stopped out, or in progress)
2. Identify patterns in wins and losses
3. Update checklists based on learnings
4. Adjust methodology weights if needed

---

## Supporting Reference Files

| File | Purpose |
|------|---------|
| `VALUATION.md` | DCF, P/E, P/B, EV/EBITDA, PEG formulas and thresholds |
| `CHECKLISTS.md` | Quick-reference checklists for each methodology |
| `REDFLAGS.md` | Warning signs and when to avoid |
| `TERMINOLOGY.md` | Financial terms and ratios explained |
| `SOURCES.md` | Trusted data sources and how to use them |

---

## Data Sources

### Primary Sources
- **Financial Data**: Yahoo Finance, Seeking Alpha, FinViz
- **SEC Filings**: 10-K (annual), 10-Q (quarterly), 8-K (events)
- **Earnings Calls**: Seek transcript for management commentary

### News & Analysis
- **Financial News**: Bloomberg, Reuters, WSJ, FT
- **Analysis Platforms**: Morningstar, Zack's, TipRanks
- **Social Sentiment**: Reddit r/wallstreetbets (contrarian indicator), Twitter/X

### Cross-Reference Rule
**Never rely on a single source**. Always verify:
- Price data from 2+ sources
- News from primary sources (SEC, company IR) when possible
- Analyst estimates from multiple providers

---

## Behavioral Rules

1. **Contrarian Mindset**: Best opportunities often in hated sectors
2. **No Hype**: Ignore social media frenzy, focus on fundamentals
3. **Process Over Outcome**: Good process + bad result = learning opportunity
4. **Position Limits**: Never more than 10% in single position
5. **Cash is a Position**: Sometimes the best action is to wait
6. **Document Everything**: Future you needs to understand past decisions

---

## Risk Management

- **Never invest without stop loss** (mental or actual)
- **Size positions for survivability** — can you sleep at night?
- **Diversify across sectors** — max 25% in any one sector
- **Rebalance quarterly** — trim winners, add to losers (if thesis intact)
- **Review thesis monthly** — if fundamentals change, exit

---

## Quick Commands

When user asks:
- "Analyze [TICKER]" → Run full 4-phase analysis
- "Quick check [TICKER]" → Phase 1 only
- "Compare [A] vs [B]" → Side-by-side analysis
- "Watch list status" → Update and summarize watch list
- "Review predictions" → Assess past calls vs outcomes
- "Sector outlook [SECTOR]" → Macro analysis of sector
