# Quantitative Performance Metrics

## Purpose

Performance analysis and attribution for trading strategies and portfolios.

---

## Trigger

Use this skill when the user asks about:
- Sharpe ratio, Sortino ratio, Information ratio
- Alpha and beta calculation
- Returns analysis
- Performance attribution
- Tear sheets and reporting
- empyrical, Pyfolio libraries

---

## Key Metrics

### Sharpe Ratio

Risk-adjusted return using total volatility:

```python
import numpy as np

def sharpe_ratio(returns, risk_free_rate=0.0, periods_per_year=252):
    """Annualized Sharpe ratio"""
    excess_returns = returns - risk_free_rate / periods_per_year
    return np.sqrt(periods_per_year) * excess_returns.mean() / excess_returns.std()
```

### Sortino Ratio

Uses downside deviation only (penalizes negative volatility):

```python
def sortino_ratio(returns, risk_free_rate=0.0, periods_per_year=252):
    """Annualized Sortino ratio"""
    excess_returns = returns - risk_free_rate / periods_per_year
    downside_returns = excess_returns[excess_returns < 0]
    downside_std = np.sqrt((downside_returns ** 2).mean())
    return np.sqrt(periods_per_year) * excess_returns.mean() / downside_std
```

### Information Ratio

Active return vs tracking error:

```python
def information_ratio(returns, benchmark_returns, periods_per_year=252):
    """Information ratio vs benchmark"""
    active_returns = returns - benchmark_returns
    tracking_error = active_returns.std()
    return np.sqrt(periods_per_year) * active_returns.mean() / tracking_error
```

### Alpha and Beta

Regression-based performance attribution:

```python
import statsmodels.api as sm

def alpha_beta(returns, benchmark_returns):
    """Calculate alpha and beta from regression"""
    X = sm.add_constant(benchmark_returns)
    model = sm.OLS(returns, X).fit()
    return model.params[0], model.params[1]  # alpha, beta
```

---

## Libraries

### empyrical

Risk and performance metrics library:

```python
import empyrical as ep

returns = strategy_returns
benchmark = benchmark_returns

sharpe = ep.sharpe_ratio(returns)
sortino = ep.sortino_ratio(returns)
max_dd = ep.max_drawdown(returns)
alpha, beta = ep.alpha_beta(returns, benchmark)

# Rolling metrics
rolling_sharpe = ep.roll_sharpe_ratio(returns, window=63)
```

### Pyfolio

Portfolio analytics with tear sheets:

```python
import pyfolio as pf

# Full tear sheet
pf.create_full_tear_sheet(returns, benchmark_rets=benchmark)

# Simple returns tear sheet
pf.create_simple_tear_sheet(returns)
```

---

## Rolling Metrics

Calculate metrics over sliding windows:

```python
def rolling_sharpe(returns, window=63, periods_per_year=252):
    """Rolling annualized Sharpe ratio"""
    excess = returns  # Assuming already excess returns
    rolling_mean = excess.rolling(window).mean()
    rolling_std = excess.rolling(window).std()
    return np.sqrt(periods_per_year) * rolling_mean / rolling_std
```

---

## Quick Reference

| Metric | Formula | Interpretation |
|--------|---------|----------------|
| Sharpe | (r - rf) / σ | Return per unit risk |
| Sortino | (r - rf) / σ_down | Return per downside risk |
| Information | (r - r_bench) / TE | Active return efficiency |
| Alpha | Regression intercept | Skill-based excess return |
| Beta | Regression slope | Market sensitivity |
