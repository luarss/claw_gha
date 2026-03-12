# Quantitative Portfolio Optimization

## Purpose

Portfolio construction and position sizing methods.

---

## Trigger

Use this skill when the user asks about:
- Mean-variance optimization
- Markowitz portfolio theory
- Efficient frontier
- Black-Litterman model
- Kelly criterion
- Position sizing
- Volatility scaling
- Portfolio allocation

---

## Mean-Variance Optimization (Markowitz)

Minimize variance for a given expected return:

```python
import numpy as np
from scipy.optimize import minimize

def portfolio_variance(weights, cov_matrix):
    return weights @ cov_matrix @ weights

def portfolio_return(weights, returns):
    return weights @ returns

def optimize_portfolio(expected_returns, cov_matrix, target_return=None):
    n = len(expected_returns)

    # Constraints: weights sum to 1
    constraints = [{'type': 'eq', 'fun': lambda w: np.sum(w) - 1}]

    # Optional: target return constraint
    if target_return:
        constraints.append({
            'type': 'eq',
            'fun': lambda w: portfolio_return(w, expected_returns) - target_return
        })

    # Bounds: 0 <= weight <= 1 (long-only)
    bounds = [(0, 1) for _ in range(n)]

    result = minimize(
        portfolio_variance,
        x0=np.ones(n) / n,  # Equal weight start
        args=(cov_matrix,),
        method='SLSQP',
        bounds=bounds,
        constraints=constraints
    )

    return result.x
```

---

## Efficient Frontier

Compute the set of optimal portfolios:

```python
def compute_efficient_frontier(expected_returns, cov_matrix, n_points=100):
    min_ret = expected_returns.min()
    max_ret = expected_returns.max()
    target_returns = np.linspace(min_ret, max_ret, n_points)

    frontier_volatility = []
    frontier_weights = []

    for target in target_returns:
        weights = optimize_portfolio(expected_returns, cov_matrix, target)
        frontier_weights.append(weights)
        frontier_volatility.append(np.sqrt(portfolio_variance(weights, cov_matrix)))

    return np.array(frontier_volatility), target_returns
```

---

## Position Sizing

### Kelly Criterion

Optimal bet size for positive expected value:

```python
def kelly_criterion(win_rate, avg_win, avg_loss):
    """
    Kelly fraction for position sizing
    win_rate: probability of winning
    avg_win: average winning trade
    avg_loss: average losing trade
    """
    b = avg_win / avg_loss  # Win/loss ratio
    q = 1 - win_rate
    kelly = (win_rate * b - q) / b
    return max(0, kelly)  # Never negative

# In practice, use half-Kelly for safety
fraction = kelly_criterion(0.55, 200, 100) * 0.5
```

### Volatility Scaling

Target a specific portfolio volatility:

```python
def volatility_scaled_position(target_vol, asset_vol, portfolio_value):
    """
    Scale position by asset volatility
    target_vol: target contribution to portfolio vol (e.g., 0.01 for 1%)
    asset_vol: annualized volatility of asset
    """
    return target_vol / asset_vol * portfolio_value
```

---

## Black-Litterman Model

Combine market equilibrium with investor views:

```python
def black_litterman(market_caps, cov_matrix, risk_aversion=2.5, views=None):
    """
    Simplified Black-Litterman implementation
    market_caps: market capitalizations
    cov_matrix: covariance matrix
    risk_aversion: risk aversion parameter (typically 1-5)
    views: dict of {asset: (view_return, confidence)}
    """
    # Equilibrium returns
    w_mkt = market_caps / market_caps.sum()
    pi = risk_aversion * cov_matrix @ w_mkt  # Implied returns

    if views is None:
        return pi, w_mkt

    # Incorporate views (simplified)
    # Full implementation requires P, Q, Omega matrices
    return pi, w_mkt
```

---

## Quick Reference

| Method | Use Case |
|--------|----------|
| Mean-Variance | Max return for risk level |
| Min Variance | Most conservative portfolio |
| Risk Parity | Equal risk contribution |
| Kelly | Optimal leverage |
| Vol Targeting | Constant volatility exposure |

---

## Common Pitfalls

1. **Estimation error** - Small changes in inputs cause large weight changes
2. **Overfitting** - Optimizing on historical data may not generalize
3. **Transaction costs** - Rebalancing can erode returns
4. **Constraints** - Long-only, sector limits, turnover constraints
