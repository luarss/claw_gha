# Quantitative Time Series Analysis

## Purpose

Statistical analysis of financial time series for modeling and prediction.

---

## Trigger

Use this skill when the user asks about:
- Cointegration testing
- Stationarity (ADF test)
- Pairs trading
- Hedge ratio calculation
- ARIMA/GARCH
- Feature engineering for time series
- Lag features
- Rolling statistics

---

## Stationarity

Many time series models assume stationarity (constant mean/variance).

### Augmented Dickey-Fuller Test

```python
from statsmodels.tsa.stattools import adfuller

def adf_test(series):
    """Augmented Dickey-Fuller test for stationarity"""
    result = adfuller(series.dropna())
    return {
        'statistic': result[0],
        'pvalue': result[1],
        'is_stationary': result[1] < 0.05
    }
```

- **Null hypothesis**: Series has unit root (non-stationary)
- **p < 0.05**: Reject null → stationary

---

## Cointegration (Pairs Trading)

Two non-stationary series can be cointegrated if their linear combination is stationary.

### Cointegration Test

```python
from statsmodels.tsa.stattools import coint

def check_cointegration(series_a, series_b):
    """Test for cointegration between two price series"""
    score, pvalue, _ = coint(series_a, series_b)
    return pvalue < 0.05, score
```

### Hedge Ratio

```python
import statsmodels.api as sm

def calculate_hedge_ratio(series_a, series_b):
    """Calculate hedge ratio using OLS"""
    X = sm.add_constant(series_b)
    model = sm.OLS(series_a, X).fit()
    return model.params[1]
```

### Spread Calculation

```python
def spread(series_a, series_b, hedge_ratio):
    """Calculate spread for pairs trading"""
    return series_a - hedge_ratio * series_b

def zscore_spread(spread_series, window=20):
    """Normalize spread using rolling z-score"""
    return (spread_series - spread_series.rolling(window).mean()) / \
           spread_series.rolling(window).std()
```

### Pairs Trading Signals

```python
def pairs_signals(zscore, entry_z=2.0, exit_z=0.5):
    """
    Generate pairs trading signals
    Long spread when z < -entry_z
    Short spread when z > entry_z
    Exit when |z| < exit_z
    """
    signals = pd.Series(0, index=zscore.index)

    signals[zscore < -entry_z] = 1   # Long spread
    signals[zscore > entry_z] = -1   # Short spread
    signals[abs(zscore) < exit_z] = 0  # Exit

    return signals
```

---

## Feature Engineering

### Lag Features

```python
import pandas as pd

def create_lag_features(series, lags=[1, 5, 10, 20]):
    """Create lagged features"""
    features = pd.DataFrame(index=series.index)
    for lag in lags:
        features[f'lag_{lag}'] = series.shift(lag)
    return features
```

### Rolling Statistics

```python
def create_rolling_features(series, windows=[5, 10, 20]):
    """Create rolling statistics features"""
    features = pd.DataFrame(index=series.index)
    for window in windows:
        features[f'rolling_mean_{window}'] = series.rolling(window).mean()
        features[f'rolling_std_{window}'] = series.rolling(window).std()
        features[f'rolling_min_{window}'] = series.rolling(window).min()
        features[f'rolling_max_{window}'] = series.rolling(window).max()
    return features
```

---

## ARIMA/GARCH Concepts

### ARIMA (AutoRegressive Integrated Moving Average)

- **AR(p)**: AutoRegressive - past values
- **I(d)**: Integrated - differencing
- **MA(q)**: Moving Average - past errors

```python
from statsmodels.tsa.arima.model import ARIMA

model = ARIMA(series, order=(1, 1, 1))
fitted = model.fit()
forecast = fitted.forecast(steps=10)
```

### GARCH (Generalized AutoRegressive Conditional Heteroskedasticity)

Models volatility clustering:

```python
from arch import arch_model

model = arch_model(returns, vol='Garch', p=1, q=1)
fitted = model.fit()
forecast = fitted.forecast(horizon=5)
```

---

## Quick Reference

| Concept | Purpose | Test/Tool |
|---------|---------|-----------|
| Stationarity | Constant stats | ADF test |
| Cointegration | Long-run relationship | Engle-Granger |
| Hedge ratio | Relative sizing | OLS regression |
| ARIMA | Mean prediction | statsmodels |
| GARCH | Volatility prediction | arch library |
