#!/bin/bash
#
# Generate a summary report from commit history.
#
# Usage:
#   ./generate_summary_report.sh [--force] [--output <file>]
#
# Options:
#   --force, -f        Force regenerate all reports and comparisons (make compare-metric-force)
#                      Default: Reuse existing reports, generate comparisons only (make compare-metric)
#   --output, -o       Output file path (default: SUMMARY.md)
#   --help, -h         Show this help message
#
# Prerequisites:
#   commit-history.txt file with format: {commit}:{description}
#   Each line represents a commit from oldest to newest.
#

set -e

# Configuration
HISTORY_FILE="commit-history.txt"
OUTPUT_FILE="SUMMARY.md"
FORCE_REGENERATE=false
REPORTS_DIR="reports/metric"
COMMITS_DIR="$REPORTS_DIR/commits"
COMPARES_DIR="$REPORTS_DIR/compares"
GITHUB_BASE_URL="https://github.com/gnoswap-labs/gnoswap/tree"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --force|-f)
            FORCE_REGENERATE=true
            shift
            ;;
        --output|-o)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [--force] [--output <file>]"
            echo ""
            echo "Options:"
            echo "  --force, -f        Force regenerate all reports and comparisons (make compare-metric-force)"
            echo "                     Default: Reuse existing reports, generate comparisons only (make compare-metric)"
            echo "  --output, -o       Output file path (default: SUMMARY.md)"
            echo "  --help, -h         Show this help message"
            echo ""
            echo "Prerequisites:"
            echo "  commit-history.txt file with format: {commit}:{description}"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check if commit history file exists
if [[ ! -f "$HISTORY_FILE" ]]; then
    echo "Error: $HISTORY_FILE not found"
    echo "Please create a commit history file with format: {commit}:{description}"
    exit 1
fi

# Read commits from history file (oldest to newest)
declare -a COMMITS=()
declare -a DESCRIPTIONS=()
declare -a SHORT_COMMITS=()

echo "Reading commit history from $HISTORY_FILE..."
while IFS=':' read -r commit description || [[ -n "$commit" ]]; do
    # Skip empty lines and comments
    [[ -z "$commit" || "$commit" =~ ^# ]] && continue
    
    # Trim whitespace
    commit=$(echo "$commit" | xargs)
    description=$(echo "$description" | xargs)
    
    if [[ -n "$commit" ]]; then
        COMMITS+=("$commit")
        DESCRIPTIONS+=("${description:-No description}")
        SHORT_COMMITS+=("${commit:0:7}")
    fi
done < "$HISTORY_FILE"

COMMIT_COUNT=${#COMMITS[@]}

if [[ $COMMIT_COUNT -lt 1 ]]; then
    echo "Error: At least 1 commit is required in $HISTORY_FILE"
    exit 1
fi

echo "Found $COMMIT_COUNT commits"

# Reverse commits for make compare-with-report (newest first)
declare -a REVERSED_COMMITS=()
for ((i = COMMIT_COUNT - 1; i >= 0; i--)); do
    REVERSED_COMMITS+=("${COMMITS[$i]}")
done

echo ""
echo "=========================================="
if [[ $COMMIT_COUNT -eq 1 ]]; then
    echo "Single commit detected; generating baseline report only..."
    echo "=========================================="

    single_commit="${REVERSED_COMMITS[0]}"
    single_short="${single_commit:0:7}"
    report_file="$COMMITS_DIR/${single_short}.md"

    if [[ "$FORCE_REGENERATE" = true || ! -f "$report_file" ]]; then
        CMD="make gas-report $single_commit"
        echo "Executing: $CMD"
        echo ""
        eval "$CMD"
    else
        echo "Reusing existing baseline report: $report_file"
    fi
else
    if [[ "$FORCE_REGENERATE" = true ]]; then
        echo "Force regenerating all reports and comparisons..."
        echo "=========================================="

        CMD="make compare-metric-force ${REVERSED_COMMITS[*]}"
        echo "Executing: $CMD"
        echo ""
        eval "$CMD"
    else
        echo "Generating comparisons (reusing existing reports)..."
        echo "=========================================="

        CMD="make compare-metric ${REVERSED_COMMITS[*]}"
        echo "Executing: $CMD"
        echo ""
        eval "$CMD"
    fi
fi

# Generate summary report
echo ""
echo "=========================================="
echo "Generating summary report..."
echo "=========================================="

mkdir -p "$(dirname "$OUTPUT_FILE")"

# Get current date
REPORT_DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Calculate first and last commits
FIRST_COMMIT="${COMMITS[0]}"
FIRST_SHORT="${SHORT_COMMITS[0]}"
FIRST_DESC="${DESCRIPTIONS[0]}"

LAST_COMMIT="${COMMITS[$((COMMIT_COUNT - 1))]}"
LAST_SHORT="${SHORT_COMMITS[$((COMMIT_COUNT - 1))]}"
LAST_DESC="${DESCRIPTIONS[$((COMMIT_COUNT - 1))]}"

# Start writing the summary report
cat > "$OUTPUT_FILE" << EOF
# GnoSwap Performance Summary Report

> Generated: $REPORT_DATE

## Overview

- **Total Commits**: $COMMIT_COUNT
- **First Commit (Oldest)**: [\`$FIRST_SHORT\`]($GITHUB_BASE_URL/$FIRST_SHORT) - $FIRST_DESC
- **Last Commit (Latest)**: [\`$LAST_SHORT\`]($GITHUB_BASE_URL/$LAST_SHORT) - $LAST_DESC

---

## Commit History

| # | Commit | Description | Report | Diff from Previous | Diff from Base |
|---|--------|-------------|--------|-------------------|----------------|
EOF

# Write commit history table (from oldest to newest, same order as commit-history.txt)
for ((i = 0; i < COMMIT_COUNT; i++)); do
    commit="${COMMITS[$i]}"
    short="${SHORT_COMMITS[$i]}"
    desc="${DESCRIPTIONS[$i]}"
    
    # Report link
    report_file="$COMMITS_DIR/${short}.md"
    if [[ -f "$report_file" ]]; then
        report_link="[📊 Report](reports/metric/commits/${short}.md)"
    else
        report_link="_Not generated_"
    fi

    # Diff link (compare with previous commit)
    # Note: diff files are named as diff_{current}_{prev}.md because make compare runs in reverse order
    if [[ $i -gt 0 ]]; then
        prev_short="${SHORT_COMMITS[$((i - 1))]}"
        diff_file="$COMPARES_DIR/diff_${short}_${prev_short}.md"
        if [[ -f "$diff_file" ]]; then
            diff_link="[📈 Diff](reports/metric/compares/diff_${short}_${prev_short}.md)"
        else
            diff_link="_Not generated_"
        fi
    else
        diff_link="_Baseline_"
    fi

    # Diff from Base link (compare with first commit)
    # Note: diff files are named as diff_{current}_{first}.md because make compare runs in reverse order
    if [[ $i -gt 0 ]]; then
        base_diff_file="$COMPARES_DIR/diff_${short}_${FIRST_SHORT}.md"
        if [[ -f "$base_diff_file" ]]; then
            base_diff_link="[📊 Diff](reports/metric/compares/diff_${short}_${FIRST_SHORT}.md)"
        else
            base_diff_link="_Not generated_"
        fi
    else
        base_diff_link="_Baseline_"
    fi
    
    row_num=$((i + 1))
    echo "| $row_num | [\`$short\`]($GITHUB_BASE_URL/$short) | $desc | $report_link | $diff_link | $base_diff_link |" >> "$OUTPUT_FILE"
done

# Add overall comparison section
cat >> "$OUTPUT_FILE" << EOF

---

## Overall Comparison (First → Latest)

EOF

# Check if overall comparison exists
# Note: diff file is named as diff_{last}_{first}.md because make compare runs in reverse order
overall_diff_file="$COMPARES_DIR/diff_${LAST_SHORT}_${FIRST_SHORT}.md"
if [[ $COMMIT_COUNT -eq 1 ]]; then
    cat >> "$OUTPUT_FILE" << EOF
_Single baseline commit only. Comparisons will appear once additional commits are tracked._

EOF
elif [[ -f "$overall_diff_file" ]]; then
    # Count improvements and regressions
    improvements=$(grep -c "⚡️" "$overall_diff_file" 2>/dev/null || echo "0")
    regressions=$(grep -c "⚠️" "$overall_diff_file" 2>/dev/null || echo "0")

    cat >> "$OUTPUT_FILE" << EOF
**[\`$FIRST_SHORT\` → \`$LAST_SHORT\`](reports/metric/compares/diff_${LAST_SHORT}_${FIRST_SHORT}.md)**

This comparison shows the total gas usage changes between the baseline commit and the latest commit.

### Quick Stats

| Metric | Count |
|--------|-------|
| ⚡️ Improvements | $improvements |
| ⚠️ Regressions | $regressions |

### Detailed Comparison

EOF
    
    # Extract table content from diff file (skip header lines 1-5, include from line 6)
    tail -n +6 "$overall_diff_file" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
else
    cat >> "$OUTPUT_FILE" << EOF
_Overall comparison not yet generated. Run with \`--run-tests\` to generate._

EOF
fi

# Add consecutive comparisons section
cat >> "$OUTPUT_FILE" << EOF
---
EOF


echo "Summary report saved to: $OUTPUT_FILE"
echo ""
echo "=========================================="
echo "Summary generation completed!"
echo "=========================================="
