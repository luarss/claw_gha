# Data Sources & Usage Guide

Trusted sources for stock analysis and how to use them effectively.

---

## Priority Tiers for Parallel Fetching

To minimize latency, fetch sources by tier in parallel:

### Tier 1 — Essential (Fetch First, In Parallel)
Fetch these simultaneously at the start of analysis:
- **Yahoo Finance** — Price, market cap, P/E, key statistics
- **FinViz** — Visual snapshot, screening data, sector comparison

### Tier 2 — Secondary (Parallel with Tier 1)
Can be fetched alongside Tier 1 if needed:
- **SEC EDGAR** — Latest filing list (10-K, 10-Q, 8-K)
- **Seeking Alpha** — Analysis articles, earnings transcripts

### Tier 3 — On-Demand Only
Fetch only when specific data is needed:
- **TipRanks** — Analyst ratings aggregation
- **GuruFocus** — Value investing metrics, insider tracking
- **Morningstar** — Fair value estimates, moat ratings

**Parallel Strategy**: When analyzing a stock, initiate all Tier 1 and Tier 2 fetches simultaneously. Add Tier 3 sources only if the initial screen passes.

---

## Financial Data Sources

### Yahoo Finance (Primary)
**URL**: finance.yahoo.com
**Strengths**:
- Free, comprehensive financial data
- Historical prices, financials, key statistics
- Options data, analyst estimates

**Best For**:
- Quick quotes and basic metrics
- Historical price charts
- Financial statement data

**How to Use**:
```
1. Search ticker symbol
2. Statistics tab → Key metrics
3. Financials tab → Income statement, balance sheet, cash flow
4. Analysis tab → Analyst estimates
```

**Limitations**:
- Data may be delayed 15 minutes
- Some international stocks limited
- Occasional data errors (cross-reference)

---

### FinViz (Screening & Visualization)
**URL**: finviz.com
**Strengths**:
- Excellent stock screener
- Visual financial summaries
- News aggregation
- Insider trading data

**Best For**:
- Quick stock screening
- Visual snapshot of fundamentals
- Sector/industry comparison
- Identifying unusual activity

**How to Use**:
```
1. Screener tab → Set filters
2. Maps tab → Sector performance visualization
3. News tab → Latest headlines
4. Insider tab → Recent insider transactions
```

---

### Seeking Alpha (Analysis & Opinions)
**URL**: seekingalpha.com
**Strengths**:
- Detailed analysis articles
- Earnings call transcripts
- Quant ratings
- Dividend data

**Best For**:
- In-depth analysis from various perspectives
- Earnings call transcripts (free)
- Understanding bull/bear arguments

**Caveats**:
- Contributors have varying quality
- Check author's track record
- Some content behind paywall

---

### Morningstar (Research Reports)
**URL**: morningstar.com
**Strengths**:
- Independent research
- Fair value estimates
- Economic moat ratings
- Portfolio analysis

**Best For**:
- Quality assessment
- Fair value estimates
- Mutual fund/ETF analysis

**Limitations**:
- Full access requires subscription
- Free tier has valuable data

---

## SEC Filings (Primary Sources)

### 10-K (Annual Report)
**What It Is**: Comprehensive annual financial statement
**Where**: sec.gov or company investor relations

**Key Sections**:
1. Business Overview → Understanding the company
2. Risk Factors → What could go wrong
3. Financial Statements → The numbers
4. MD&A → Management's view
5. Notes to Financials → Accounting details

**What to Look For**:
- Revenue and earnings trends
- Debt levels and covenants
- Legal proceedings
- Related party transactions
- Changes in accounting

---

### 10-Q (Quarterly Report)
**What It Is**: Quarterly update on financials
**Where**: sec.gov or company IR

**Key Sections**:
- Quarterly financials
- Management discussion
- Material changes

**What to Look For**:
- Sequential trends
- Comparison to same quarter last year
- Any surprises or changes

---

### 8-K (Current Report)
**What It Is**: Disclosure of material events
**When Filed**: Within 4 business days of event

**Common Events**:
- Earnings announcements
- M&A activity
- Management changes
- Legal matters
- Capital raises

---

### DEF 14A (Proxy Statement)
**What It Is**: Information for shareholder voting
**Where**: sec.gov

**Key Information**:
- Executive compensation
- Board composition
- Related party transactions
- Shareholder proposals

---

## News Sources

### Bloomberg
**URL**: bloomberg.com
**Strengths**:
- High-quality financial journalism
- Real-time market coverage
- Global perspective

**Limitations**:
- Some content behind paywall

---

### Reuters
**URL**: reuters.com
**Strengths**:
- Factual, unbiased reporting
- Global coverage
- Breaking news

**Best For**:
- Breaking market news
- International markets
- Objective reporting

---

### Wall Street Journal
**URL**: wsj.com
**Strengths**:
- Deep analysis
- Company coverage
- Market commentary

**Limitations**:
- Subscription required for most content

---

### Financial Times
**URL**: ft.com
**Strengths**:
- Global business coverage
- Deep analysis
- European markets focus

---

## Analysis Platforms

### Zack's
**URL**: zacks.com
**Strengths**:
- Earnings estimate revisions
- Earnings surprise history
- Style scores

**Best For**:
- Earnings-focused analysis
- Estimate revision tracking

---

### TipRanks
**URL**: tipranks.com
**Strengths**:
- Analyst rating aggregation
- Analyst track records
- Insider trading signals
- Blogger/opinion aggregation

**Best For**:
- Seeing consensus estimates
- Checking analyst credibility

---

### GuruFocus
**URL**: gurufocus.com
**Strengths**:
- Value investing focus
- Insider ownership tracking
- Historical financial data

**Best For**:
- Value investing research
- Following hedge fund positions

---

## Social Sentiment Sources

### Reddit (r/wallstreetbets, r/stocks, r/investing)
**Use With Caution**: Often contrarian indicator
**Best For**:
- Gauging retail sentiment
- Identifying potential short squeezes
- Understanding popular narratives

**Warning**: Do NOT use as investment thesis

---

### Twitter/X Financial Twitter ("FinTwit")
**Use**: Following respected analysts and traders
**Best For**:
- Real-time market commentary
- Diverse viewpoints
- Breaking news

**Warning**: Quality varies enormously; curate follows carefully

---

## Earnings Call Resources

### Company Investor Relations
**Best Source**: Company's own website
**What to Find**:
- Earnings call transcripts
- Presentation slides
- Quarterly/annual reports

### Seeking Alpha
**Strength**: Free access to transcripts
**What to Look For**:
- Q&A section (management unscripted)
- Guidance updates
- Tone and confidence

---

## Economic Data Sources

### Federal Reserve Economic Data (FRED)
**URL**: fred.stlouisfed.org
**Best For**:
- Economic indicators
- Interest rate history
- Inflation data

### Bureau of Labor Statistics (BLS)
**URL**: bls.gov
**Best For**:
- Employment data
- Inflation (CPI)
- Productivity

### Bureau of Economic Analysis (BEA)
**URL**: bea.gov
**Best For**:
- GDP data
- Corporate profits
- Personal income

---

## Sector-Specific Sources

### Technology
- **TechCrunch**: Industry news
- **The Information**: Deep tech reporting (subscription)
- **Stratechery**: Analysis (Ben Thompson)

### Energy
- **EIA**: Energy Information Administration data
- **Oil Price**: Oilprice.com

### Healthcare
- **FDA**: Approval news
- **BioPharma Dive**: Industry coverage

### Financials
- **Federal Reserve**: Banking data
- **FDIC**: Bank data

---

## Data Verification Protocol

### Price Data
1. Primary source: Yahoo Finance
2. Cross-check: FinViz or broker
3. For trading: Use real-time source

### Fundamental Data
1. Primary source: SEC filings (10-K, 10-Q)
2. Cross-check: Yahoo Finance, company IR
3. Verify key metrics independently

### News
1. Primary source: Company press release
2. Cross-check: Bloomberg, Reuters
3. Avoid: Unnamed sources, speculation

### Analyst Estimates
1. Primary source: Yahoo Finance (consensus)
2. Cross-check: TipRanks, Zack's
3. Consider: Historical accuracy

---

## Source Quality Hierarchy

```
Tier 1 (Highest Quality):
├── SEC Filings (10-K, 10-Q, 8-K)
├── Company Press Releases
├── Earnings Call Transcripts
└── Bloomberg/Reuters Breaking News

Tier 2 (Good Quality):
├── Wall Street Journal / Financial Times
├── Morningstar Research
├── Yahoo Finance Data
└── Seeking Alpha (with author verification)

Tier 3 (Use with Caution):
├── Analyst Reports (consider conflicts)
├── Financial Blogs
├── Social Media (contrarian indicator)
└── Mainstream Media (general coverage)

Tier 4 (Avoid for Investment Decisions):
├── Anonymous message boards
├── Paid promotions
├── Social media hype
└── Unverified rumors
```

---

## Search Strategy

### For Company Analysis
```
1. "[TICKER] investor relations" → Company IR page
2. "[TICKER] 10-K sec.gov" → SEC filings
3. "[TICKER] earnings transcript" → Seeking Alpha
4. "[TICKER] yahoo finance" → Key metrics
5. "[TICKER] latest news" → Recent developments
```

### For Sector Analysis
```
1. "[Sector] ETF performance" → Sector trend
2. "[Sector] news 2026" → Recent developments
3. "sector rotation 2026" → Macro positioning
```

### For Economic Context
```
1. "FRED [indicator]" → Economic data
2. "Federal Reserve latest statement" → Monetary policy
3. "[Country] GDP growth 2026" → International context
```

---

## Citation Best Practices

When documenting analysis in MEMORY.md:

```markdown
### Data Sources Used
- Price data: Yahoo Finance (2026-03-10)
- Financials: 10-K FY2025
- Analyst estimates: TipRanks consensus
- News: Reuters article (2026-03-08)
```

This enables verification and updates.
