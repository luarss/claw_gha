# Stock-Picker Workflow Integration

How to integrate backtesting into the stock-picker analysis workflow.

---

## Integration Point: Phase 3.5

Insert backtesting check between **Phase 3 (Risk Assessment)** and **Phase 4 (Verdict)** in the stock-picker workflow.

```
Phase 1: Quick Screen
Phase 2: Deep Dive Analysis
Phase 3: Risk Assessment
Phase 3.5: Strategy Validation ← BACKTESTING INTEGRATION
Phase 4: Verdict & Action
Phase 5: Output Validation
```

---

## Integration Scenarios

### Scenario 1: Stock Matches Validated Strategy

When a stock passes entry criteria for a strategy with proven backtest results:

**Enhanced Verdict:**
```
### Strategy Alignment — [TICKER]
- **Matched Strategy:** [Strategy Name]
- **Historical Win Rate:** [X]%
- **Historical Avg Return:** [X]%
- **Strategy Sharpe:** [X.XX]
- **Confidence Boost:** +1 methodology score
```

**Example:**
```
### Strategy Alignment — JPM
- **Matched Strategy:** Low P/E + High ROE (Buffett)
- **Historical Win Rate:** 58%
- **Historical Avg Return:** +12.8%
- **Strategy Sharpe:** 0.71
- **Confidence:** HIGH — Stock matches validated value criteria
```

---

### Scenario 2: Stock Fails All Strategy Criteria

When a stock doesn't match any validated strategy:

**Risk Warning:**
```
### Strategy Alignment — [TICKER]
- **Matched Strategy:** None
- **Status:** Outside validated parameters
- **Risk:** No historical evidence for this setup
- **Recommendation:** Reduce position size, increase scrutiny
```

**Example:**
```
### Strategy Alignment — NVDA
- **Matched Strategy:** None
- **Current P/E:** 47 (vs. strategy max 25)
- **Status:** Outside validated value parameters
- **Risk:** No historical evidence for hypergrowth at premium valuations
- **Recommendation:** WAIT for pullback or reduce to 1-2% position
```

---

### Scenario 3: Similar Historical Setups

When backtesting shows poor results for similar setups:

**Caution Flag:**
```
### Historical Similarity Check — [TICKER]
- **Setup Type:** [Description]
- **Historical Performance:** [X]% avg return, [Y]% win rate
- **Warning:** [Specific risk from backtest]
- **Recommendation:** [Action based on evidence]
```

**Example:**
```
### Historical Similarity Check — ZM
- **Setup Type:** High growth + PEG < 1.0 + Pandemic beneficiary
- **Historical Performance:** -15% avg return, 32% win rate
- **Warning:** PEG < 1.0 growth traps in post-pandemic normalization
- **Recommendation:** AVOID — High probability of value trap
```

---

## Memory Updates

### Add to MEMORY.md

#### Strategy Performance Log

Track validated strategies for quick reference:

```
## Strategy Performance Log

| Strategy | CAGR | Sharpe | Win Rate | Max DD | Last Validated |
|----------|------|--------|----------|--------|----------------|
| Low P/E + High ROE | 12.1% | 0.71 | 58% | -22% | 2024-12 |
| Quality Compounders | 14.8% | 0.82 | 62% | -25% | 2024-12 |
| Oversold Quality | 11.5% | 0.68 | 55% | -19% | 2024-12 |
| Fast Grower | 9.2% | 0.41 | 48% | -38% | 2024-12 |
| PEG < 1.0 | 6.0% | 0.29 | 44% | -41% | 2024-12 |

**Quarterly Re-run:** Next validation due 2025-03
```

#### Strategy Alignment in Watch List

Add strategy column to watch list tracking:

```
## Current Watch List

| Ticker | Rating | Matched Strategy | Historical Win Rate | Notes |
|--------|--------|------------------|---------------------|-------|
| GOOGL | HOLD | Quality Compounders | 62% | Within validated criteria |
| AMZN | BUY | Quality Compounders | 62% | Strong match |
| MSFT | BUY | Quality Compounders | 62% | Strong match |
| JPM | HOLD | Low P/E + High ROE | 58% | Target achieved |
| NVDA | WATCH | None | — | Outside all strategies |
| AAPL | WATCH | None | — | Premium valuation |
```

---

## Verdict Enhancement

### Standard Verdict Format (Enhanced)

Add Strategy Alignment section to verdict output:

```
## [TICKER] Analysis — [DATE]

### Data Quality
[...]

### Quick Stats
[...]

### Methodology Scores (1-10)
[...]

### Strategy Alignment ← NEW SECTION
- **Matched Strategy:** [Name or "None"]
- **Historical Evidence:** [Win rate and avg return if matched]
- **Confidence Adjustment:** [+/− methodology points]

### Thesis
[...]

### Catalysts (Bull Case)
[...]

### Risks (Bear Case)
[...]

### Verdict
- **Action:** [STRONG BUY / BUY / WATCH / AVOID]
- **Strategy Support:** [Validated / Unvalidated / Contrarian]
[...]
```

---

## Workflow Decision Tree

```
                    ┌─────────────────────┐
                    │ Phase 3: Risk       │
                    │ Assessment Complete │
                    └──────────┬──────────┘
                               │
                    ┌──────────▼──────────┐
                    │ Phase 3.5: Strategy │
                    │ Validation          │
                    └──────────┬──────────┘
                               │
              ┌────────────────┼────────────────┐
              │                │                │
     ┌────────▼────────┐ ┌─────▼─────┐ ┌───────▼───────┐
     │ Matches Valid   │ │ No Match  │ │ Matches Poor  │
     │ Strategy        │ │ Found     │ │ Strategy      │
     └────────┬────────┘ └─────┬─────┘ └───────┬───────┘
              │                │               │
     ┌────────▼────────┐ ┌─────▼─────┐ ┌───────▼───────┐
     │ +1 confidence   │ │ Standard  │ │ -1 confidence │
     │ Reference hist  │ │ verdict   │ │ Add warning   │
     │ win rate        │ │           │ │ Reduce size   │
     └─────────────────┘ └───────────┘ └───────────────┘
```

---

## Quarterly Review Integration

During quarterly review (per `SOUL.md`):

### Add Strategy Performance Review

```
### Quarterly Strategy Review — [Q# YYYY]

**Re-run Backtests:**
- [ ] Low P/E + High ROE
- [ ] Quality Compounders
- [ ] Oversold Quality
- [ ] Fast Grower
- [ ] PEG < 1.0

**Performance Changes:**
| Strategy | Prior Sharpe | New Sharpe | Change |
|----------|--------------|------------|--------|
| [Name] | X.XX | Y.YY | +/- |

**Strategy Adjustments:**
- [Modifications based on new data]

**Remove/Deprecate:**
- [Strategies that no longer work]
```

---

## Quick Reference: Strategy Criteria

For rapid alignment checks during analysis:

| Strategy | P/E | ROE | Growth | D/E | Hold |
|----------|-----|-----|--------|-----|------|
| Low P/E + High ROE | <15 | >15% | — | <0.5 | 6mo |
| PEG < 1.0 | — | — | 15-30% | — | 6mo |
| Quality Compounders | <25 | >20% | — | — | 12mo |
| Fast Grower | <30 | — | 25-50% | — | 12mo |
| Oversold Quality | — | >15% | — | — | 3mo |

**Quick Check:**
- Stock matches strategy → Add strategy confidence to verdict
- Stock fails all → Note "outside validated parameters"
- Stock matches poor strategy → Add warning

---

## Example: Full Integration

### AMZN Analysis — 2026-03-12

**[Standard Phase 1-3 content...]**

### Strategy Alignment
- **Matched Strategy:** Quality Compounders
- **Criteria Check:**
  - ROE: 22% ✓ (>20% required)
  - FCF yield: 12% ✓ (>10% required)
  - P/E: 30 ⚠️ (target <25, slightly above)
- **Historical Evidence:** 62% win rate, +14.8% CAGR, Sharpe 0.82
- **Confidence:** MEDIUM-HIGH — Slightly elevated P/E, but strong quality metrics

**[Continue to Verdict...]**

### Verdict
- **Action:** BUY
- **Strategy Support:** Validated (Quality Compounders with minor P/E overage)
- **Entry Zone:** $200-215
- **Price Target:** $260-280 (23-31% upside)
- **Stop Loss:** $185 (14% downside)
- **Risk-Reward:** 2.1:1
- **Position Size:** 2-3% (per Quality Compounders historical sizing)

---

## Related Files

| File | Purpose |
|------|---------|
| `STRATEGIES.md` | Full strategy definitions |
| `METRICS.md` | Performance metric calculations |
| `EXAMPLES.md` | Sample backtest outputs |
| `../stock-picker/SKILL.md` | Main analysis workflow |
