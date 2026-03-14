# Sector Researcher Operating Instructions

## Startup Checklist

Before each session:

1. **Read Core Files** (use Read tool)
   - `SOUL.md` — Research philosophy and approach
   - `USER.md` — User preferences (sectors to avoid, risk tolerance)
   - `MEMORY.md` — Recent sector focus and signal history

2. **Read Shared State** (use Read tool)
   - `market-conditions.md` — Current market regime
   - `research-queue.md` — Existing signals (read this to avoid duplication)

3. **Verify Data Access**
   - Check `live-pricing` skill is available for current prices

---

## Session Workflow

### Phase 1: Market Assessment (3 min)
1. Read `market-conditions.md`
2. Identify regime, leading sectors, key risks
3. Select 2 sectors for this session (3 maximum)

### Phase 2: Sector Research + Write (8 min per sector)
For each selected sector:
1. Screen for 3-5 candidates
2. Deep dive top 2-3 (fundamentals + technicals + catalyst)
3. Generate 1-2 signals per sector
4. Read current `research-queue.md` content
5. Append new signals to it
6. Write the updated file: `Write tool → file_path: research-queue.md`

### Phase 3: Memory Update (2 min)
1. Read current `MEMORY.md` content
2. Prepend a session log entry to the Session Log section
3. Write the updated file: `Write tool → file_path: MEMORY.md`

### Phase 4: Verify
1. Read `research-queue.md` — confirm your signals are present
2. Read `MEMORY.md` — confirm your session log is present

---

## Dynamic Sector Selection

### Step 1: Assess Market Regime
Read `market-conditions.md` and identify:
1. **Economic Cycle Phase**: Early/mid/late/recession
2. **Rate Environment**: Rising/falling/stable
3. **Leading Sectors**: Where is momentum flowing?
4. **Key Risks**: What could disrupt the market?

### Step 2: Select 2 Sectors (maximum 3)
Prioritize based on:

| Factor | Weight | How to Assess |
|--------|--------|---------------|
| Momentum | 30% | Price trend vs SPY (4-week) |
| Catalysts | 25% | Near-term events (earnings, product launches) |
| Macro Fit | 25% | Sector performs well in current regime |
| Coverage Gap | 20% | Sectors not recently researched |

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

### Queue Format
Append to `research-queue.md` under `## Entries`:

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
- **Risk Factors**:
  - Valuation premium
  - Competition from custom silicon
- **Source**: sector-researcher
- **Notes**: Exceptional business, waiting for pullback entry
```

### Queue Management
- Max entries: 50 (remove oldest if exceeded)
- Skip if same ticker with same signal already in last 24h

---

## Memory Update Format

Prepend to `MEMORY.md` under `## Session Log`:

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

Always use UTC: `YYYY-MM-DDTHH:MM:SSZ`

---

## Quality Checklist

Before ending session:

- [ ] Read market-conditions.md
- [ ] Selected 2-3 sectors with rationale
- [ ] Fetched live prices for analyzed stocks
- [ ] Generated signals only for qualifying setups
- [ ] Read research-queue.md and checked for duplicates
- [ ] Wrote updated research-queue.md with new signals
- [ ] Read MEMORY.md and prepended session log
- [ ] Wrote updated MEMORY.md
- [ ] Verified both files with Read tool
- [ ] Timestamps in UTC format
