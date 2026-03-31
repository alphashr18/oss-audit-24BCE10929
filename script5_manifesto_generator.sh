#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author   : Tanmay Joshi
# Reg No   : 24BCE10381
# Course   : Open Source Software (OSS NGMC)
# Chosen   : MySQL
# Purpose  : Interactively collects answers from the user and
#            generates a personalised open source philosophy
#            statement, saving it to a .txt file.
# ============================================================

# --- Alias concept demonstration ---------------------------
# An alias is a shortcut for a longer command (shown here as a comment
# since aliases defined in scripts don't persist to the parent shell)
# alias today='date "+%d %B %Y"'   -- would give today's date nicely
# alias greet='echo "Hello, $USER"' -- would print a greeting

echo "============================================================"
echo "   OPEN SOURCE MANIFESTO GENERATOR"
echo "============================================================"
echo ""
echo "  Answer three questions to generate your personal"
echo "  open source philosophy statement."
echo ""
echo "------------------------------------------------------------"

# --- read: capture interactive input from the user ---------
# read -p "prompt" VARIABLE  prompts the user and stores their answer
read -p "  1. Name one open-source tool you use every day: " TOOL

# Validate that the user entered something (not just pressed Enter)
while [ -z "$TOOL" ]; do
    echo "     Please enter a tool name."
    read -p "  1. Name one open-source tool you use every day: " TOOL
done

echo ""
read -p "  2. In one word, what does 'freedom' mean to you?  " FREEDOM

while [ -z "$FREEDOM" ]; do
    echo "     Please enter one word."
    read -p "  2. In one word, what does 'freedom' mean to you?  " FREEDOM
done

echo ""
read -p "  3. Name one thing you would build and share freely: " BUILD

while [ -z "$BUILD" ]; do
    echo "     Please enter something you would build."
    read -p "  3. Name one thing you would build and share freely: " BUILD
done

echo ""
echo "  Generating your manifesto..."
echo ""

# --- Date and output file ----------------------------------
# date command with format string produces human-readable date
DATE=$(date '+%d %B %Y')
TIME=$(date '+%H:%M')

# String concatenation: build the output filename using whoami
# whoami is command substitution that returns the current username
OUTPUT="manifesto_$(whoami).txt"

# --- Compose the manifesto and write to file ---------------
# > overwrites the file (or creates it if new)
# >> appends to an existing file
# We use > for the first line and >> for subsequent lines

echo "============================================================" > "$OUTPUT"
echo "   MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "   Generated: $DATE at $TIME" >> "$OUTPUT"
echo "   Author   : $(whoami)" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# String concatenation to build the manifesto paragraph
echo "Every day I use $TOOL, I stand on the shoulders of developers" >> "$OUTPUT"
echo "who chose to build in the open and share their work freely." >> "$OUTPUT"
echo "That choice was not accidental — it was a deliberate act based" >> "$OUTPUT"
echo "on the belief that $FREEDOM is more important than control." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Open source means that the tools I depend on are transparent:" >> "$OUTPUT"
echo "I can read the source, understand how they work, improve them," >> "$OUTPUT"
echo "and share my improvements. This is not just a licensing model" >> "$OUTPUT"
echo "— it is a statement about how knowledge should flow." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "I commit to contributing to this ecosystem. When I build" >> "$OUTPUT"
echo "$BUILD, I will share it freely — not because I have to," >> "$OUTPUT"
echo "but because someone once shared $TOOL with me, and the least" >> "$OUTPUT"
echo "I can do is extend that chain of trust to whoever comes next." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "The code I write will outlast me. Let it be open." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "------------------------------------------------------------" >> "$OUTPUT"
echo "Software Chosen for OSS Audit: MySQL (GPL v2 / Commercial)" >> "$OUTPUT"
echo "Course: Open Source Software (OSS NGMC)" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"

# --- Display the saved manifesto ---------------------------
echo "============================================================"
echo "   YOUR MANIFESTO"
echo "============================================================"
echo ""
# cat reads and displays the file content
cat "$OUTPUT"
echo ""
echo "------------------------------------------------------------"
echo "  Manifesto saved to: $OUTPUT"
echo "  File size         : $(wc -c < "$OUTPUT") bytes"
echo "============================================================"
