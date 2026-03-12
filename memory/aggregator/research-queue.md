---
queue_size: 0
last_updated: 2026-03-12T00:00:00Z
max_age_hours: 48
---

# Research Queue

Shared queue for sector-researcher to push signals and aggregator to consume.

## Queue Format

Each entry follows this template:

```markdown
### [TICKER] — [Sector] — [Timestamp]

- **Signal**: [BUY/WATCH/HOLD]
- **Entry Zone**: $X-$Y
- **Target**: $Z
- **Stop Loss**: $W
- **Risk-Reward**: N:1
- **Conviction**: 1-5
- **Catalysts**: [list]
- **Risk Factors**: [list]
- **Source**: sector-researcher
```

## Entries

<!-- Entries added by sector-researcher, consumed by aggregator -->

*Queue is empty. Waiting for sector-researcher to add entries.*
