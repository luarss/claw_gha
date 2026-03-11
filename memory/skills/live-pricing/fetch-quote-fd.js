#!/usr/bin/env node
/**
 * Live Stock Price Fetcher (financialdata.net backup provider)
 * Uses financialdata.net API for delayed stock quotes
 *
 * Usage:
 *   node fetch-quote-fd.js AAPL
 *   node fetch-quote-fd.js AAPL MSFT GOOGL
 *
 * Environment:
 *   FINANCIALDATA_API_KEY - Your API key from financialdata.net
 */

const API_KEY = process.env.FINANCIALDATA_API_KEY;
const BASE_URL = 'https://api.financialdata.net/api/v0';

// Check API key
if (!API_KEY) {
  console.error('❌ Error: FINANCIALDATA_API_KEY not set in environment');
  console.error('   Get your free key at: https://financialdata.net');
  console.error('   Then export: export FINANCIALDATA_API_KEY=your_key_here');
  process.exit(1);
}

/**
 * Fetch quote for a single symbol from financialdata.net
 */
async function getQuote(symbol) {
  const url = `${BASE_URL}/intraday/${symbol.toUpperCase()}?token=${API_KEY}`;

  try {
    const response = await fetch(url);

    if (response.status === 401) {
      throw new Error('Invalid API key');
    }
    if (response.status === 429) {
      throw new Error('Rate limit exceeded (300 calls/day)');
    }
    if (response.status === 404) {
      throw new Error('Symbol not found');
    }
    if (!response.ok) {
      throw new Error(`API error: ${response.status}`);
    }

    const data = await response.json();

    // Check for API error response
    if (data.error) {
      throw new Error(data.error);
    }

    // Parse timestamp
    const timestamp = data.timestamp ? new Date(data.timestamp) : new Date();

    return {
      symbol: data.symbol || symbol.toUpperCase(),
      price: data.price,
      change: data.change,
      changePercent: data.changePercent,
      high: data.high,
      low: data.low,
      open: data.open,
      previousClose: data.previousClose,
      timestamp: timestamp,
      source: 'financialdata.net (delayed)',
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
 * Check if quote data is delayed (financialdata.net free tier has ~15 min delay)
 */
function checkFreshness(quote, maxAgeMinutes = 15) {
  if (!quote.success) return { status: 'ERROR', ageMinutes: null, isDelayed: true };

  const now = new Date();
  const quoteTime = quote.timestamp;
  const ageMinutes = (now - quoteTime) / (1000 * 60);

  let status;
  if (ageMinutes > 1440) { // > 24 hours
    status = 'STALE';
  } else if (ageMinutes > maxAgeMinutes) {
    status = 'DELAYED';
  } else {
    status = 'PASS';
  }

  return {
    status,
    ageMinutes: Math.round(ageMinutes * 10) / 10,
    isDelayed: ageMinutes > 15
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
- **Source:** ${quote.source}
- **Data Age:** ${freshness.ageMinutes} min (delayed ~15 min on free tier)
`.trim();
}

/**
 * Main execution
 */
async function main() {
  const symbols = process.argv.slice(2);

  if (symbols.length === 0) {
    console.log('Usage: node fetch-quote-fd.js <SYMBOL> [SYMBOL2] ...');
    console.log('Example: node fetch-quote-fd.js AAPL MSFT GOOGL');
    console.log('\nNote: financialdata.net free tier provides delayed data (~15 min)');
    console.log('For real-time data, use fetch-quote.js (Finnhub) or upgrade to Premium.');
    console.log('\nMake sure FINANCIALDATA_API_KEY is set in your environment.');
    process.exit(0);
  }

  console.log(`Fetching quotes for ${symbols.length} symbol(s) from financialdata.net...\n`);
  console.log('⚠️  Note: Free tier provides delayed data (~15 min)\n');

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
  console.log('📊 Data source: financialdata.net (delayed)');

  // Exit with error if any failed
  if (successCount < results.length) {
    process.exit(1);
  }
}

main();