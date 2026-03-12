# Backtesting Examples

Sample backtest outputs demonstrating expected format and analysis.

---

## Example 1: Single Strategy Backtest

### Backtest Report — Low P/E + High ROE

**Strategy:** Buffett-style value investing

#### Parameters
- **Period:** 2019-01-01 to 2024-12-31 (6 years)
- **Universe:** S&P 500 (rebalanced quarterly)
- **Entry:** P/E < 15, ROE > 15%, D/E < 0.5
- **Exit:** P/E > 25, ROE < 10%, OR 6-month hold
- **Rebalancing:** Quarterly
- **Starting Capital:** $100,000

#### Performance Summary

| Metric | Strategy | Benchmark (SPY) | Difference |
|--------|----------|-----------------|------------|
| **Return Metrics** | | | |
| Total Return | +98.4% | +102.3% | -3.9% |
| CAGR | 12.1% | 12.4% | -0.3% |
| Avg Annual Return | 13.8% | 14.2% | -0.4% |
| **Risk Metrics** | | | |
| Max Drawdown | -22.3% | -33.9% | +11.6% |
| Volatility | 14.2% | 18.7% | -4.5% |
| Sharpe Ratio | 0.71 | 0.56 | +0.15 |
| Sortino Ratio | 1.02 | 0.73 | +0.29 |
| **Trade Metrics** | | | |
| Win Rate | 58% | — | — |
| Avg Win/Loss | 1.8 | — | — |
| Profit Factor | 2.48 | — | — |
| Avg Holding Period | 127 days | — | — |
| Total Trades | 84 | — | — |
| **Benchmark Comparison** | | | |
| Alpha | +2.1% | — | — |
| Beta | 0.72 | 1.00 | — |
| Information Ratio | 0.42 | — | — |

#### Risk Analysis
- **Max Drawdown Period:** Feb 2020 - Mar 2020 (COVID crash)
- **Worst Single Trade:** XOM -28% (energy sector crash)
- **Longest Drawdown Duration:** 4 months (Q2 2022 rate hike cycle)

#### Key Observations

1. **Lower Volatility, Similar Returns:** Strategy achieved near-benchmark returns with significantly lower drawdowns (-22% vs -34%). This is the "Buffett premium" — quality at fair price.

2. **Bear Market Outperformance:** During 2022, strategy outperformed SPY by 8.2%. Low-debt, high-ROE companies held up better in rising rate environment.

3. **Turnover Cost:** 84 trades over 6 years = ~14 trades/year. At $10/trade + 0.1% slippage, transaction costs reduced returns by ~0.4%/year.

4. **Sector Bias:** Strategy naturally overweighted financials (high ROE), industrials, and underweighted tech (high P/E). This was a headwind in 2020-2021 but tailwind in 2022.

#### Sample Trades

| Ticker | Entry | Exit | Return | Hold Days | Notes |
|--------|-------|------|--------|-----------|-------|
| BRK.B | +12% | +8% | +22% | 180 | Target P/E hit |
| JPM | +8% | +2% | +10% | 180 | Time-based exit |
| XOM | +5% | -23% | -28% | 180 | Energy crash, held to exit |
| UNH | +3% | +15% | +45% | 180 | Strong performer |
| HD | +10% | +5% | +52% | 180 | Home Depot rally |

#### Recommendation

**VIABLE FOR LIVE DEPLOYMENT**

The strategy delivers competitive returns with lower risk than the benchmark. Key strengths:
- Strong Sharpe ratio (0.71)
- Bear market resilience
- Quality-focused screening

Suggested improvements:
- Add sector caps (max 25%) to reduce concentration risk
- Consider 9-month hold to reduce turnover
- Screen for earnings stability (avoid cyclical value traps)

---

## Example 2: Strategy Underperformance Analysis

### Backtest Report — PEG < 1.0

**Strategy:** Lynch-style growth at reasonable price

#### Parameters
- **Period:** 2019-01-01 to 2024-12-31 (6 years)
- **Universe:** Russell 1000 (rebalanced quarterly)
- **Entry:** PEG < 1.0, Earnings growth 15-30%
- **Exit:** PEG > 1.5, Growth < 10%, OR 6-month hold
- **Rebalancing:** Quarterly
- **Starting Capital:** $100,000

#### Performance Summary

| Metric | Strategy | Benchmark (SPY) | Difference |
|--------|----------|-----------------|------------|
| Total Return | +42.1% | +102.3% | -60.2% |
| CAGR | 6.0% | 12.4% | -6.4% |
| Max Drawdown | -41.2% | -33.9% | -7.3% |
| Sharpe Ratio | 0.29 | 0.56 | -0.27 |
| Win Rate | 44% | — | — |
| Avg Win/Loss | 1.6 | — | — |

#### Underperformance Analysis

**What Went Wrong:**

1. **Growth Trap in 2022:** Many stocks with PEG < 1.0 in 2021 were pandemic beneficiaries (Zoom, Peloton, Docusign). When growth normalized, P/E collapsed faster than earnings fell → PEG spiked → forced exits at losses.

2. **Earnings Growth Unreliable:** "Earnings growth 15-30%" criterion looked at backward-looking TTM data. Forward growth was often much lower, leading to value traps.

3. **Universe Too Broad:** Russell 1000 includes many lower-quality companies that gamed PEG temporarily.

**Learning:**
- PEG works best when combined with quality filters (ROE, FCF)
- Backward-looking growth is unreliable; consider analyst estimates
- Tighter universe (S&P 500) may improve quality

#### Recommendation

**DO NOT DEPLOY AS CONFIGURED**

The PEG < 1.0 screen alone is too susceptible to growth traps. Modify with:
- Add quality filter: ROE > 12%, positive FCF
- Require revenue growth consistency (3+ quarters)
- Narrow universe to S&P 500 or Russell 1000 Growth

Re-run backtest with modifications before deployment.

---

## Example 3: Multi-Strategy Comparison

### Strategy Comparison — 5-Year Backtest (2019-2024)

| Metric | Low P/E + High ROE | PEG < 1.0 | Quality Compounders | Fast Grower | Oversold Quality |
|--------|-------------------|-----------|--------------------| ------------| -----------------|
| **CAGR** | 12.1% | 6.0% | 14.8% | 9.2% | 11.5% |
| **Max DD** | -22.3% | -41.2% | -25.1% | -38.4% | -18.9% |
| **Sharpe** | 0.71 | 0.29 | 0.82 | 0.41 | 0.68 |
| **Win Rate** | 58% | 44% | 62% | 48% | 55% |
| **Avg Hold** | 127d | 98d | 182d | 112d | 67d |
| **Trades/yr** | 14 | 22 | 8 | 18 | 24 |

#### Risk-Return Profile

```
Sharpe Ratio
    |
0.9 |                    ★ Quality Compounders
    |
0.8 |
    |
0.7 |  ★ Low P/E + High ROE      ★ Oversold Quality
    |
0.6 |
    |
0.5 |
    |
0.4 |              ★ Fast Grower
    |
0.3 |
    |              ★ PEG < 1.0
0.2 |
    +-----------------------------------------------
        0%    5%    10%   15%   20%   25%   30%
                        Max Drawdown
```

#### Key Findings

1. **Best Risk-Adjusted:** Quality Compounders (Sharpe 0.82) — Long hold, lower turnover, consistent returns.

2. **Best Drawdown Control:** Oversold Quality (-18.9%) — Mean reversion with quality filter limits downside.

3. **Worst Performer:** PEG < 1.0 — Susceptible to growth traps, high drawdown.

4. **Highest Return:** Quality Compounders (14.8% CAGR) — Best balance of growth and quality.

#### Strategy Allocation Recommendation

Based on backtest results, consider portfolio allocation:

| Strategy | Allocation | Rationale |
|----------|------------|-----------|
| Quality Compounders | 40% | Best risk-adjusted returns |
| Low P/E + High ROE | 30% | Bear market hedge |
| Oversold Quality | 20% | Volatility opportunity |
| Fast Grower | 10% | Bull market upside |
| PEG < 1.0 | 0% | Requires modification |

**Expected Portfolio:**
- CAGR: ~12-13%
- Max DD: ~20-25%
- Sharpe: ~0.75

---

## Using Examples in Analysis

When running backtests:

1. **Match Format:** Use the same table structures and sections
2. **Include Analysis:** Don't just report numbers — explain WHY
3. **Be Honest:** Underperformance is a finding, not a failure
4. **Suggest Improvements:** Always include actionable recommendations
5. **Compare to Benchmark:** SPY is the default; use sector ETFs for thematic strategies
