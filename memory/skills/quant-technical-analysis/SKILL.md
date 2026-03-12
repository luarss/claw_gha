# Quantitative Technical Analysis

## Purpose

Technical indicators and trading signal generation.

---

## Trigger

Use this skill when the user asks about:
- Technical indicators
- Moving averages (SMA, EMA)
- MACD, RSI, Bollinger Bands
- Trading signals
- Momentum indicators
- Trend following

---

## Moving Averages

### Simple Moving Average (SMA)

```python
import pandas as pd

def sma(prices, window):
    """Simple Moving Average"""
    return prices.rolling(window=window).mean()
```

### Exponential Moving Average (EMA)

More weight to recent prices:

```python
def ema(prices, span):
    """Exponential Moving Average"""
    return prices.ewm(span=span, adjust=False).mean()
```

---

## MACD

Moving Average Convergence Divergence:

```python
def macd(prices, fast=12, slow=26, signal=9):
    """
    MACD indicator
    Returns: (macd_line, signal_line, histogram)
    """
    ema_fast = ema(prices, fast)
    ema_slow = ema(prices, slow)
    macd_line = ema_fast - ema_slow
    signal_line = ema(macd_line, signal)
    histogram = macd_line - signal_line
    return macd_line, signal_line, histogram
```

**Trading signals:**
- MACD crosses above signal: bullish
- MACD crosses below signal: bearish

---

## RSI (Relative Strength Index)

Momentum oscillator (0-100):

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

**Interpretation:**
- RSI > 70: Overbought
- RSI < 30: Oversold

---

## Bollinger Bands

Volatility-based bands around moving average:

```python
def bollinger_bands(prices, window=20, num_std=2):
    """
    Bollinger Bands
    Returns: (upper, middle, lower)
    """
    middle = sma(prices, window)
    std = prices.rolling(window=window).std()
    upper = middle + num_std * std
    lower = middle - num_std * std
    return upper, middle, lower
```

**Trading signals:**
- Price touches upper band: potential reversal down
- Price touches lower band: potential reversal up
- Bands widen: increasing volatility
- Bands narrow: decreasing volatility (squeeze)

---

## Signal Generation Pattern

Combine indicators into actionable signals:

```python
def generate_signals(prices):
    """Example signal generation combining indicators"""
    signals = pd.DataFrame(index=prices.index)

    # Trend filter: SMA crossover
    signals['sma_fast'] = sma(prices, 20)
    signals['sma_slow'] = sma(prices, 50)
    signals['trend'] = (signals['sma_fast'] > signals['sma_slow']).astype(int)

    # Momentum: RSI
    signals['rsi'] = rsi(prices)
    signals['oversold'] = (signals['rsi'] < 30).astype(int)
    signals['overbought'] = (signals['rsi'] > 70).astype(int)

    # Volatility: Bollinger position
    upper, middle, lower = bollinger_bands(prices)
    signals['bb_position'] = (prices - lower) / (upper - lower)

    # Combined signal
    signals['buy'] = (
        (signals['trend'] == 1) &
        (signals['oversold'] == 1)
    )
    signals['sell'] = (
        (signals['trend'] == 0) &
        (signals['overbought'] == 1)
    )

    return signals
```

---

## Quick Reference

| Indicator | Type | Typical Parameters |
|-----------|------|-------------------|
| SMA | Trend | 20, 50, 200 days |
| EMA | Trend | 12, 26 days |
| MACD | Momentum | 12/26/9 |
| RSI | Momentum | 14 periods |
| Bollinger | Volatility | 20 days, 2 std |
