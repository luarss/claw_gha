#!/usr/bin/env python3
"""
Live Stock Price Fetcher (financialdata.net backup provider)
Uses financialdata.net API for delayed stock quotes

Usage:
    python fetch_quote_fd.py AAPL
    python fetch_quote_fd.py AAPL MSFT GOOGL

Setup:
    export FINANCIALDATA_API_KEY=your_api_key_here

Note:
    Free tier provides delayed data (~15 min delay)
    For real-time data, use fetch_quote.py (Finnhub)
"""

import os
import sys
import requests
from datetime import datetime, timezone

# Configuration
API_KEY = os.environ.get('FINANCIALDATA_API_KEY')
BASE_URL = 'https://api.financialdata.net/api/v0'

def check_api_key():
    """Verify API key is configured."""
    if not API_KEY:
        print('❌ Error: FINANCIALDATA_API_KEY not set in environment')
        print('   Get your free key at: https://financialdata.net')
        print('   Then export: export FINANCIALDATA_API_KEY=your_key_here')
        sys.exit(1)

def get_quote(symbol):
    """
    Fetch delayed quote for a symbol from financialdata.net.

    Returns:
        dict: Quote data with success status
    """
    url = f'{BASE_URL}/intraday/{symbol.upper()}?token={API_KEY}'

    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        data = response.json()

        # Check for API error
        if 'error' in data:
            return {
                'symbol': symbol.upper(),
                'error': data['error'],
                'success': False
            }

        # Parse timestamp
        timestamp_str = data.get('timestamp')
        if timestamp_str:
            timestamp = datetime.fromisoformat(timestamp_str.replace('Z', '+00:00'))
        else:
            timestamp = datetime.now(timezone.utc)

        return {
            'symbol': data.get('symbol', symbol.upper()),
            'price': data.get('price'),
            'change': data.get('change'),
            'change_percent': data.get('changePercent'),
            'high': data.get('high'),
            'low': data.get('low'),
            'open': data.get('open'),
            'previous_close': data.get('previousClose'),
            'timestamp': timestamp,
            'source': 'financialdata.net (delayed)',
            'success': True
        }

    except requests.exceptions.HTTPError as e:
        if e.response.status_code == 401:
            error_msg = 'Invalid API key'
        elif e.response.status_code == 429:
            error_msg = 'Rate limit exceeded (300 calls/day)'
        elif e.response.status_code == 404:
            error_msg = 'Symbol not found'
        else:
            error_msg = f'API error: {e.response.status_code}'

        return {
            'symbol': symbol.upper(),
            'error': error_msg,
            'success': False
        }

    except requests.exceptions.RequestException as e:
        return {
            'symbol': symbol.upper(),
            'error': f'Network error: {str(e)}',
            'success': False
        }

    except (KeyError, ValueError) as e:
        return {
            'symbol': symbol.upper(),
            'error': f'Parse error: {str(e)}',
            'success': False
        }

def check_freshness(quote, max_age_minutes=15):
    """
    Check if quote data is fresh.

    Returns:
        dict: Freshness status and age in minutes
    """
    if not quote['success']:
        return {'status': 'ERROR', 'age_minutes': None, 'is_delayed': True}

    now = datetime.now(timezone.utc)
    quote_time = quote['timestamp']
    age = now - quote_time
    age_minutes = age.total_seconds() / 60

    if age_minutes > 1440:  # > 24 hours
        status = 'STALE'
    elif age_minutes > max_age_minutes:
        status = 'DELAYED'
    else:
        status = 'PASS'

    return {
        'status': status,
        'age_minutes': round(age_minutes, 1),
        'is_delayed': age_minutes > 15
    }

def format_quote(quote):
    """Format quote for display."""
    if not quote['success']:
        return f"❌ {quote['symbol']}: {quote['error']}"

    change_sign = '+' if quote['change'] >= 0 else ''
    emoji = '📈' if quote['change'] >= 0 else '📉'
    freshness = check_freshness(quote)

    return f"""
### {quote['symbol']} — {datetime.now(timezone.utc).strftime('%Y-%m-%d')}
- **Price:** ${quote['price']:.2f}
- **Change:** {change_sign}${quote['change']:.2f} ({change_sign}{quote['change_percent']:.2f}%) {emoji}
- **Day Range:** ${quote['low']:.2f} - ${quote['high']:.2f}
- **Open:** ${quote['open']:.2f} | **Prev Close:** ${quote['previous_close']:.2f}
- **Timestamp:** {quote['timestamp'].isoformat()}
- **Source:** {quote['source']}
- **Data Age:** {freshness['age_minutes']} min (delayed ~15 min on free tier)
""".strip()

def main():
    """Main entry point."""
    check_api_key()

    symbols = sys.argv[1:]

    if not symbols:
        print('Usage: python fetch_quote_fd.py <SYMBOL> [SYMBOL2] ...')
        print('Example: python fetch_quote_fd.py AAPL MSFT GOOGL')
        print('\nNote: financialdata.net free tier provides delayed data (~15 min)')
        print('For real-time data, use fetch_quote.py (Finnhub) or upgrade to Premium.')
        print('\nMake sure FINANCIALDATA_API_KEY is set in your environment.')
        sys.exit(0)

    print(f'Fetching quotes for {len(symbols)} symbol(s) from financialdata.net...\n')
    print('⚠️  Note: Free tier provides delayed data (~15 min)\n')

    # Fetch all quotes
    results = []
    for i, symbol in enumerate(symbols):
        quote = get_quote(symbol)
        results.append(quote)

        # Add small delay between requests (respect rate limits)
        if i < len(symbols) - 1:
            import time
            time.sleep(1)

    # Display results
    print('=' * 60)
    for quote in results:
        print(format_quote(quote))
        print('=' * 60)

    # Summary
    success_count = sum(1 for r in results if r['success'])
    print(f'\n✅ Successfully fetched: {success_count}/{len(results)}')
    print('📊 Data source: financialdata.net (delayed)')

    # Exit with error if any failed
    if success_count < len(results):
        sys.exit(1)

if __name__ == '__main__':
    main()