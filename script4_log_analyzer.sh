#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author   : Tanmay Joshi
# Reg No   : 24BCE10381
# Course   : Open Source Software (OSS NGMC)
# Chosen   : MySQL
# Purpose  : Reads a log file line by line, counts keyword
#            occurrences, and shows the last 5 matching lines.
# Usage    : ./script4_log_analyzer.sh <logfile> [keyword]
# Example  : ./script4_log_analyzer.sh /var/log/syslog error
# ============================================================

# --- Command-line arguments ---------------------------------
# $1 is the first argument (log file path)
# $2 is the second argument (keyword); default is "error" if not provided
LOGFILE=$1
KEYWORD=${2:-"error"}   # Default keyword: error

# --- Counter variable: starts at zero ----------------------
COUNT=0

echo "============================================================"
echo "   LOG FILE ANALYZER"
echo "============================================================"
echo ""

# --- Validate that a log file was specified ----------------
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""
    echo "  MySQL log files to try:"
    echo "    /var/log/mysql/error.log"
    echo "    /var/log/syslog"
    echo "    /var/log/auth.log"
    exit 1
fi

# --- Check if the file exists and is readable --------------
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' does not exist."
    exit 1
fi

# Check if file is readable by current user
if [ ! -r "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' exists but is not readable."
    echo "  Try running with sudo: sudo $0 $LOGFILE $KEYWORD"
    exit 1
fi

# Check if file is empty
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: File '$LOGFILE' is empty. No lines to analyse."
    exit 0
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo "  Started  : $(date '+%H:%M:%S')"
echo ""
echo "  Scanning file... please wait."
echo ""

# --- while-read loop: read the file line by line -----------
# IFS= read -r LINE: reads one line at a time
# -r prevents backslash interpretation
# < "$LOGFILE" redirects file content into the while loop
while IFS= read -r LINE; do
    # if-then: check if this line contains the keyword
    # echo "$LINE" | grep -iq: -i = case-insensitive, -q = quiet (no output)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        # Increment counter using arithmetic: $((COUNT + 1))
        COUNT=$((COUNT + 1))
    fi
done < "$LOGFILE"

# --- Count total lines in the file -------------------------
TOTAL_LINES=$(wc -l < "$LOGFILE")

# --- Display results summary --------------------------------
echo "------------------------------------------------------------"
echo "  RESULTS SUMMARY"
echo "------------------------------------------------------------"
echo "  Total lines in file   : $TOTAL_LINES"
echo "  Lines matching '$KEYWORD' : $COUNT"

# --- Calculate and display percentage ----------------------
if [ "$TOTAL_LINES" -gt 0 ]; then
    # Integer arithmetic: multiply by 100 before dividing to avoid decimals
    PERCENT=$(( (COUNT * 100) / TOTAL_LINES ))
    echo "  Match percentage      : ${PERCENT}%"
fi

echo ""

# --- Show last 5 matching lines ----------------------------
# tail + grep pipeline: tail reads the file, grep filters lines
if [ "$COUNT" -gt 0 ]; then
    echo "------------------------------------------------------------"
    echo "  LAST 5 MATCHING LINES"
    echo "------------------------------------------------------------"
    # grep -i: case-insensitive | tail -5: last 5 results
    grep -i "$KEYWORD" "$LOGFILE" | tail -5 | while IFS= read -r line; do
        echo "  >> $line"
    done
else
    echo "  No lines containing '$KEYWORD' were found in the log file."
fi

echo ""
echo "============================================================"
echo "  Analysis complete. Keyword '$KEYWORD' found $COUNT time(s)."
echo "============================================================"
