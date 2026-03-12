# Quantitative Algorithms & Patterns

Common algorithms and implementation patterns for quantitative development.

---

## Portfolio Optimization

### Mean-Variance Optimization (Markowitz)

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

# Example usage
expected_returns = np.array([0.12, 0.10, 0.08, 0.15])
cov_matrix = np.array([
    [0.04, 0.01, 0.005, 0.02],
    [0.01, 0.03, 0.008, 0.015],
    [0.005, 0.008, 0.02, 0.01],
    [0.02, 0.015, 0.01, 0.06]
])
optimal_weights = optimize_portfolio(expected_returns, cov_matrix)
```

### Efficient Frontier

```python
def compute_efficient frontier(expected_returns, cov_matrix, n_points=100):
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

## Risk Metrics

### Value at Risk (VaR)

```python
import numpy as np
from scipy import stats

def var_historical(returns, confidence=0.95):
    """Historical VaR"""
    return np.percentile(returns, (1 - confidence) * 100)

def var_parametric(returns, confidence=0.95):
    """Parametric VaR (assumes normal distribution)"""
    mu = returns.mean()
    sigma = returns.std()
    return stats.norm.ppf(1 - confidence, mu, sigma)

def var_monte_carlo(returns, confidence=0.95, n_simulations=10000):
    """Monte Carlo VaR"""
    mu = returns.mean()
    sigma = returns.std()

    simulated = np.random.normal(mu, sigma, n_simulations)
    return np.percentile(simulated, (1 - confidence) * 100)

# Conditional VaR (Expected Shortfall)
def cvar(returns, confidence=0.95):
    var = var_historical(returns, confidence)
    return returns[returns <= var].mean()
```

### Maximum Drawdown

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

## Option Pricing

### Black-Scholes

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

def black_scholes_put(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)

    put_price = K * np.exp(-r * T) * norm.cdf(-d2) - S * norm.cdf(-d1)
    return put_price

# Greeks
def delta_call(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    return norm.cdf(d1)

def gamma(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    return norm.pdf(d1) / (S * sigma * np.sqrt(T))

def vega(S, K, T, r, sigma):
    d1 = (np.log(S / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    return S * norm.pdf(d1) * np.sqrt(T)
```

### Monte Carlo Option Pricing

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

## Technical Indicators

### Moving Averages

```python
def sma(prices, window):
    """Simple Moving Average"""
    return prices.rolling(window=window).mean()

def ema(prices, span):
    """Exponential Moving Average"""
    return prices.ewm(span=span, adjust=False).mean()

def macd(prices, fast=12, slow=26, signal=9):
    """MACD indicator"""
    ema_fast = ema(prices, fast)
    ema_slow = ema(prices, slow)
    macd_line = ema_fast - ema_slow
    signal_line = ema(macd_line, signal)
    histogram = macd_line - signal_line
    return macd_line, signal_line, histogram
```

### RSI

```python
def rsi(prices, window=14):
    """Relative Strength Index"""
    delta = prices.diff()
    gain = delta.where(delta > 0, 0)
    loss = (-delta).where(delta < 0, 0)

    avg_gain = gain.rolling(window=window).mean()
    avg_loss = loss.rolling(window=window).mean()

    rs = avg_gain / avg_loss
    return 100 - (100 / (1 + rs))
```

### Bollinger Bands

```python
def bollinger_bands(prices, window=20, num_std=2):
    """Bollinger Bands"""
    middle = sma(prices, window)
    std = prices.rolling(window=window).std()
    upper = middle + num_std * std
    lower = middle - num_std * std
    return upper, middle, lower
```

---

## Execution Algorithms

### VWAP (Volume Weighted Average Price)

```python
def vwap_schedule(total_shares, volume_profile, n_slices):
    """
    Split order according to volume profile
    volume_profile: array of expected volume fractions per time slice
    """
    # Normalize volume profile
    volume_profile = np.array(volume_profile) / sum(volume_profile)

    # Calculate shares per slice
    shares_per_slice = total_shares * volume_profile

    return shares_per_slice

def calculate_vwap(prices, volumes):
    """Calculate VWAP from trades"""
    return (prices * volumes).sum() / volumes.sum()
```

### TWAP (Time Weighted Average Price)

```python
def twap_schedule(total_shares, n_slices):
    """Split order evenly across time slices"""
    shares_per_slice = total_shares / n_slices
    return np.full(n_slices, shares_per_slice)

def calculate_twap(prices):
    """Calculate TWAP from prices"""
    return prices.mean()
```

---

## Time Series Analysis

### Cointegration (Pairs Trading)

```python
from statsmodels.tsa.stattools import coint, adfuller
import statsmodels.api as sm

def check_cointegration(series_a, series_b):
    """Test for cointegration between two price series"""
    score, pvalue, _ = coint(series_a, series_b)
    return pvalue < 0.05, score

def calculate_hedge_ratio(series_a, series_b):
    """Calculate hedge ratio using OLS"""
    X = sm.add_constant(series_b)
    model = sm.OLS(series_a, X).fit()
    return model.params[1]

def spread(series_a, series_b, hedge_ratio):
    """Calculate spread for pairs trading"""
    return series_a - hedge_ratio * series_b

def zscore_spread(spread_series, window=20):
    """Normalize spread using rolling z-score"""
    return (spread_series - spread_series.rolling(window).mean()) / spread_series.rolling(window).std()
```

### Stationarity Test

```python
def adf_test(series):
    """Augmented Dickey-Fuller test for stationarity"""
    result = adfuller(series.dropna())
    return {
        'statistic': result[0],
        'pvalue': result[1],
        'is_stationary': result[1] < 0.05
    }
```

---

## Performance Metrics

### Sharpe & Sortino Ratios

```python
def sharpe_ratio(returns, risk_free_rate=0.0, periods_per_year=252):
    """Annualized Sharpe ratio"""
    excess_returns = returns - risk_free_rate / periods_per_year
    return np.sqrt(periods_per_year) * excess_returns.mean() / excess_returns.std()

def sortino_ratio(returns, risk_free_rate=0.0, periods_per_year=252):
    """Annualized Sortino ratio (downside deviation)"""
    excess_returns = returns - risk_free_rate / periods_per_year
    downside_returns = excess_returns[excess_returns < 0]
    downside_std = np.sqrt((downside_returns ** 2).mean())
    return np.sqrt(periods_per_year) * excess_returns.mean() / downside_std

def information_ratio(returns, benchmark_returns, periods_per_year=252):
    """Information ratio vs benchmark"""
    active_returns = returns - benchmark_returns
    tracking_error = active_returns.std()
    return np.sqrt(periods_per_year) * active_returns.mean() / tracking_error
```

---

## Feature Engineering

### Lag Features

```python
def create_lag_features(series, lags=[1, 5, 10, 20]):
    """Create lagged features"""
    features = pd.DataFrame(index=series.index)
    for lag in lags:
        features[f'lag_{lag}'] = series.shift(lag)
    return features

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

## Common Patterns

### Event-Driven Backtest

```python
class BacktestEngine:
    def __init__(self, data, strategy):
        self.data = data
        self.strategy = strategy
        self.positions = {}
        self.cash = 100000
        self.trades = []

    def run(self):
        for timestamp, row in self.data.iterrows():
            signals = self.strategy.generate_signals(row, self.positions)

            for symbol, action in signals.items():
                if action == 'BUY':
                    self._execute_buy(symbol, row[symbol], timestamp)
                elif action == 'SELL':
                    self._execute_sell(symbol, row[symbol], timestamp)

        return self._calculate_performance()

    def _execute_buy(self, symbol, price, timestamp):
        shares = self.cash * 0.1 / price  # 10% of cash
        self.positions[symbol] = self.positions.get(symbol, 0) + shares
        self.cash -= shares * price
        self.trades.append({'timestamp': timestamp, 'symbol': symbol, 'action': 'BUY', 'shares': shares})
```

### Risk-Adjusted Position Sizing

```python
def kelly_criterion(win_rate, avg_win, avg_loss):
    """Kelly criterion for position sizing"""
    b = avg_win / avg_loss  # Win/loss ratio
    q = 1 - win_rate
    kelly = (win_rate * b - q) / b
    return max(0, kelly)  # Never negative

def volatility_scaled_position(target_vol, asset_vol, portfolio_value):
    """Scale position by volatility"""
    return target_vol / asset_vol * portfolio_value
```
