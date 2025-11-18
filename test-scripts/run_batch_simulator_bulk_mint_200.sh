#!/bin/bash

# Configuration for load test
# You can uncomment and use different RPC URLs as needed

# RPC URL options
RPC_URL="http://localhost:26657"

# Simulation data (encoded transaction data)
# {
#     "type": "/vm.m_call",
#     "value": {
#       "caller": "g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5",
#       "send": "",
#       "pkg_path": "gno.land/r/g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5/tnft",
#       "func": "BulkMint",
#       "args": ["g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5", "200"]
#     }
# }
PARAM_SIMULATE_DATA="CqwBCgovdm0ubV9jYWxsEp0BCihnMWpnOG10dXR1OWtoaGZ3YzRueG11aGNwZnRmMHBhamRoZnZzcWY1Ijhnbm8ubGFuZC9yL2cxamc4bXR1dHU5a2hoZndjNG54bXVoY3BmdGYwcGFqZGhmdnNxZjUvdG5mdCoIQnVsa01pbnQyKGcxamc4bXR1dHU5a2hoZndjNG54bXVoY3BmdGYwcGFqZGhmdnNxZjUyAzIwMBIUCIDQrPMOEgwyMDAwMDAwdWdub3Qafgo6ChMvdG0uUHViS2V5U2VjcDI1NmsxEiMKIQPhYTbbFx4y30iZNZQfBW4i+Jhj43OdCrfNSexCg5ydshJATc7BE8/ScwKrVMC6a4Q3eGQczkXyFChrmkq+ghBb4nwti+4NWJlnU5BpUKWWrDH8MG0QrQT14rElEGEf48NIWA=="

# Number of concurrent requests (optional, defaults to 50 if not specified)
CONCURRENT_REQUESTS=50

# Check if batch_simulate_runner.sh exists
if [ ! -f "./batch_simulate_runner.sh" ]; then
    echo "Error: batch_simulate_runner.sh not found in current directory"
    echo "Please ensure batch_simulate_runner.sh is in the same directory as this script"
    exit 1
fi

# Make sure batch_simulate_runner.sh is executable
chmod +x ./batch_simulate_runner.sh

echo "=================================================="
echo "     STARTING BATCH SIMULATOR BULK MINT 200      "
echo "=================================================="
echo ""
echo "Configuration:"
echo "  - RPC URL: ${RPC_URL}"
echo "  - Concurrent Requests: ${CONCURRENT_REQUESTS}"
echo "  - Simulation Data: Bulk Mint 200"
echo ""
echo "=================================================="
echo ""

# Execute the load test runner with parameters
./batch_simulate_runner.sh "$RPC_URL" "$PARAM_SIMULATE_DATA" "$CONCURRENT_REQUESTS"
