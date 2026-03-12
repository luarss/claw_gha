# Sector Analysis Skill

## Purpose
Analyze market sectors for rotation opportunities, relative strength, and thematic investing.

---

## Sector Analysis Framework

### 1. Sector Rotation Model

Based on Fidelity sector rotation theory:

| Economic Phase | Leading Sectors |
|----------------|-----------------|
| Early Recovery | Financials, Consumer Discretionary |
| Mid-Cycle | Technology, Industrials |
| Late Cycle | Energy, Materials, Commodities |
| Recession | Healthcare, Consumer Staples, Utilities |

### Current Regime Assessment

Check `market-conditions.md` for current phase and adjust focus accordingly.

---

## Relative Strength Analysis

### Methodology
Compare sector ETF performance vs SPY over multiple timeframes:

| Timeframe | Calculation | Signal |
|-----------|-------------|--------|
| 1-week | Price % change vs SPY | Short-term momentum |
| 4-week | Price % change vs SPY | Medium-term trend |
| 12-week | Price % change vs SPY | Long-term rotation |

### RS Score
```
RS = (Sector Return / SPY Return) × 100

RS > 110: Strong outperformance (bullish)
RS 90-110: In-line with market (neutral)
RS < 90: Underperformance (bearish)
```

---

## Sector ETF Reference

| Sector | ETF | Key Holdings |
|--------|-----|--------------|
| Technology | XLK | AAPL, MSFT, NVDA |
| Semiconductors | SMH, SOXX | NVDA, AVGO, AMD |
| Financials | XLF | BRK.B, JPM, V |
| Healthcare | XLV | UNH, JNJ, LLY |
| Consumer Disc. | XLY | AMZN, TSLA, HD |
| Consumer Staples | XLP | PG, KO, COST |
| Energy | XLE | XOM, CVX, COP |
| Industrials | XLI | GE, CAT, HON |
| Utilities | XLU | NEE, DUKE, SO |
| Real Estate | XLRE | AMT, PLD, SPG |
| Materials | XLB | LIN, SHW, APD |
| Communications | XLC | GOOGL, META, NFLX |

---

## Sector Analysis Workflow

### Step 1: Regime Check
1. Read `market-conditions.md`
2. Identify current economic phase
3. Note Fed stance and rate direction

### Step 2: Relative Strength Scan
1. Fetch sector ETF prices via `live-pricing`
2. Calculate RS vs SPY for 1w, 4w, 12w
3. Rank sectors by RS score

### Step 3: Momentum Confirmation
1. Check sector ETF is above 50-day MA
2. Check sector ETF is above 200-day MA
3. Note any divergences

### Step 4: Catalyst Assessment
For top 3 sectors by RS:
1. Research sector-specific news
2. Identify upcoming catalysts (earnings, regulatory, macro)
3. Assess sustainability of momentum

### Step 5: Generate Output
```markdown
## Sector Analysis — [YYYY-MM-DD HH:MM UTC]

### Market Regime
- **Phase**: [Early/Mid/Late/Recession]
- **Fed Stance**: [Cutting/Holding/Hiking]
- **Risk Sentiment**: [Risk-on/Risk-off/Neutral]

### Sector Rankings (by 4-week RS)

| Rank | Sector | RS Score | Trend | Catalyst Quality |
|------|--------|----------|-------|------------------|
| 1 | Semiconductors | 125 | ↑ | High (AI demand) |
| 2 | Technology | 115 | → | Medium (earnings) |

### Focus Sectors
1. **[Sector]** — [Rationale]
2. **[Sector]** — [Rationale]

### Avoid Sectors
1. **[Sector]** — [Rationale]
```

---

## Thematic Analysis

### Current Themes (2026)

| Theme | Sectors | Key Tickers | Status |
|-------|---------|-------------|--------|
| AI Infrastructure | Semis, Tech, Utilities | NVDA, SMCI, CEG | Active |
| Custom Silicon | Semis, Tech | AMD, AVGO, MRVL | Active |
| Enterprise AI | Software | MSFT, CRM, NOW | Active |
| Reshoring | Industrials | CAT, GE, DE | Emerging |
| Clean Energy | Energy, Utilities | ENPH, FSLR, NEE | Consolidating |

### Theme Lifecycle

1. **Emerging** (0-6 months): Early adopters, high volatility
2. **Active** (6-24 months): Broad participation, strong momentum
3. **Mature** (24-48 months): Consolidation, select winners
4. **Fading** (48+ months): Rotation to new themes

---

## Sector-Stock Mapping

Use this to identify tickers for each sector:

### Semiconductors
- **Leaders**: NVDA, AMD, AVGO, QCOM
- **Equipment**: ASML, AMAT, LRCX, KLAC
- **Memory**: MU, WDC
- **Foundry**: TSM, INTC

### Cloud Software
- **Hyperscalers**: AMZN, MSFT, GOOGL
- **SaaS**: CRM, NOW, SNOW, DDOG
- **Security**: CRWD, PANW, ZS

### Financials
- **Banks**: JPM, BAC, WFC, C
- **Investment Banks**: GS, MS
- **Payments**: V, MA, PYPL
- **Asset Managers**: BLK, SCHW

### Healthcare
- **Pharma**: JNJ, PFE, MRK, LLY
- **Biotech**: XBI, GILD, AMGN
- **Managed Care**: UNH, CI, HUM
- **MedTech**: ABT, MDT, SYK

---

## Integration with Sector Researcher

### Input for Sector Selection
The sector analysis output feeds into sector-researcher's sector selection algorithm:

1. **Focus Sectors** → Prioritize for research
2. **Avoid Sectors** → Skip in current session
3. **Theme Status** → Guide thematic research

### Usage in AGENTS.md
```markdown
1. Run sector-analysis skill
2. Use Focus Sectors for research targets
3. Cross-reference with market-conditions.md
```

---

## Quick Commands

- "Analyze sectors" → Full sector analysis
- "Sector rotation" → Regime-based sector recommendations
- "Top sectors" → RS-ranked sector list
- "Theme [X]" → Deep-dive on specific theme
- "Sector [X] tickers" → List key tickers for sector
