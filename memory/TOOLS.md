# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- API keys and configuration
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

## API Configuration

### Finnhub (Live Stock Prices)
- **Purpose:** Real-time stock quotes for analysis
- **Free Tier:** 60 calls/min, 60K/month
- **Key Location:** Environment variable `FINNHUB_API_KEY`
- **Setup:** See `skills/live-pricing/SETUP.md`
- **Scripts:**
  - `skills/live-pricing/fetch-quote.js` (Node.js)
  - `skills/live-pricing/fetch-quote.sh` (Shell)
  - `skills/live-pricing/fetch_quote.py` (Python)
- **Usage:** `./skills/live-pricing/fetch-quote.sh AAPL MSFT`

---

Add whatever helps you do your job. This is your cheat sheet.
