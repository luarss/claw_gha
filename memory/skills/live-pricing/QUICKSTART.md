# Live Pricing Quick Start

Get real-time stock data in 3 steps.

---

## 1️⃣ Get API Key (2 minutes)

Visit [https://finnhub.io](https://finnhub.io) → Sign Up → Dashboard → Copy API Key

**No credit card required.** Free tier: 60 calls/min.

---

## 2️⃣ Set Environment Variable

```bash
export FINNHUB_API_KEY=your_key_here
```

**Permanent setup:** Add to `~/.bashrc` or `~/.zshrc`

---

## 3️⃣ Test It

```bash
# Shell script
./skills/live-pricing/fetch-quote.sh AAPL

# Node.js
node skills/live-pricing/fetch-quote.js AAPL MSFT GOOGL

# Python
python skills/live-pricing/fetch_quote.py AAPL
```

---

## Example Output

```
============================================================
### AAPL — 2026-03-11
- **Price:** $175.50
- **Change:** +$2.30 (+1.33%) 📈
- **Day Range:** $173.20 - $176.00
- **Open:** $173.50 | **Prev Close:** $173.20
- **Timestamp:** 2026-03-11T01:30:00Z
- **Freshness:** PASS (1 min old)
============================================================

✅ Successfully fetched: 1/1
```

---

## Integration in Stock Analysis

### Phase 0: Data Freshness Check

Before any stock analysis, run:

```bash
./skills/live-pricing/fetch-quote.sh $SYMBOL
```

Verify:
- ✅ Price is current (< 15 min old)
- ✅ Market is open (or note if after-hours)
- ✅ No API errors

Then proceed with fundamental analysis.

---

## Watch List Quick Fetch

Fetch your entire watch list in one command:

```bash
./skills/live-pricing/fetch-quote.sh GOOGL AMZN MSFT JPM NVDA AAPL
```

Output formats nicely for copy-paste into analysis notes.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "API key not set" | Run `export FINNHUB_API_KEY=...` |
| "Invalid API key" | Double-check key, no extra spaces |
| "Rate limit" | Wait 60 seconds, reduce call frequency |
| "Symbol not found" | Verify ticker is correct (use uppercase) |

---

## Next Steps

- Read `SETUP.md` for detailed configuration
- Read `API.md` for full API reference
- Read `EXAMPLES.md` for integration patterns
- Update `TOOLS.md` with your API key location

---

**📌 Pro Tip:** Create an alias for quick access:

```bash
# Add to ~/.bashrc
alias stockprice='./skills/live-pricing/fetch-quote.sh'

# Then use:
stockprice AAPL
```
