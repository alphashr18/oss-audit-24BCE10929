#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author   : Tanmay Joshi
# Reg No   : 24BCE10381
# Course   : Open Source Software (OSS NGMC)
# Chosen   : MySQL
# Purpose  : Loops through key Linux system directories and
#            reports permissions, owner, group, and disk usage.
#            Also audits MySQL-specific directories.
# ============================================================

# --- list of standard system directories to audit ---
# Array syntax in bash: VARNAME=("item1" "item2" ...)
SYSTEM_DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/var/lib" "/usr/sbin")

# --- MySQL-specific directories to audit separately --------
MYSQL_DIRS=("/etc/mysql" "/var/lib/mysql" "/var/log/mysql" "/run/mysqld")

echo "============================================================"
echo "   DISK AND PERMISSION AUDITOR"
echo "============================================================"
echo ""
echo "  Audit Date : $(date '+%d %B %Y %H:%M:%S')"
echo "  System     : $(hostname)"
echo ""
echo "------------------------------------------------------------"
echo "  SYSTEM DIRECTORY AUDIT"
echo "------------------------------------------------------------"
printf "  %-25s %-25s %-10s\n" "DIRECTORY" "PERMISSIONS (perms user grp)" "SIZE"
echo "  -----------------------------------------------------------------------"

# --- for loop: iterate over each directory in the array ----
for DIR in "${SYSTEM_DIRS[@]}"; do
    # Check if directory exists before trying to inspect it
    if [ -d "$DIR" ]; then
        # ls -ld: list directory itself (not its contents) in long format
        # awk '{print $1, $3, $4}' extracts: permissions, owner, group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # du -sh: disk usage in human-readable format (-h) summarised (-s)
        # 2>/dev/null suppresses "Permission denied" errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        printf "  %-25s %-25s %-10s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"
    else
        # Directory does not exist on this system
        printf "  %-25s %s\n" "$DIR" "[Does not exist on this system]"
    fi
done

echo ""
echo "------------------------------------------------------------"
echo "  MYSQL-SPECIFIC DIRECTORY AUDIT"
echo "------------------------------------------------------------"
echo "  Checking MySQL installation directories..."
echo ""
printf "  %-30s %-25s %-10s\n" "MYSQL PATH" "PERMISSIONS" "SIZE"
echo "  -----------------------------------------------------------------------"

# --- Another for loop for MySQL directories ----------------
for DIR in "${MYSQL_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "  %-30s %-25s %-10s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"
    else
        printf "  %-30s %s\n" "$DIR" "[Not found -- MySQL may not be installed]"
    fi
done

echo ""
echo "------------------------------------------------------------"
echo "  MYSQL CONFIG FILE CHECK"
echo "------------------------------------------------------------"

# --- Check existence of MySQL configuration files ----------
MYSQL_CONF_FILES=("/etc/mysql/my.cnf" "/etc/my.cnf" "/etc/mysql/mysql.conf.d/mysqld.cnf")
for CONF in "${MYSQL_CONF_FILES[@]}"; do
    if [ -f "$CONF" ]; then
        PERMS=$(ls -l "$CONF" | awk '{print $1, $3, $4}')
        echo "  FOUND: $CONF"
        echo "         Permissions: $PERMS"
    fi
done

echo ""
echo "------------------------------------------------------------"
echo "  DISK USAGE SUMMARY"
echo "------------------------------------------------------------"
# df -h shows overall filesystem disk usage in human-readable format
df -h / | tail -1 | awk '{
    printf "  Filesystem root (/)\n"
    printf "  Total: %s | Used: %s | Available: %s | Use%%: %s\n", $2, $3, $4, $5
}'

echo ""
echo "============================================================"
echo "  Audit complete."
echo "============================================================"
