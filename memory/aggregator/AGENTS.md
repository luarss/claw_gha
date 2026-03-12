# Aggregator Operating Instructions

## Startup Checklist

Before each session:

1. **Read Core Files**
   - `SOUL.md` — Prioritization philosophy and scoring
   - `MEMORY.md` — Recent summaries and performance tracking

2. **Read Shared State**
   - `research-queue.md` — Input signals to process
   - `market-conditions.md` — Current regime for cross-check
   - `priority-ideas.md` — Previous output (for continuity)

---

## Session Workflow

### Phase 1: Queue Intake (3 min)

```
1. Read research-queue.md
2. Parse all entries
3. Calculate age of each signal
4. Filter out signals > 48 hours old
```

### Phase 2: Signal Scoring (5 min)

For each valid signal:

```
1. Extract: Conviction, R/R, Catalysts
2. Calculate Freshness score:
   - < 6h: 5 points
   - < 24h: 4 points
   - < 48h: 3 points
   - > 48h: 0 points (filtered out)

3. Assess Catalyst Quality (1-5):
   - 5: Earnings, FDA approval, major product launch
   - 4: Analyst upgrades, sector rotation
   - 3: General momentum, news flow
   - 2: Minor catalysts
   - 1: No clear catalyst

4. Calculate Composite Score:
   Score = (Conviction × 2) + R/R + CatalystQuality + Freshness
```

### Phase 3: Cross-Check (3 min)

```
1. Read market-conditions.md
2. For each signal, verify:
   - Does sector align with current regime?
   - Any major risks that could invalidate thesis?
   - Is the stock already on stock-picker's watch list?
3. Adjust score if needed (±1 for regime fit)
```

### Phase 4: Ranking & Output (4 min)

```
1. Sort signals by score (descending)
2. Select top 5-10 (minimum 3 if available)
3. Write to priority-ideas.md:
   - Summary of market regime
   - Priority table
   - Signal details with scores
   - Archive section
```

### Phase 5: Queue Cleanup (2 min)

```
1. Remove processed signals from research-queue.md
2. Keep queue clean for next sector-researcher run
3. Update queue metadata (size, timestamp)
```

### Phase 6: Memory Update (2 min)

```
1. Update MEMORY.md with:
   - Signals processed count
   - Signals archived count
   - Top priority signal
   - Any observations
```

---

## Scoring Examples

### Example 1: Strong Signal
```
Signal: NVDA — Semiconductors
- Conviction: 4/5
- R/R: 3.5:1 (capped at 5 → 4)
- Catalysts: GTC conference, Blackwell ramp
- Age: 2 hours

Scoring:
- Conviction × 2 = 8
- R/R = 4
- Catalyst Quality = 5 (major events)
- Freshness = 5 (< 6h)
- Total = 21 → P1 (max score, round down if needed)
```

### Example 2: Moderate Signal
```
Signal: AMZN — Technology
- Conviction: 3/5
- R/R: 2.5:1 (→ 3)
- Catalysts: AWS AI monetization
- Age: 18 hours

Scoring:
- Conviction × 2 = 6
- R/R = 3
- Catalyst Quality = 4 (sector momentum)
- Freshness = 4 (< 24h)
- Total = 17 → P1
```

### Example 3: Weak Signal
```
Signal: XYZ — Consumer
- Conviction: 2/5
- R/R: 1.5:1 (→ 2)
- Catalysts: None specific
- Age: 30 hours

Scoring:
- Conviction × 2 = 4
- R/R = 2
- Catalyst Quality = 2 (minor catalysts)
- Freshness = 3 (< 48h)
- Total = 11 → P3 (archive if < 8)
```

---

## Output File Format

### priority-ideas.md Structure

```markdown
# Priority Ideas — Updated YYYY-MM-DDTHH:MM:SSZ

## Summary
[1-2 sentence market regime summary from market-conditions.md]

## Top Signals

| Priority | Ticker | Sector | Signal | Entry | Target | R/R | Conviction | Key Catalyst |
|----------|--------|--------|--------|-------|--------|-----|------------|--------------|
| 1 | NVDA | Semi | WATCH | $160-170 | $250 | 3.5:1 | 4/5 | GTC, Blackwell |
| 2 | ... | ... | ... | ... | ... | ... | ... | ... |

## Signal Details

### P1: NVDA — Score: 21
- **Source**: sector-researcher (2026-03-12T12:00:00Z)
- **Signal**: WATCH
- **Entry Zone**: $160-170
- **Target**: $250 | **Stop**: $145
- **R/R**: 3.5:1
- **Catalysts**: GTC conference (Mar), Blackwell ramp
- **Risks**: Valuation premium, China restrictions
- **Scoring**: Conviction(8) + R/R(4) + Catalyst(5) + Freshness(4) = 21

[Repeat for each signal]

## Archived This Session

| Ticker | Reason | Original Score |
|--------|--------|----------------|
| OLD1 | Age > 48h | 10 |
| OLD2 | Duplicate of NVDA | 8 |

## Next Review
Scheduled: [Next aggregator run time, ~2 hours]
```

---

## Queue Cleanup

### After Processing

Update `research-queue.md`:

```markdown
---
queue_size: X
last_updated: YYYY-MM-DDTHH:MM:SSZ
max_age_hours: 48
---

# Research Queue

## Entries

<!-- Remaining signals after aggregator processing -->
```

### Archive Rules
- **Remove**: Signals > 48 hours old
- **Remove**: Signals that were added to priority-ideas.md
- **Keep**: Signals with score < 8 (note in archive, don't include in priority)

---

## Error Handling

### Empty Queue
- Write to priority-ideas.md: "No signals in queue"
- Note in MEMORY.md for tracking

### All Signals Low Quality
- Priority list may have < 5 signals
- Note: "Limited high-quality signals this session"
- Recommend sectors for sector-researcher to focus on

### Market Regime Change
- If market-conditions.md shows major regime shift:
  - Add warning to priority-ideas.md
  - Reduce scores for misaligned signals by 2 points

---

## Timestamp Standard

**Always use UTC timestamps** in format: `YYYY-MM-DDTHH:MM:SSZ`

---

## Quality Checklist

Before submitting output:

- [ ] Read all signals from research-queue.md
- [ ] Filtered out signals > 48 hours old
- [ ] Calculated composite score for each signal
- [ ] Cross-checked against market-conditions.md
- [ ] Ranked and selected top 5-10 signals
- [ ] Wrote priority-ideas.md with correct format
- [ ] Cleaned up research-queue.md
- [ ] Updated MEMORY.md with session log
- [ ] All timestamps in UTC format
