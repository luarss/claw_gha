# Quantitative Options Pricing

## Purpose

Derivatives pricing and Greeks calculation.

---

## Trigger

Use this skill when the user asks about:
- Options pricing
- Black-Scholes model
- Greeks (delta, gamma, vega, theta, rho)
- Monte Carlo option pricing
- Binomial/trinomial trees
- Interest rate models (Vasicek, Hull-White)
- Derivatives valuation

---

## Black-Scholes Model

### Call Option

```python
import numpy as np
from scipy.stats import norm

def black_scholes_call(S, K, T, r, sigma):
    """
    S: Spot price
    K: Strike price
    T: Time to maturity (years)
    r: Risk-free rate
    sigma: Volatility
    """
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)

    call_price = S * norm.cdf(d1) - K * np.exp(-r * T) * norm.cdf(d2)
    return call_price
```

### Put Option

```python
def black_scholes_put(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)

    put_price = K * np.exp(-r * T) * norm.cdf(-d2) - S * norm.cdf(-d1)
    return put_price
```

---

## Greeks

Sensitivities to input parameters:

### Delta (Δ)

Rate of change with respect to underlying price:

```python
def delta_call(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    return norm.cdf(d1)

def delta_put(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    return norm.cdf(d1) - 1
```

### Gamma (Γ)

Rate of change of delta (curvature):

```python
def gamma(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    return norm.pdf(d1) / (S * sigma * np.sqrt(T))
```

### Vega (ν)

Sensitivity to volatility:

```python
def vega(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    return S * norm.pdf(d1) * np.sqrt(T)
```

### Theta (Θ)

Time decay:

```python
def theta_call(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)

    term1 = -S * norm.pdf(d1) * sigma / (2 * np.sqrt(T))
    term2 = -r * K * np.exp(-r * T) * norm.cdf(d2)
    return term1 + term2
```

### Rho (ρ)

Sensitivity to interest rate:

```python
def rho_call(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)
    return K * T * np.exp(-r * T) * norm.cdf(d2)
```

---

## Monte Carlo Option Pricing

Simulate price paths for exotic options:

```python
def monte_carlo_option(S, K, T, r, sigma, n_simulations=100000, option_type='call'):
    """Monte Carlo simulation for European option"""
    Z = np.random.standard_normal(n_simulations)
    ST = S * np.exp((r - 0.5 * sigma**2) * T + sigma * np.sqrt(T) * Z)

    if option_type == 'call':
        payoff = np.maximum(ST - K, 0)
    else:
        payoff = np.maximum(K - ST, 0)

    price = np.exp(-r * T) * payoff.mean()
    std_error = np.exp(-r * T) * payoff.std() / np.sqrt(n_simulations)

    return price, std_error
```

---

## Greeks Summary

| Greek | Measures | Use Case |
|-------|----------|----------|
| Delta | Price sensitivity | Directional hedging |
| Gamma | Delta change | Dynamic hedging |
| Vega | Vol sensitivity | Vol trading |
| Theta | Time decay | Income strategies |
| Rho | Rate sensitivity | Rate exposure |

---

## Put-Call Parity

Fundamental relationship between calls and puts:

```
C - P = S - K * e^(-rT)
```

Where:
- C = Call price
- P = Put price
- S = Spot price
- K = Strike price
- r = Risk-free rate
- T = Time to maturity
