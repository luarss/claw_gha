# Quantitative Developer Library Reference

Detailed reference for libraries commonly used in quantitative development.

---

## Python Data & Numerics

### NumPy
**Purpose**: Foundation for numerical computing in Python

```python
import numpy as np

# Array creation
arr = np.array([1, 2, 3])
matrix = np.zeros((3, 3))
random = np.random.randn(100, 100)

# Linear algebra
eigenvalues, eigenvectors = np.linalg.eig(matrix)
inverse = np.linalg.inv(matrix)
dot_product = np.dot(a, b)

# Broadcasting
normalized = (arr - arr.mean()) / arr.std()
```

**Key Functions**:
- `np.linalg` — Linear algebra operations
- `np.fft` — Fast Fourier Transform
- `np.random` — Random number generation
- `np.where` — Conditional selection

---

### Pandas
**Purpose**: Data manipulation and time series analysis

```python
import pandas as pd

# Time series handling
dates = pd.date_range('2024-01-01', periods=100, freq='D')
ts = pd.Series(np.random.randn(100), index=dates)

# Resampling
monthly = ts.resample('M').mean()
rolling_mean = ts.rolling(window=20).mean()

# DataFrame operations
df = pd.DataFrame({
    'price': prices,
    'volume': volumes
})
df['returns'] = df['price'].pct_change()
df['volatility'] = df['returns'].rolling(20).std()

# Grouping
sector_stats = df.groupby('sector').agg({
    'returns': ['mean', 'std'],
    'volume': 'sum'
})
```

**Key Functions**:
- `df.rolling()` — Rolling window calculations
- `df.resample()` — Time series resampling
- `df.shift()` — Lag/lead operations
- `df.merge()` — SQL-like joins

---

### SciPy
**Purpose**: Scientific computing and optimization

```python
from scipy import optimize, stats

# Optimization
result = optimize.minimize(
    portfolio_variance,
    x0=initial_weights,
    constraints={'type': 'eq', 'fun': lambda x: np.sum(x) - 1},
    bounds=[(0, 1) for _ in range(n_assets)]
)

# Statistical tests
t_stat, p_value = stats.ttest_ind(group_a, group_b)
corr, p_value = stats.pearsonr(x, y)

# Distribution fitting
params = stats.norm.fit(returns)
var_95 = stats.norm.ppf(0.05, *params)
```

---

## Machine Learning

### scikit-learn
**Purpose**: Traditional ML algorithms

```python
from sklearn.ensemble import RandomForestClassifier, GradientBoostingRegressor
from sklearn.model_selection import TimeSeriesSplit, cross_val_score
from sklearn.preprocessing import StandardScaler

# Time series cross-validation
tscv = TimeSeriesSplit(n_splits=5)

# Feature scaling
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Model training with CV
model = GradientBoostingRegressor(n_estimators=100, max_depth=5)
scores = cross_val_score(model, X_scaled, y, cv=tscv, scoring='neg_mean_squared_error')
```

---

### XGBoost / LightGBM
**Purpose**: Gradient boosting for tabular data

```python
import xgboost as xgb

# DMatrix for efficient handling
dtrain = xgb.DMatrix(X_train, label=y_train)
dtest = xgb.DMatrix(X_test)

# Training
params = {
    'objective': 'reg:squarederror',
    'max_depth': 6,
    'eta': 0.1,
    'subsample': 0.8
}
model = xgb.train(params, dtrain, num_boost_round=100)

# Feature importance
importance = model.get_score(importance_type='gain')
```

---

## Quant Ecosystem

### Zipline
**Purpose**: Backtesting engine (used by Quantopian)

```python
from zipline import run_algorithm
from zipline.api import order_target_percent, record, symbol

def initialize(context):
    context.asset = symbol('AAPL')

def handle_data(context, data):
    # Simple moving average crossover
    sma_short = data.history(context.asset, 'price', 10, '1d').mean()
    sma_long = data.history(context.asset, 'price', 30, '1d').mean()

    if sma_short > sma_long:
        order_target_percent(context.asset, 1.0)
    else:
        order_target_percent(context.asset, 0.0)

    record(price=data.current(context.asset, 'price'))
```

---

### Alphalens
**Purpose**: Alpha factor analysis

```python
from alphalens.utils import get_clean_factor_and_forward_returns
from alphalens.tears import create_full_tear_sheet

# Prepare factor data
factor_data = get_clean_factor_and_forward_returns(
    factor=factor_values,
    prices=price_data,
    periods=(1, 5, 10)
)

# Generate analysis
create_full_tear_sheet(factor_data)
```

---

### empyrical
**Purpose**: Risk and performance metrics

```python
import empyrical as ep

# Calculate metrics
returns = strategy_returns
benchmark = benchmark_returns

sharpe = ep.sharpe_ratio(returns)
sortino = ep.sortino_ratio(returns)
max_drawdown = ep.max_drawdown(returns)
alpha, beta = ep.alpha_beta(returns, benchmark)

# Rolling metrics
rolling_sharpe = ep.roll_sharpe_ratio(returns, window=63)
```

---

## C++ Performance Libraries

### Eigen
**Purpose**: Linear algebra in C++

```cpp
#include <Eigen/Dense>

using namespace Eigen;

MatrixXd A(3, 3);
VectorXd b(3);

// Solve Ax = b
VectorXd x = A.colPivHouseholderQr().solve(b);

// Matrix operations
MatrixXd C = A * B;
MatrixXd inverse = A.inverse();
EigenSolver<MatrixXd> es(A);
```

---

### Intel TBB / OpenMP
**Purpose**: Parallel computing

```cpp
#include <tbb/parallel_for.h>
#include <omp.h>

// TBB parallel loop
tbb::parallel_for(0, n, [&](int i) {
    result[i] = compute(data[i]);
});

// OpenMP
#pragma omp parallel for
for (int i = 0; i < n; i++) {
    result[i] = compute(data[i]);
}
```

---

## Time Series Databases

### kdb+ (q)
**Purpose**: High-performance time series database

```q
/ Load CSV
t: ("DFF";",") 0: `:data.csv

/ Time series query
select avg price by 5 xbar time.minute from t where date within (2024.01.01;2024.12.31)

/ Rolling calculation
update mavg: 20 mavg price by sym from t
```

---

## Streaming & Messaging

### Apache Kafka
**Purpose**: Real-time data streaming

```python
from kafka import KafkaProducer, KafkaConsumer

# Producer
producer = KafkaProducer(bootstrap_servers=['localhost:9092'])
producer.send('market-data', key=b'AAPL', value=json.dumps(tick).encode())

# Consumer
consumer = KafkaConsumer('market-data', bootstrap_servers=['localhost:9092'])
for message in consumer:
    tick = json.loads(message.value)
    process_tick(tick)
```

---

## Visualization

### matplotlib / seaborn
**Purpose**: Data visualization

```python
import matplotlib.pyplot as plt
import seaborn as sns

# Price chart with moving averages
fig, ax = plt.subplots(figsize=(12, 6))
ax.plot(df.index, df['price'], label='Price')
ax.plot(df.index, df['sma_20'], label='SMA 20')
ax.fill_between(df.index, df['price'], df['sma_20'], alpha=0.3)
ax.legend()

# Correlation heatmap
sns.heatmap(returns.corr(), annot=True, cmap='coolwarm')
```

---

## Library Selection Guide

| Task | Recommended Library |
|------|---------------------|
| Data manipulation | Pandas |
| Numerical computing | NumPy |
| Optimization | SciPy, CVXPY |
| ML classification | XGBoost, LightGBM |
| Backtesting | Zipline, Backtrader |
| Risk metrics | empyrical, Pyfolio |
| Factor analysis | Alphalens |
| Low-latency | C++ with Eigen |
| Streaming | Kafka, Flink |
| Time series DB | kdb+, InfluxDB |
