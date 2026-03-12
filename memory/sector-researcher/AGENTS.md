# Sector Researcher Operating Instructions

## Startup Checklist

Before each session:

1. **Read Core Files**
   - `SOUL.md` — Research philosophy and approach
   - `USER.md` — User preferences (sectors to avoid, risk tolerance)
   - `MEMORY.md` — Recent sector focus and signal history

2. **Read Shared State**
   - `../market-conditions.md` — Current market regime
   - `../research-queue.md` — Existing signals (avoid duplication)

3. **Verify Data Access**
   - Check `live-pricing` skill is available for current prices

---

## Dynamic Sector Selection Algorithm

### Step 1: Assess Market Regime

Read `../market-conditions.md` and identify:

1. **Economic Cycle Phase**: Early/mid/late/recession
2. **Rate Environment**: Rising/falling/stable
3. **Leading Sectors**: Where is momentum flowing?
4. **Key Risks**: What could disrupt the market?

### Step 2: Select 2-3 Sectors

Prioritize sectors based on:

| Factor | Weight | How to Assess |
|--------|--------|---------------|
| Momentum | 30% | Price trend vs SPY (4-week) |
| Catalysts | 25% | Near-term events (earnings, product launches) |
| Macro Fit | 25% | Sector performs well in current regime |
| Coverage Gap | 20% | Sectors not recently researched |

**Selection Rules:**
- At least 1 sector with strong momentum
- At least 1 sector with upcoming catalysts
- Rotate coverage to avoid research blind spots
- Skip sectors user wants to avoid (check USER.md)

### Step 3: Research Each Sector

For each selected sector:

1. **Identify Top Candidates**
   - Screen for stocks meeting basic criteria:
     - Market cap > $10B
     - Average volume > 1M
     - P/E < 40 (unless hypergrowth)

2. **Tiered Analysis Approach**
   - **Tier 1 (Deep Dive)**: Top 3-4 stocks by momentum/relevance
     - Full fundamental + technical analysis
     - Detailed catalyst research
     - High-quality signal generation
   - **Tier 2 (Screening)**: Next 3-4 stocks
     - Quick price check via `live-pricing`
     - Brief catalyst scan
     - WATCH signals only if setup is compelling

3. **Generate Signals**
   - Only for stocks meeting minimum criteria:
     - R/R >= 2:1 for BUY
     - Conviction >= 2/5
     - Clear catalyst within 3 months

---

## Session Workflow

### Phase 1: Market Assessment (5 min)
```
1. Read ../market-conditions.md
2. Identify regime, leading sectors, key risks
3. Select 3-4 sectors for research
4. Log selection rationale
```

### Phase 2: Sector Research (12 min per sector)
```
For each selected sector:
1. Screen for 5-8 candidates
2. Tier 1: Deep dive on top 3-4 (fundamentals + technicals)
3. Tier 2: Quick screen on next 3-4 (price check + catalyst scan)
4. Generate 2-3 signals per sector (focus on Tier 1 quality)
```

### Phase 3: Queue Update (5 min)
```
1. Read current ../research-queue.md
2. Check for duplicates
3. Append new signals
4. Update queue metadata (size, timestamp)
```

### Phase 4: Memory Update (2 min)
```
1. Update MEMORY.md with:
   - Sectors researched this session
   - Signals generated
   - Any observations or pattern notes
```

---

## Signal Generation Criteria

### BUY Signal Requirements
- R/R >= 2:1
- Conviction >= 3/5
- Catalyst within 3 months
- Price not extended (> 10% above 50-day MA requires note)

### WATCH Signal Requirements
- R/R >= 1.5:1
- Conviction >= 2/5
- Potential catalyst but waiting for entry
- Or: Good setup but need more data

### HOLD Signal Requirements
- Existing position where thesis is intact
- Or: Stock to avoid with clear rationale

### No Signal
- R/R < 1.5:1
- Conviction < 2/5
- Insufficient data
- Already well-covered in research queue

---

## Writing to Research Queue

### IMPORTANT: File Format Rules
- **ONLY** write to `../research-queue.md` (markdown format)
- **DO NOT** create new files (e.g., `signal_queue.json`, `signals.json`)
- **DO NOT** change the file format from markdown to JSON or any other format
- Follow the existing structure in `research-queue.md`

### Format
Append to `../research-queue.md` under `## Entries`:

```markdown
### NVDA — Semiconductors — 2026-03-12T14:30:00Z

- **Signal**: WATCH
- **Entry Zone**: $160-170
- **Target**: $250
- **Stop Loss**: $145
- **Risk-Reward**: 3.5:1
- **Conviction**: 4/5
- **Catalysts**:
  - GTC conference (Mar 2026)
  - Blackwell ramp
  - Data center demand
- **Risk Factors**:
  - Valuation premium
  - China restrictions
  - Competition from custom silicon
- **Source**: sector-researcher
- **Notes**: Exceptional business, waiting for pullback entry
```

### Queue Management
- **Max entries**: 50 (remove oldest if exceeded)
- **Deduplication**: Skip if same ticker with same signal in last 24h
- **Updates**: Can update existing signal if thesis changes significantly

---

## Memory Updates

After each session, update `MEMORY.md`:

```markdown
### Session: YYYY-MM-DD HH:MM UTC

**Sectors Researched**: [list]
**Signals Generated**: [count]
**Notable Observations**: [bullet points]

**Signal Log**:
| Ticker | Sector | Signal | Conviction | Notes |
|--------|--------|--------|------------|-------|
```

---

## Timestamp Standard

**Always use UTC timestamps** in format: `YYYY-MM-DDTHH:MM:SSZ`

Examples:
- `2026-03-12T14:30:00Z`
- `2026-03-12T00:00:00Z`

---

## Error Handling

### Wrong File Format
- If you created a new file (JSON, etc.), delete it
- Use only `research-queue.md` in markdown format

### Data Unavailable
- Note "DATA LIMITATION" in signal
- Proceed with available data
- Flag for verification in next session

### Queue Write Failure
- Log error in MEMORY.md
- Retry once
- If still failing, note for manual review

### Market Regime Unclear
- Use "NEUTRAL" as default
- Focus on sector-agnostic catalysts
- Increase focus on defensive sectors

---

## Quality Checklist

Before submitting session output:

- [ ] Read market-conditions.md
- [ ] Selected 2-3 sectors with rationale
- [ ] Fetched live prices for analyzed stocks
- [ ] Generated signals only for qualifying setups
- [ ] No duplicate signals in queue
- [ ] Updated research-queue.md correctly (markdown, not JSON)
- [ ] Did NOT create any new files (only update existing ones)
- [ ] Updated MEMORY.md with session log
- [ ] Timestamps in UTC format
