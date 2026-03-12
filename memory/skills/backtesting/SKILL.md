# Backtesting Skill

## Purpose
Validate fundamental investment strategies against historical data to measure effectiveness before deploying capital. Focus on medium-term (1-6 month) holding periods using fundamental criteria.

---

## Capabilities

| Capability | Description |
|------------|-------------|
| Strategy Simulation | Test entry/exit rules against historical price and fundamental data |
| Performance Metrics | Calculate CAGR, Sharpe ratio, win rate, max drawdown |
| Benchmark Comparison | Compare strategy returns against S&P 500 or sector indices |
| Multi-Strategy Analysis | Compare performance across different methodologies |

---

## Backtest Workflow (5 Phases)

### Phase 1: Define Strategy

Specify all parameters before running:

| Parameter | Description | Example |
|-----------|-------------|---------|
| **Entry Criteria** | Fundamental filters that trigger buy | P/E < 15, ROE > 15%, D/E < 0.5 |
| **Exit Criteria** | Conditions that trigger sell | P/E > 25, ROE < 10%, max hold 6mo |
| **Rebalancing** | How often to re-screen | Monthly, quarterly |
| **Universe** | Stock pool to screen from | S&P 500, Russell 1000, sector ETFs |
| **Position Sizing** | Allocation per position | Equal weight, risk-parity, conviction-based |
| **Time Period** | Backtest date range | 5 years minimum recommended |

**Output:**
```
### Strategy Definition — [Strategy Name]
- Universe: [S&P 500 / Russell 1000 / Sector]
- Entry: [criteria list]
- Exit: [criteria list]
- Rebalancing: [frequency]
- Position Size: [% per position]
- Period: [start date] to [end date]
```

---

### Phase 2: Collect Historical Data

Use Finnhub API to fetch:

1. **Price Data** (daily candles)
   - Endpoint: `/stock/candle?symbol={SYMBOL}&resolution=D&from={FROM}&to={TO}`
   - Returns: OHLCV arrays
   - See `API.md` for details

2. **Historical Financials**
   - Endpoint: `/stock/financials?symbol={SYMBOL}&statement={TYPE}&freq={FREQ}`
   - Types: `ic` (income), `bs` (balance), `cf` (cash flow)
   - Freq: `annual`, `quarterly`

3. **Key Constraints**
   - Metrics endpoint provides current values only
   - Calculate historical P/E, ROE from raw financials
   - Apply 45-day lag for quarterly data (reporting delay)
   - Rate limit: 60 calls/min (free tier)

**Data Collection Checklist:**
- [ ] Price data for entire period
- [ ] Quarterly financials with filing dates
- [ ] Market cap history (for position sizing)
- [ ] Benchmark returns (SPY) for comparison

---

### Phase 3: Run Simulation

Execute strategy logic chronologically:

```
For each rebalancing date:
  1. Screen universe against entry criteria (using data available at that time)
  2. Rank candidates by [quality metric]
  3. Allocate per position sizing rules
  4. Track existing positions against exit criteria
  5. Close positions meeting exit criteria
  6. Log all trades with entry/exit dates and prices
```

**Trade Log Format:**
```
| Entry Date | Ticker | Entry Price | Exit Date | Exit Price | Return | Hold Days | Exit Reason |
|------------|--------|-------------|-----------|------------|--------|-----------|-------------|
| 2024-01-15 | AAPL | $175.50 | 2024-07-15 | $210.30 | +19.8% | 182 | Target hit |
```

**Critical:** Only use data that would have been available at historical decision points (no look-ahead bias).

---

### Phase 4: Calculate Results

Compute all metrics defined in `METRICS.md`:

**Return Metrics:**
- Total Return
- CAGR (Compound Annual Growth Rate)
- Average Annual Return

**Risk Metrics:**
- Maximum Drawdown
- Volatility (annualized)
- Sharpe Ratio
- Sortino Ratio

**Trade Metrics:**
- Win Rate
- Average Win/Loss Ratio
- Profit Factor
- Average Holding Period

**Benchmark Comparison:**
- Alpha vs S&P 500
- Beta
- Information Ratio

---

### Phase 5: Output Report

Generate structured backtest report:

```
## Backtest Report — [Strategy Name]

### Parameters
- **Period:** [start] to [end] ([X] years)
- **Universe:** [description]
- **Entry:** [criteria]
- **Exit:** [criteria]
- **Rebalancing:** [frequency]
- **Starting Capital:** $100,000

### Performance Summary
| Metric | Strategy | Benchmark (SPY) | Difference |
|--------|----------|-----------------|------------|
| Total Return | X% | Y% | +Z% |
| CAGR | X% | Y% | +Z% |
| Max Drawdown | -X% | -Y% | |
| Sharpe Ratio | X.XX | Y.YY | |
| Win Rate | X% | — | |
| Avg Win/Loss | X.XX | — | |
| # Trades | X | — | |

### Risk Analysis
- **Max Drawdown Period:** [date range]
- **Worst Single Trade:** [ticker] (-X%)
- **Longest Drawdown Duration:** X months

### Key Observations
1. [Observation about when strategy works]
2. [Observation about when it fails]
3. [Suggested improvements]

### Sample Trades (Best & Worst)
| Ticker | Entry | Exit | Return | Notes |
|--------|-------|------|--------|-------|
| [Best trade] | | | | |
| [Worst trade] | | | | |

### Recommendation
[Strategy viability assessment for live deployment]
```

---

## Time Horizon Guidelines

| Horizon | Min Backtest Period | Recommended |
|---------|---------------------|-------------|
| Short (weeks-months) | 3 years | 5 years |
| Medium (1-6 months) | 5 years | 7-10 years |
| Long (1+ years) | 7 years | 10+ years |

**Important:** Include at least one bear market and one bull market in the backtest period.

---

## Common Pitfalls to Avoid

| Pitfall | Description | Prevention |
|---------|-------------|------------|
| Look-ahead bias | Using future data in past decisions | Use data timestamps, apply reporting lags |
| Survivorship bias | Only testing stocks that still exist | Include delisted/bankrupt stocks |
| Overfitting | Tuning to past noise | Out-of-sample testing, fewer parameters |
| Transaction costs | Ignoring trading fees | Apply 0.1% per trade minimum |
| Liquidity | Assuming unlimited fills | Filter for volume, use limit prices |

---

## Related Skills

| Skill | Relationship |
|-------|--------------|
| `stock-picker` | Use backtesting to validate strategies before recommending stocks |
| `live-pricing` | Fetch current prices to compare against historical ranges |

---

## Quick Commands

When user asks:
- "Backtest [strategy]" → Run full 5-phase backtest
- "Compare strategies [A] vs [B]" → Side-by-side performance analysis
- "What's the win rate for [criteria]?" → Quick historical screen
- "Validate [ticker] against [strategy]" → Check if stock matches validated strategy
