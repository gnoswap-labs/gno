#!/bin/bash

# Check if required arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <rpc_url> <param_simulate_data> [concurrent_requests]"
    echo ""
    echo "Arguments:"
    echo "  rpc_url            - The RPC endpoint URL (e.g., http://localhost:26657)"
    echo "  param_simulate_data - The base64 encoded simulation data"
    echo "  concurrent_requests - (Optional) Number of concurrent requests (default: 50)"
    echo ""
    echo "Example:"
    echo "  $0 http://localhost:26657 'CqwBCgovdm0ubV9jYWxsEp0B...'"
    exit 1
fi

# Parse arguments
RPC_URL="$1"
PARAM_SIMULATE_DATA="$2"
CONCURRENT_REQUESTS="${3:-50}"  # Default to 50 if not provided

# Test result file
TEST_RESULT_FILE="test_results_$(date '+%Y%m%d_%H%M%S').txt"
TEMP_DIR="temp_responses"

# Create temp directory for individual responses
mkdir -p "$TEMP_DIR"

# Function to execute a single curl request
execute_curl() {
    local request_num=$1
    local temp_file="${TEMP_DIR}/response_${request_num}.txt"
    local data='{"id":"'$request_num'","jsonrpc":"2.0","method":"abci_query","params":[".app/simulate","'${PARAM_SIMULATE_DATA}'","0",false]}'
    
    # Record start time
    start_time=$(date +%s.%N)
    
    # Execute curl and capture response with status code
    response=$(curl "$RPC_URL" \
        -w "\n==CURL_INFO==\nHTTP_CODE:%{http_code}\nTIME_TOTAL:%{time_total}\nTIME_NAMELOOKUP:%{time_namelookup}\nTIME_CONNECT:%{time_connect}\nTIME_APPCONNECT:%{time_appconnect}\nTIME_PRETRANSFER:%{time_pretransfer}\nTIME_REDIRECT:%{time_redirect}\nTIME_STARTTRANSFER:%{time_starttransfer}\nSIZE_DOWNLOAD:%{size_download}\nSPEED_DOWNLOAD:%{speed_download}\n" \
        -H 'accept: application/json, text/plain, */*' \
        -H 'cache-control: no-cache' \
        -H 'content-type: application/json' \
        -H 'pragma: no-cache' \
        -H 'priority: u=1, i' \
        --data-raw "$data" \
        -s 2>&1)
    
    # Record end time
    end_time=$(date +%s.%N)
    
    # Save response to temp file
    echo "$response" > "$temp_file"
    
    # Extract metrics
    http_code=$(echo "$response" | grep "HTTP_CODE:" | cut -d':' -f2)
    time_total=$(echo "$response" | grep "TIME_TOTAL:" | cut -d':' -f2)
    
    # Display progress
    echo "Request #${request_num} completed - HTTP: ${http_code} - Time: ${time_total}s"
}

# Initialize test result file
{
    echo "=================================================="
    echo "        BATCH SIMULATOR RESULTS SUMMARY           "
    echo "=================================================="
    echo ""
    echo "Test Configuration:"
    echo "  - Target URL: ${RPC_URL}"
    echo "  - Concurrent Requests: ${CONCURRENT_REQUESTS}"
    echo "  - Test Start Time: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
} > "$TEST_RESULT_FILE"

echo "Starting ${CONCURRENT_REQUESTS} concurrent requests..."
echo "Target URL: ${RPC_URL}"
echo "Results will be saved to: ${TEST_RESULT_FILE}"
echo ""

# Record overall start time
overall_start=$(date +%s.%N)

# Launch all requests in background
for i in $(seq 1 $CONCURRENT_REQUESTS); do
    execute_curl $i &
done

# Wait for all background jobs to complete
wait

# Record overall end time
overall_end=$(date +%s.%N)
overall_duration=$(echo "$overall_end - $overall_start" | bc)

echo ""
echo "All requests completed!"
echo "Processing results..."

# Process results and generate summary
{
    echo "Test End Time: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Total Test Duration: ${overall_duration}s"
    
    # Variables for statistics
    total_time=0
    min_time=999999
    max_time=0
    success_count=0
    fail_count=0
    
    # Process each response file for statistics
    for i in $(seq 1 $CONCURRENT_REQUESTS); do
        temp_file="${TEMP_DIR}/response_${i}.txt"
        if [ -f "$temp_file" ]; then
            # Extract all metrics
            http_code=$(grep "HTTP_CODE:" "$temp_file" | cut -d':' -f2)
            time_total=$(grep "TIME_TOTAL:" "$temp_file" | cut -d':' -f2)
            time_namelookup=$(grep "TIME_NAMELOOKUP:" "$temp_file" | cut -d':' -f2)
            time_connect=$(grep "TIME_CONNECT:" "$temp_file" | cut -d':' -f2)
            time_appconnect=$(grep "TIME_APPCONNECT:" "$temp_file" | cut -d':' -f2)
            time_pretransfer=$(grep "TIME_PRETRANSFER:" "$temp_file" | cut -d':' -f2)
            time_starttransfer=$(grep "TIME_STARTTRANSFER:" "$temp_file" | cut -d':' -f2)
            size_download=$(grep "SIZE_DOWNLOAD:" "$temp_file" | cut -d':' -f2)
            speed_download=$(grep "SPEED_DOWNLOAD:" "$temp_file" | cut -d':' -f2)
                        
            # Update statistics
            if [ "$http_code" = "200" ]; then
                success_count=$((success_count + 1))
            else
                fail_count=$((fail_count + 1))
            fi
            
            # Calculate min/max/total using bc
            if command -v bc &> /dev/null; then
                total_time=$(echo "$total_time + $time_total" | bc)
                if (( $(echo "$time_total < $min_time" | bc -l) )); then
                    min_time=$time_total
                fi
                if (( $(echo "$time_total > $max_time" | bc -l) )); then
                    max_time=$time_total
                fi
            fi
        fi
    done
    
    echo ""
    echo "=================================================="
    echo "                   STATISTICS                     "
    echo "=================================================="
    echo ""
    echo "Response Summary:"
    echo "  - Successful Requests (200): ${success_count}"
    echo "  - Failed Requests: ${fail_count}"
    echo "  - Total Requests: ${CONCURRENT_REQUESTS}"
    echo "  - Success Rate: $(echo "scale=2; $success_count * 100 / $CONCURRENT_REQUESTS" | bc)%"
    echo ""
    
    if command -v bc &> /dev/null && [ $CONCURRENT_REQUESTS -gt 0 ]; then
        average_time=$(echo "scale=3; $total_time / $CONCURRENT_REQUESTS" | bc)
        echo "Response Time Statistics:"
        echo "  - Min Response Time: ${min_time}s"
        echo "  - Max Response Time: ${max_time}s"
        echo "  - Average Response Time: ${average_time}s"
        echo ""
        
        # Calculate requests per second
        rps=$(echo "scale=2; $CONCURRENT_REQUESTS / $overall_duration" | bc)
        echo "Performance Metrics:"
        echo "  - Requests per Second: ${rps}"
        echo "  - Total Test Duration: ${overall_duration}s"
    fi
    
    echo ""
    echo "=================================================="
    echo "                  TEST COMPLETED                  "
    echo "=================================================="
    
} >> "$TEST_RESULT_FILE"

# Display summary on console
echo ""
echo "Test Summary:"
echo "-------------"
grep -A 20 "STATISTICS" "$TEST_RESULT_FILE" | tail -n +2

# Clean up temp directory
rm -rf "$TEMP_DIR"

echo ""
echo "Full test results saved to: ${TEST_RESULT_FILE}"
echo ""
