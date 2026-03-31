#!/bin/bash
# ==============================================================================================
# Script 1: System Identity Report
# Author   : SHREYASH PAWAR
# Reg No   : 24BCE10929
# Course   : Open Source Software (OSS NGMC)
# Chosen   : MySQL
# Purpose  : Displays a welcome screen with key system information about the Linux environment.
# ===============================================================================================

STUDENT_NAME="SHREYASH PAWAR"
REG_NO="24BCE10929"
SOFTWARE_CHOICE="MySQL"

# Command substitution $() runs a command and collect output
KERNEL=$(uname -r)                   # Linux kernel version
ARCH=$(uname -m)                     # CPU architecture (x86_64, etc.)
USER_NAME=$(whoami)                  # Currently logged-in user
HOME_DIR=$HOME                       # Home directory from environment
UPTIME=$(uptime -p)                  # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y') # Formatted date: Monday, 01 January 2025
CURRENT_TIME=$(date '+%H:%M:%S')     # Current time in 24-hour format
HOSTNAME=$(hostname)                 # Machine hostname

# --- Parse distro name from /etc/os-release ----------------
# /etc/os-release is the standard file for OS identification on Linux
if [ -f /etc/os-release ]; then
    DISTRO=$(grep "^PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"')
else
    DISTRO="Unknown Linux Distribution"
fi

# --- Determine the OS kernel licence -----------------------
# The Linux kernel is released under the GNU General Public Licence version 2
KERNEL_LICENCE="GNU General Public Licence version 2 (GPL v2)"

# --- Display: formatted welcome screen ---------------------
echo "============================================================"
echo "         OPEN SOURCE AUDIT — System Identity Report"
echo "============================================================"
echo ""
echo "  Student   : $STUDENT_NAME"
echo "  Reg No    : $REG_NO"
echo "  Software  : $SOFTWARE_CHOICE"
echo ""
echo "------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------"
echo "  Hostname       : $HOSTNAME"
echo "  Distribution   : $DISTRO"
echo "  Kernel Version : $KERNEL"
echo "  Architecture   : $ARCH"
echo ""
echo "------------------------------------------------------------"
echo "  USER INFORMATION"
echo "------------------------------------------------------------"
echo "  Logged-in User : $USER_NAME"
echo "  Home Directory : $HOME_DIR"
echo ""
echo "------------------------------------------------------------"
echo "  DATE AND TIME"
echo "------------------------------------------------------------"
echo "  Date           : $CURRENT_DATE"
echo "  Time           : $CURRENT_TIME"
echo "  Uptime         : $UPTIME"
echo ""
echo "------------------------------------------------------------"
echo "  OPEN SOURCE LICENCE"
echo "------------------------------------------------------------"
echo "  This system's kernel is licensed under:"
echo "  $KERNEL_LICENCE"
echo ""
echo "  MySQL (chosen software) is dual-licensed:"
echo "  - Community Edition : GPL v2 (free and open source)"
echo "  - Enterprise Edition: Commercial licence (Oracle)"
echo ""
echo "============================================================"
echo "  'The power to control your computing comes from freedom.'"
echo "  -- Richard Stallman, GNU Project"
echo "============================================================"
