#!/usr/bin/env python3
"""
Live Stock Price Fetcher (Python Version)
Uses Finnhub API for real-time stock quotes

Usage:
    python fetch_quote.py AAPL
    python fetch_quote.py AAPL MSFT GOOGL

Setup:
    export FINNHUB_API_KEY=your_api_key_here
"""

import os
import sys
import requests
from datetime import datetime, timezone

# Configuration
API_KEY = os.environ.get('FINNHUB_API_KEY')
BASE_URL = 'https://finnhub.io/api/v1'

def check_api_key():
    """Verify API key is configured."""
    if not API_KEY:
        print('❌ Error: FINNHUB_API_KEY not set in environment')
        print('   Get your free key at: https://finnhub.io')
        print('   Then export: export FINNHUB_API_KEY=your_key_here')
        sys.exit(1)

def get_quote(symbol):
    """
    Fetch real-time quote for a symbol.
    
    Returns:
        dict: Quote data with success status
    """
    url = f'{BASE_URL}/quote?symbol={symbol.upper()}&token={API_KEY}'
    
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
        
        # Check for null data (invalid symbol or market closed)
        if data.get('c') is None:
            return {
                'symbol': symbol.upper(),
                'error': 'Symbol not found or market closed',
                'success': False
            }
        
        return {
            'symbol': symbol.upper(),
            'price': data['c'],
            'change': data['d'],
            'change_percent': data['dp'],
            'high': data['h'],
            'low': data['l'],
            'open': data['o'],
            'previous_close': data['pc'],
            'timestamp': datetime.fromtimestamp(data['t'], tz=timezone.utc),
            'success': True
        }
        
    except requests.exceptions.HTTPError as e:
        if e.response.status_code == 401:
            error_msg = 'Invalid API key'
        elif e.response.status_code == 429:
            error_msg = 'Rate limit exceeded (60 calls/min)'
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

def check_freshness(quote, max_age_minutes=15):
    """
    Check if quote data is fresh.
    
    Returns:
        dict: Freshness status and age in minutes
    """
    if not quote['success']:
        return {'status': 'ERROR', 'age_minutes': None}
    
    now = datetime.now(timezone.utc)
    quote_time = quote['timestamp']
    age = now - quote_time
    age_minutes = age.total_seconds() / 60
    
    if age_minutes > 1440:  # > 24 hours
        status = 'STALE'
    elif age_minutes > max_age_minutes:
        status = 'RETRY'
    else:
        status = 'PASS'
    
    return {
        'status': status,
        'age_minutes': round(age_minutes, 1)
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
- **Freshness:** {freshness['status']} ({freshness['age_minutes']} min old)
""".strip()

def main():
    """Main entry point."""
    check_api_key()
    
    symbols = sys.argv[1:]
    
    if not symbols:
        print('Usage: python fetch_quote.py <SYMBOL> [SYMBOL2] ...')
        print('Example: python fetch_quote.py AAPL MSFT GOOGL')
        print('\nMake sure FINNHUB_API_KEY is set in your environment.')
        sys.exit(0)
    
    print(f'Fetching quotes for {len(symbols)} symbol(s)...\n')
    
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
    
    # Exit with error if any failed
    if success_count < len(results):
        sys.exit(1)

if __name__ == '__main__':
    main()
