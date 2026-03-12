# Quantitative Developer Skill

## Purpose
Reference guide for quantitative development skills, tools, and best practices for building financial systems.

---

## Core Programming Languages

### Primary Languages
| Language | Use Case | Proficiency |
|----------|----------|-------------|
| **Python** | Data analysis, ML, backtesting, prototyping | Expert |
| **C++** | Low-latency systems, HFT, performance-critical | Expert |
| **SQL** | Database queries, data manipulation | Strong |
| **R** | Statistical computing | Working |
| **Java/Scala** | Enterprise systems, Spark | Working |

### Python Libraries (Essential)
| Library | Purpose |
|---------|---------|
| NumPy | Array operations, linear algebra |
| Pandas | DataFrames, time series handling |
| SciPy | Optimization, statistics |
| scikit-learn | Machine learning |
| statsmodels | Statistical modeling |
| matplotlib/seaborn | Visualization |

### Quant Ecosystem Libraries
| Library | Purpose |
|---------|---------|
| Zipline | Backtesting engine |
| Alphalens | Alpha factor analysis |
| Pyfolio | Portfolio analytics |
| empyrical | Risk/performance metrics |
| TradingCalendars | Exchange calendars |

---

## Mathematical Foundations

### Core Mathematics
- **Linear Algebra**: Matrix operations, eigenvalues, SVD, PCA
- **Calculus**: Partial derivatives, gradients, optimization
- **Probability**: Distributions, Bayes, stochastic processes

### Advanced Topics
- **Stochastic Calculus**: Ito calculus, Brownian motion, SDEs
- **Time Series**: ARIMA, GARCH, cointegration, stationarity
- **Numerical Methods**: Monte Carlo, finite differences, PDE solvers
- **Optimization**: Convex optimization, gradient descent, Lagrangians

---

## Financial Knowledge

### Derivatives & Pricing
- Black-Scholes model and Greeks
- Binomial/trinomial trees
- Monte Carlo option pricing
- Interest rate models (Vasicek, Hull-White)

### Risk Management
- Value at Risk (VaR, CVaR)
- Factor models (Fama-French)
- Stress testing, scenario analysis
- Counterparty credit risk

### Portfolio Theory
- Mean-variance optimization
- CAPM, APT, beta calculation
- Sharpe/Sortino/Information ratios
- Black-Litterman model

### Market Microstructure
- Order book dynamics
- Execution algorithms (VWAP, TWAP)
- Market impact models
- Latency arbitrage

---

## Technical Skills

### Low-Latency Programming
- Memory management, cache optimization
- Lock-free data structures
- Multithreading, SIMD
- Network programming (FIX, binary protocols)

### Data Engineering
- Real-time streaming (Kafka, Flink)
- Time-series databases (kdb+, InfluxDB)
- ETL pipelines
- Cloud (AWS Kinesis, GCP Pub/Sub)

### System Design
- Event-driven architecture
- Microservices for trading systems
- Message queues, pub/sub patterns
- Database sharding, replication

---

## Machine Learning

### Traditional ML
- Regression, classification
- Ensemble methods (RF, XGBoost, LightGBM)
- Feature engineering for financial data
- Cross-validation with time series

### Deep Learning
- LSTM/GRU for sequence prediction
- Transformers for time series
- Reinforcement learning (DQN, PPO)
- NLP for sentiment analysis

---

## Best Practices

### Code Quality
- Unit tests for trading logic
- Integration tests for data pipelines
- Performance profiling
- Documentation

### Risk Controls
- Position limits in code
- Kill switches
- Audit logging
- Paper trading before live

---

## Supporting Reference Files

| File | Purpose |
|------|---------|
| `LIBRARIES.md` | Detailed library reference with examples |
| `ALGORITHMS.md` | Common algorithms and implementation patterns |

---

## Quick Commands

When user asks:
- "What libraries for [task]?" → Recommend appropriate Python/C++ libraries
- "How to implement [algorithm]?" → Provide implementation guidance
- "Explain [concept]" → Define and provide examples
- "Interview prep for quant dev" → Cover key topics and common questions
