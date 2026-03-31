#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author   : Tanmay Joshi
# Reg No   : 24BCE10381
# Course   : Open Source Software (OSS NGMC)
# Chosen   : MySQL
# Purpose  : Checks whether the chosen open-source package is
#            installed, displays version/licence info, and uses
#            a case statement to print a philosophy note.
# ============================================================

# --- The package to inspect (default: mysql-server) --------
# Use command-line argument if provided, otherwise default to mysql-server
PACKAGE=${1:-"mysql-server"}

echo "============================================================"
echo "   FOSS Package Inspector -- $PACKAGE"
echo "============================================================"
echo ""

# --- Detect which package manager is available -------------
# if-then-else: check for dpkg (Debian/Ubuntu) or rpm (RHEL/CentOS)
if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
else
    echo "ERROR: No supported package manager found (dpkg or rpm)."
    exit 1
fi

echo "  Package Manager : $PKG_MANAGER"
echo ""

# --- Check if the package is installed ---------------------
# &>/dev/null redirects both stdout and stderr to suppress output
if [ "$PKG_MANAGER" = "dpkg" ]; then
    # dpkg -s returns exit code 0 if installed, non-zero if not
    if dpkg -s "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        echo "  STATUS: $PACKAGE is INSTALLED"
        echo ""
        echo "  --- Package Details ---"
        # pipe with grep to extract specific fields from package info
        dpkg -s "$PACKAGE" | grep -E "^(Version|Status|Maintainer|Homepage)" | \
            while IFS= read -r line; do echo "  $line"; done
    else
        INSTALLED=false
    fi
else
    # rpm -q returns exit code 0 if installed
    if rpm -q "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        echo "  STATUS: $PACKAGE is INSTALLED"
        echo ""
        echo "  --- Package Details ---"
        # grep -E with regex to match multiple fields at once
        rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary|URL)" | \
            while IFS= read -r line; do echo "  $line"; done
    else
        INSTALLED=false
    fi
fi

# --- If not installed, suggest installation ----------------
if [ "$INSTALLED" = false ]; then
    echo "  STATUS: $PACKAGE is NOT installed on this system."
    echo ""
    echo "  To install on Ubuntu/Debian: sudo apt install mysql-server"
    echo "  To install on RHEL/CentOS:   sudo dnf install mysql-server"
fi

echo ""
echo "------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "------------------------------------------------------------"
echo ""

# --- case statement: prints a philosophy note based on package name ---
case "$PACKAGE" in
    mysql-server|mysql|mysqld)
        echo "  MySQL: Born in 1995 from a Swedish developer's need for a"
        echo "  fast, free database. The M in LAMP -- it powered the first"
        echo "  generation of the open web and democratised data storage."
        echo "  Licence: GPL v2 (Community) / Commercial (Enterprise)"
        ;;
    httpd|apache2|apache)
        echo "  Apache HTTP Server: The open web server that made the World"
        echo "  Wide Web accessible. Still powering roughly 30 percent of"
        echo "  all websites globally."
        echo "  Licence: Apache Licence 2.0"
        ;;
    mariadb|mariadb-server)
        echo "  MariaDB: The community fork of MySQL, created by MySQL's"
        echo "  original author. Purely GPL, governed by a foundation."
        echo "  Licence: GPL v2"
        ;;
    firefox)
        echo "  Firefox: A browser built by a nonprofit to keep the web open."
        echo "  Proof that community-driven development can compete with the"
        echo "  largest corporations on earth."
        echo "  Licence: Mozilla Public Licence 2.0"
        ;;
    git)
        echo "  Git: Built by Linus Torvalds in 2005 after a proprietary"
        echo "  version control tool failed him. The universal standard for"
        echo "  collaborative open-source development."
        echo "  Licence: GPL v2"
        ;;
    python3|python)
        echo "  Python: A language shaped entirely by community consensus."
        echo "  The PSF licence is permissive -- Python can be used in"
        echo "  proprietary software, which is why it became ubiquitous."
        echo "  Licence: Python Software Foundation Licence"
        ;;
    *)
        echo "  $PACKAGE: An open-source tool that someone built and chose"
        echo "  to share freely. Read its licence and understand the freedoms"
        echo "  it grants you."
        ;;
esac

echo ""
echo "============================================================"
echo "  Audit complete for: $PACKAGE"
echo "============================================================"
