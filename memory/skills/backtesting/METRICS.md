# Backtesting Performance Metrics

Definitions and calculation methods for all backtest metrics.

---

## Return Metrics

### Total Return
Simple percentage change from start to end.

```
Total Return = (Ending Value - Starting Value) / Starting Value × 100%
```

### CAGR (Compound Annual Growth Rate)
Annualized return assuming compounding.

```
CAGR = (Ending Value / Starting Value)^(1/Years) - 1
```

**Example:** $100,000 → $180,000 over 5 years
```
CAGR = (180,000 / 100,000)^(1/5) - 1 = 12.47%
```

### Average Annual Return
Mean of yearly returns (arithmetic).

```
Avg Annual Return = Sum(Yearly Returns) / Number of Years
```

**Note:** CAGR is preferred for long-term comparison; average return is higher due to volatility.

---

## Risk Metrics

### Maximum Drawdown
Largest peak-to-trough decline during the period.

```
Max Drawdown = (Trough Value - Peak Value) / Peak Value
```

**Example:**
- Portfolio peaks at $150,000
- Falls to $120,000 before recovering
- Max Drawdown = ($120,000 - $150,000) / $150,000 = -20%

### Volatility (Annualized)
Standard deviation of returns, annualized.

```
Volatility = StdDev(Monthly Returns) × √12
```

**Interpretation:**
- < 10%: Low volatility (bonds, utilities)
- 10-20%: Moderate (large-cap stocks)
- > 20%: High (small-cap, growth, crypto)

### Sharpe Ratio
Risk-adjusted return. Higher is better.

```
Sharpe Ratio = (CAGR - Risk-Free Rate) / Volatility
```

**Benchmark:**
- < 0.5: Poor
- 0.5-1.0: Acceptable
- 1.0-2.0: Good
- > 2.0: Excellent

**Example:**
- CAGR = 15%
- Risk-free rate = 5%
- Volatility = 12%
- Sharpe = (15% - 5%) / 12% = 0.83

### Sortino Ratio
Like Sharpe, but only penalizes downside volatility.

```
Sortino Ratio = (CAGR - Risk-Free Rate) / Downside Deviation
```

**Use:** Better for strategies with asymmetric returns (limited downside, uncapped upside).

---

## Trade Metrics

### Win Rate
Percentage of trades that are profitable.

```
Win Rate = Winning Trades / Total Trades × 100%
```

**Benchmarks:**
- 40-50%: Acceptable for high win/loss ratio strategies
- 50-60%: Good for trend-following
- > 60%: Excellent (watch for overfitting)

### Average Win/Loss Ratio
Ratio of average winning trade to average losing trade.

```
Avg Win/Loss = Average Winning Return / |Average Losing Return|
```

**Example:**
- Avg winning trade: +15%
- Avg losing trade: -5%
- Win/Loss Ratio = 15% / 5% = 3.0

**Interpretation:**
- < 1.0: Need high win rate to be profitable
- 1.5-2.0: Good
- > 2.0: Excellent (can tolerate lower win rate)

### Profit Factor
Total profits divided by total losses.

```
Profit Factor = Sum of Winning Returns / |Sum of Losing Returns|
```

**Benchmarks:**
- < 1.0: Losing strategy
- 1.0-1.5: Marginal
- 1.5-2.0: Good
- > 2.0: Excellent

### Average Holding Period
Mean time positions are held.

```
Avg Holding Period = Sum(Holding Days) / Number of Trades
```

**Interpretation:**
- < 30 days: Short-term / swing trading
- 30-180 days: Medium-term
- > 180 days: Long-term

---

## Benchmark Comparison

### Alpha
Excess return vs benchmark after adjusting for risk.

```
Alpha = Strategy Return - (Risk-Free Rate + Beta × (Benchmark Return - Risk-Free Rate))
```

**Interpretation:**
- Positive: Strategy outperforms benchmark on risk-adjusted basis
- Negative: Strategy underperforms

### Beta
Correlation of strategy returns to benchmark.

```
Beta = Covariance(Strategy, Benchmark) / Variance(Benchmark)
```

**Interpretation:**
- < 1.0: Lower volatility than benchmark
- 1.0: Same volatility as benchmark
- > 1.0: Higher volatility than benchmark

### Information Ratio
Consistency of outperformance vs benchmark.

```
Information Ratio = (Strategy Return - Benchmark Return) / Tracking Error
```

**Tracking Error:** Standard deviation of (Strategy Return - Benchmark Return)

**Benchmarks:**
- < 0.5: Poor
- 0.5-1.0: Good
- > 1.0: Excellent

---

## Output Template

Use this format for all backtest results:

```
### Performance Summary

| Metric | Value | Benchmark |
|--------|-------|-----------|
| **Return Metrics** | | |
| Total Return | X% | Y% |
| CAGR | X% | Y% |
| Avg Annual Return | X% | Y% |
| **Risk Metrics** | | |
| Max Drawdown | -X% | -Y% |
| Volatility | X% | Y% |
| Sharpe Ratio | X.XX | Y.YY |
| Sortino Ratio | X.XX | Y.YY |
| **Trade Metrics** | | |
| Win Rate | X% | — |
| Avg Win/Loss | X.XX | — |
| Profit Factor | X.XX | — |
| Avg Holding Period | X days | — |
| Total Trades | X | — |
| **Benchmark Comparison** | | |
| Alpha | X% | — |
| Beta | X.XX | 1.00 |
| Information Ratio | X.XX | — |
```

---

## Metric Interpretation Guide

| Scenario | What It Means |
|----------|---------------|
| High CAGR, High Drawdown | Aggressive strategy; needs risk management |
| Low CAGR, Low Drawdown | Conservative; good for capital preservation |
| High Win Rate, Low Win/Loss | Many small wins, occasional big losses |
| Low Win Rate, High Win/Loss | Few big wins, many small losses (trend-following) |
| High Sharpe, Low Alpha | Good risk-adjusted returns but doesn't beat benchmark |
| High Alpha, Low Sharpe | Beats benchmark but with high volatility |
