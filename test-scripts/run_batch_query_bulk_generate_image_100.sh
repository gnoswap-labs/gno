#!/bin/bash

# Configuration for load test
# You can uncomment and use different RPC URLs as needed

# RPC URL options
RPC_URL="http://localhost:26657"

# Query data (encoded transaction data)
# gno.land/r/g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5/tnft.BulkGenerateTokenURI(100)
PARAM_SIMULATE_DATA="Z25vLmxhbmQvci9nMWpnOG10dXR1OWtoaGZ3YzRueG11aGNwZnRmMHBhamRoZnZzcWY1L3RuZnQuQnVsa0dlbmVyYXRlVG9rZW5VUkkoMTAwKQ=="

# Number of concurrent requests (optional, defaults to 50 if not specified)
CONCURRENT_REQUESTS=50

# Check if batch_query_runner.sh exists
if [ ! -f "./batch_query_runner.sh" ]; then
    echo "Error: batch_query_runner.sh not found in current directory"
    echo "Please ensure batch_query_runner.sh is in the same directory as this script"
    exit 1
fi

# Make sure batch_query_runner.sh is executable
chmod +x ./batch_query_runner.sh

echo "==================================================="
echo " STARTING BATCH QUERY BULK GENERATE TOKEN URI 100  "
echo "==================================================="
echo ""
echo "Configuration:"
echo "  - RPC URL: ${RPC_URL}"
echo "  - Concurrent Requests: ${CONCURRENT_REQUESTS}"
echo "  - Query Data: Bulk Generate Token URI 100"
echo ""
echo "=================================================="
echo ""

# Execute the load test runner with parameters
./batch_query_runner.sh "$RPC_URL" "$PARAM_SIMULATE_DATA" "$CONCURRENT_REQUESTS"
