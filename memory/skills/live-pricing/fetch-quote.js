#!/usr/bin/env node
/**
 * Live Stock Price Fetcher
 * Uses Finnhub API for real-time stock quotes
 * 
 * Usage:
 *   node fetch-quote.js AAPL
 *   node fetch-quote.js AAPL MSFT GOOGL
 */

const API_KEY = process.env.FINNHUB_API_KEY;
const BASE_URL = 'https://finnhub.io/api/v1';

// Check API key
if (!API_KEY) {
  console.error('❌ Error: FINNHUB_API_KEY not set in environment');
  console.error('   Get your free key at: https://finnhub.io');
  console.error('   Then export: export FINNHUB_API_KEY=your_key_here');
  process.exit(1);
}

/**
 * Fetch quote for a single symbol
 */
async function getQuote(symbol) {
  const url = `${BASE_URL}/quote?symbol=${symbol.toUpperCase()}&token=${API_KEY}`;
  
  try {
    const response = await fetch(url);
    
    if (response.status === 401) {
      throw new Error('Invalid API key');
    }
    if (response.status === 429) {
      throw new Error('Rate limit exceeded (60 calls/min)');
    }
    if (!response.ok) {
      throw new Error(`API error: ${response.status}`);
    }
    
    const data = await response.json();
    
    // Check for API error response
    if (data.error) {
      throw new Error(data.error);
    }
    
    return {
      symbol: symbol.toUpperCase(),
      price: data.c,
      change: data.d,
      changePercent: data.dp,
      high: data.h,
      low: data.l,
      open: data.o,
      previousClose: data.pc,
      timestamp: new Date(data.t * 1000),
      success: true
    };
  } catch (error) {
    return {
      symbol: symbol.toUpperCase(),
      error: error.message,
      success: false
    };
  }
}

/**
 * Check if quote data is fresh
 */
function checkFreshness(quote, maxAgeMinutes = 15) {
  if (!quote.success) return { status: 'ERROR', ageMinutes: null };
  
  const now = new Date();
  const quoteTime = quote.timestamp;
  const ageMinutes = (now - quoteTime) / (1000 * 60);
  
  let status;
  if (ageMinutes > 1440) { // > 24 hours
    status = 'STALE';
  } else if (ageMinutes > maxAgeMinutes) {
    status = 'RETRY';
  } else {
    status = 'PASS';
  }
  
  return {
    status,
    ageMinutes: Math.round(ageMinutes * 10) / 10
  };
}

/**
 * Format quote for display
 */
function formatQuote(quote) {
  if (!quote.success) {
    return `❌ ${quote.symbol}: ${quote.error}`;
  }
  
  const changeSign = quote.change >= 0 ? '+' : '';
  const color = quote.change >= 0 ? '📈' : '📉';
  const freshness = checkFreshness(quote);
  
  return `
### ${quote.symbol} — ${new Date().toISOString().split('T')[0]}
- **Price:** $${quote.price.toFixed(2)}
- **Change:** ${changeSign}$${quote.change.toFixed(2)} (${changeSign}${quote.changePercent.toFixed(2)}%) ${color}
- **Day Range:** $${quote.low.toFixed(2)} - $${quote.high.toFixed(2)}
- **Open:** $${quote.open.toFixed(2)} | **Prev Close:** $${quote.previousClose.toFixed(2)}
- **Timestamp:** ${quote.timestamp.toISOString()}
- **Freshness:** ${freshness.status} (${freshness.ageMinutes} min old)
`.trim();
}

/**
 * Main execution
 */
async function main() {
  const symbols = process.argv.slice(2);
  
  if (symbols.length === 0) {
    console.log('Usage: node fetch-quote.js <SYMBOL> [SYMBOL2] ...');
    console.log('Example: node fetch-quote.js AAPL MSFT GOOGL');
    console.log('\nMake sure FINNHUB_API_KEY is set in your environment.');
    process.exit(0);
  }
  
  console.log(`Fetching quotes for ${symbols.length} symbol(s)...\n`);
  
  // Fetch all quotes (with slight delay to respect rate limits)
  const results = [];
  for (let i = 0; i < symbols.length; i++) {
    const quote = await getQuote(symbols[i]);
    results.push(quote);
    
    // Add small delay between requests (except for last one)
    if (i < symbols.length - 1) {
      await new Promise(r => setTimeout(r, 1000));
    }
  }
  
  // Display results
  console.log('='.repeat(60));
  results.forEach(quote => {
    console.log(formatQuote(quote));
    console.log('='.repeat(60));
  });
  
  // Summary
  const successCount = results.filter(r => r.success).length;
  console.log(`\n✅ Successfully fetched: ${successCount}/${results.length}`);
  
  // Exit with error if any failed
  if (successCount < results.length) {
    process.exit(1);
  }
}

main();
