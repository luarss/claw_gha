# Quantitative Execution Algorithms

## Purpose

Trade execution and order management algorithms.

---

## Trigger

Use this skill when the user asks about:
- VWAP (Volume Weighted Average Price)
- TWAP (Time Weighted Average Price)
- Order book dynamics
- Market impact models
- Implementation shortfall
- Execution algorithms
- Trade scheduling

---

## VWAP (Volume Weighted Average Price)

Execute proportionally to expected volume profile.

### VWAP Schedule

```python
import numpy as np

def vwap_schedule(total_shares, volume_profile, n_slices):
    """
    Split order according to volume profile

    Args:
        total_shares: Total shares to execute
        volume_profile: Array of expected volume fractions per time slice
        n_slices: Number of time slices

    Returns:
        Array of shares per slice
    """
    # Normalize volume profile
    volume_profile = np.array(volume_profile) / sum(volume_profile)

    # Calculate shares per slice
    shares_per_slice = total_shares * volume_profile

    return shares_per_slice
```

### VWAP Calculation

```python
def calculate_vwap(prices, volumes):
    """Calculate VWAP from trades"""
    return (prices * volumes).sum() / volumes.sum()
```

### Typical Volume Profile (Intraday)

```python
# U-shaped volume profile (higher at open/close)
typical_profile = [
    0.15,  # 9:30-10:00 (high)
    0.10,  # 10:00-10:30
    0.08,  # 10:30-11:00
    0.07,  # 11:00-11:30
    0.06,  # 11:30-12:00
    0.05,  # 12:00-12:30 (lunch - low)
    0.06,  # 12:30-13:00
    0.07,  # 13:00-13:30
    0.08,  # 13:30-14:00
    0.10,  # 14:00-14:30
    0.12,  # 14:30-15:00
    0.15,  # 15:00-15:30 (close - high)
]
```

---

## TWAP (Time Weighted Average Price)

Execute evenly across time period.

### TWAP Schedule

```python
def twap_schedule(total_shares, n_slices):
    """Split order evenly across time slices"""
    shares_per_slice = total_shares / n_slices
    return np.full(n_slices, shares_per_slice)
```

### TWAP Calculation

```python
def calculate_twap(prices):
    """Calculate TWAP from prices"""
    return prices.mean()
```

---

## Order Book Dynamics

### Bid-Ask Spread

```python
def effective_spread(execution_price, bid, ask):
    """Calculate effective spread paid"""
    mid = (bid + ask) / 2
    return 2 * abs(execution_price - mid) / mid
```

### Market Depth

```python
def weighted_mid(bid, ask, bid_size, ask_size):
    """Size-weighted midpoint"""
    total_size = bid_size + ask_size
    return (bid * ask_size + ask * bid_size) / total_size
```

---

## Market Impact Models

### Square Root Law

```python
def market_impact(sigma, volume, adv, alpha=0.5):
    """
    Square root impact model

    Args:
        sigma: Daily volatility
        volume: Order size
        adv: Average daily volume
        alpha: Impact exponent (typically 0.5)

    Returns:
        Expected price impact (fraction)
    """
    participation_rate = volume / adv
    return sigma * (participation_rate ** alpha)
```

### Implementation Shortfall

```python
def implementation_shortfall(
    decision_price,
    execution_prices,
    execution_sizes,
    side='buy'
):
    """
    Calculate implementation shortfall

    Args:
        decision_price: Price when decision was made
        execution_prices: Array of execution prices
        execution_sizes: Array of sizes
        side: 'buy' or 'sell'

    Returns:
        Total shortfall in currency
    """
    avg_execution = np.average(execution_prices, weights=execution_sizes)
    total_size = sum(execution_sizes)

    if side == 'buy':
        shortfall = (avg_execution - decision_price) * total_size
    else:
        shortfall = (decision_price - avg_execution) * total_size

    return shortfall
```

---

## Algorithm Selection

| Algorithm | Use Case |
|-----------|----------|
| VWAP | Minimize market impact, liquid stocks |
| TWAP | Uniform execution, low volume stocks |
| POV (% of Volume) | Follow real-time volume |
| IS (Implementation Shortfall) | Balance urgency vs impact |
| Arrival Price | Benchmark at decision time |

---

## Quick Reference

| Metric | Formula | Interpretation |
|--------|---------|----------------|
| VWAP | Σ(P×V) / ΣV | Volume-weighted average |
| TWAP | ΣP / n | Simple average |
| Spread | 2×|P-mid|/mid | Transaction cost |
| Impact | σ×(V/ADV)^0.5 | Price movement |
