# Quantitative Risk Metrics

## Purpose

Risk measurement and management for trading portfolios.

---

## Trigger

Use this skill when the user asks about:
- Value at Risk (VaR)
- Conditional VaR / Expected Shortfall
- Maximum drawdown
- Factor models (Fama-French)
- Stress testing
- Risk measurement

---

## Value at Risk (VaR)

### Historical VaR

Non-parametric, uses actual return distribution:

```python
import numpy as np

def var_historical(returns, confidence=0.95):
    """Historical VaR - percentile of returns"""
    return np.percentile(returns, (1 - confidence) * 100)
```

### Parametric VaR

Assumes normal distribution:

```python
from scipy import stats

def var_parametric(returns, confidence=0.95):
    """Parametric VaR (assumes normal distribution)"""
    mu = returns.mean()
    sigma = returns.std()
    return stats.norm.ppf(1 - confidence, mu, sigma)
```

### Monte Carlo VaR

Simulate future scenarios:

```python
def var_monte_carlo(returns, confidence=0.95, n_simulations=10000):
    """Monte Carlo VaR"""
    mu = returns.mean()
    sigma = returns.std()

    simulated = np.random.normal(mu, sigma, n_simulations)
    return np.percentile(simulated, (1 - confidence) * 100)
```

---

## Conditional VaR (Expected Shortfall)

Average loss beyond VaR threshold:

```python
def cvar(returns, confidence=0.95):
    """Conditional VaR / Expected Shortfall"""
    var = var_historical(returns, confidence)
    return returns[returns <= var].mean()
```

---

## Maximum Drawdown

Largest peak-to-trough decline:

```python
def max_drawdown(prices):
    """Calculate maximum drawdown from peak"""
    cumulative = (1 + prices.pct_change()).cumprod()
    running_max = cumulative.cummax()
    drawdown = (cumulative - running_max) / running_max
    return drawdown.min()

def rolling_max_drawdown(prices, window=252):
    """Rolling maximum drawdown"""
    def calc_dd(x):
        cummax = np.maximum.accumulate(x)
        return np.min((x - cummax) / cummax)

    return prices.rolling(window).apply(calc_dd)
```

---

## Factor Models

### Fama-French Factor Exposure

```python
import statsmodels.api as sm

def factor_regression(returns, factor_returns):
    """
    Regress returns against Fama-French factors
    factor_returns: DataFrame with [Mkt-RF, SMB, HML] columns
    """
    X = sm.add_constant(factor_returns)
    model = sm.OLS(returns, X).fit()

    return {
        'alpha': model.params[0],
        'market_beta': model.params[1],
        'size_beta': model.params[2],  # SMB
        'value_beta': model.params[3],  # HML
        'r_squared': model.rsquared
    }
```

---

## Quick Reference

| Metric | Description | Use Case |
|--------|-------------|----------|
| VaR 95% | 5th percentile loss | Daily risk limits |
| CVaR 95% | Avg loss beyond VaR | Tail risk assessment |
| Max DD | Peak-to-trough | Worst case scenario |
| Rolling DD | Drawdown over window | Ongoing risk monitoring |

---

## VaR Methods Comparison

| Method | Pros | Cons |
|--------|------|------|
| Historical | No distribution assumption | Sensitive to sample period |
| Parametric | Simple, fast | Assumes normality |
| Monte Carlo | Flexible distributions | Computationally intensive |
