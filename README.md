# oss-audit-24BCE10929
# OSS Audit — MySQL
**Open Source Software (OSS NGMC) Capstone Project**

![License](https://img.shields.io/badge/License-GPLv2-blue.svg)
![Bash](https://img.shields.io/badge/Shell-Bash-121011?logo=gnu-bash&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Linux-orange)
![Database](https://img.shields.io/badge/Database-MySQL-4479A1?logo=mysql&logoColor=white)
![Course](https://img.shields.io/badge/Course-OSS%20NGMC-success)

| Field | Details |
|---|---|
| **Student Name** | SHREYASH PAWAR |
| **Registration Number** | 24BCE10929 |
| **University** | VIT Bhopal University |
| **Chosen Software** | MySQL |
| **Licence** | GPL v2 (Community) / Commercial (Enterprise) |
| **Course** | Open Source Software (OSS NGMC) |

---

## About This Repository

This repository contains the five shell scripts submitted as part of The Open Source Audit  project.

For this project, I chose MySQL as the software to audit. Born in 1995 from a practical need for a free, fast database, MySQL became the 'M' in the LAMP stack and powered the first generation of the open web. It is dual-licensed under GPL v2 for community use and a commercial licence for proprietary integration.

---

## Repository Structure

```
oss-audit-24BCE10929/
├── README.md                          # This file
├── script1_system_identity.sh         # System Identity Report
├── script2_package_inspector.sh       # FOSS Package Inspector
├── script3_disk_auditor.sh            # Disk and Permission Auditor
├── script4_log_analyzer.sh            # Log File Analyzer
└── script5_manifesto_generator.sh     # Open Source Manifesto Generator
```

---

## Scripts Overview

### Script 1 — System Identity Report (`script1_system_identity.sh`)
![Bash](https://img.shields.io/badge/Shell-Bash-121011?logo=gnu-bash&logoColor=white) ![Type](https://img.shields.io/badge/Type-System%20Info-blue) ![Tools](https://img.shields.io/badge/Tools-uname%20%7C%20uptime%20%7C%20date-informational)

This script gives a clean welcome screen that shows the Linux distribution, kernel version, logged-in user, home directory, system uptime, current date and time, and the open-source licence covering the OS kernel.

**Concepts:** Variables, `echo`, command substitution `$()`, `uname`, `whoami`, `uptime`, `date`, `/etc/os-release` parsing.

### Script 2 — FOSS Package Inspector (`script2_package_inspector.sh`)
![Bash](https://img.shields.io/badge/Shell-Bash-121011?logo=gnu-bash&logoColor=white) ![Type](https://img.shields.io/badge/Type-Package%20Inspector-blue) ![Managers](https://img.shields.io/badge/Managers-dpkg%20%7C%20rpm-orange)

This script checks whether MySQL (or any specified package) is installed on the system. It then shows version and licence metadata using `dpkg` or `rpm`, and uses a `case` statement to print a philosophy note about the selected package.

**Concepts:** `if-then-else`, `case` statement, `dpkg -s` / `rpm -qi`, pipe with `grep`, exit codes, command-line arguments.

### Script 3 — Disk and Permission Auditor (`script3_disk_auditor.sh`)
![Bash](https://img.shields.io/badge/Shell-Bash-121011?logo=gnu-bash&logoColor=white) ![Type](https://img.shields.io/badge/Type-Disk%20Audit-blue) ![Tools](https://img.shields.io/badge/Tools-ls%20%7C%20du%20%7C%20df-informational)

- Goes through key Linux system directories and MySQL-specific directories.
- Reports permissions, owner, group, and disk usage for each one.
- Checks for MySQL configuration files.

**Concepts:** `for` loop over arrays, `ls -ld`, `du -sh`, `awk` for field extraction, conditional directory existence checks, `df` for filesystem summary.

### Script 4 — Log File Analyzer (`script4_log_analyzer.sh`)
![Bash](https://img.shields.io/badge/Shell-Bash-121011?logo=gnu-bash&logoColor=white) ![Type](https://img.shields.io/badge/Type-Log%20Analyzer-blue) ![Tools](https://img.shields.io/badge/Tools-grep%20%7C%20tail%20%7C%20wc-informational)

This script reads a log file line by line, counts how many times a keyword appears (default: `error`), shows the match percentage, and displays the last 5 matching lines.

**Concepts:** `while IFS= read -r` loop, `if-then` inside loop, counter arithmetic `$(())`, command-line arguments `$1` and `$2`, `grep -i` + `tail` pipeline, file validation.

### Script 5 — Open Source Manifesto Generator (`script5_manifesto_generator.sh`)
![Bash](https://img.shields.io/badge/Shell-Bash-121011?logo=gnu-bash&logoColor=white) ![Type](https://img.shields.io/badge/Type-Interactive%20Generator-blue) ![Output](https://img.shields.io/badge/Output-.txt-success)

This script asks the user three questions and then generates a open source philosophy statement. The questions are:
- "Name one open-source tool you use every day"
- "In one word, what does 'freedom' mean to you?"
- "Name one thing you would build and share freely"
It saves the output to a `.txt` file and displays it on screen.

**Concepts:** `read` for interactive input, input validation loop, string concatenation, file output with `>` and `>>`, `date` command, `whoami` substitution, `cat` to display file, alias concept (demonstrated via comments).

---

## How to Run Each Script on Linux

### Prerequisites
- A Linux system (Ubuntu 22.04 LTS recommended, or any Debian/RHEL-based distribution)
- Bash shell (pre-installed on all Linux systems)
- MySQL installed for Scripts 2 and 3 to show full output (optional — scripts handle the not-installed case)

### Step 1: Clone the Repository
```bash
git clone https://github.com/alphashr18/oss-audit-24BCE10929
```

### Step 2: Make All Scripts Executable
```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

### Step 3: Run Each Script

**Script 1 — System Identity Report**
```bash
./script1_system_identity.sh
```

**Script 2 — FOSS Package Inspector**
```bash
# Inspect MySQL (default)
./script2_package_inspector.sh

# Inspect a specific package
./script2_package_inspector.sh mysql-server
./script2_package_inspector.sh firefox
./script2_package_inspector.sh git
```

**Script 3 — Disk and Permission Auditor**
```bash
./script3_disk_auditor.sh
```
> Note: Some directories (e.g. `/var/lib/mysql`) may require `sudo` to show accurate sizes.
> ```bash
> sudo ./script3_disk_auditor.sh
> ```

**Script 4 — Log File Analyzer**
```bash
# Analyse syslog for errors (requires sudo )
sudo ./script4_log_analyzer.sh /var/log/syslog error

# Analyse MySQL error log
sudo ./script4_log_analyzer.sh /var/log/mysql/error.log error

# Analyse auth log for failed logins
sudo ./script4_log_analyzer.sh /var/log/auth.log Failed

# Use any log file with any keyword
./script4_log_analyzer.sh /path/to/logfile keyword
```

**Script 5 — Open Source Manifesto Generator**
```bash
./script5_manifesto_generator.sh
```
> The script will prompt you with three interactive questions. Your manifesto is saved to `manifesto_[username].txt` in the current directory (`[username]` is your login name).

---

## Dependencies

| Script | Dependencies |
|---|---|
| Script 1 | `bash`, `uname`, `whoami`, `uptime`, `date`, `/etc/os-release` |
| Script 2 | `bash`, `dpkg` (Debian/Ubuntu) OR `rpm` (RHEL/CentOS) |
| Script 3 | `bash`, `ls`, `du`, `df`, `awk` |
| Script 4 | `bash`, `grep`, `wc`, `tail` |
| Script 5 | `bash`, `date`, `whoami`, `cat` |

All dependencies are pre-installed on any standard Linux system.

---

## Installing MySQL (for full Script 2 and 3 output)

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install mysql-server -y

# RHEL/CentOS/Fedora
sudo dnf install mysql-server -y

# Verify installation
mysql --version
sudo systemctl status mysql
```

---

## Reference Resources

- MySQL Reference Manual: https://dev.mysql.com/doc/refman/8.0/en/
- GNU Free Software Definition: https://gnu.org/philosophy/free-sw.html
- MySQL Source Code: https://github.com/mysql/mysql-server
- GPL v2 Licence Text: https://spdx.org/licenses/GPL-2.0-only.html
- MariaDB Foundation: https://mariadb.org/about/

---

**Created by:**  SHREYASH PAWAR  
**University:** VIT Bhopal University  
**Year:** 2026

This repository has been created as part of the Open Source Software (OSS NGMC) project at VIT Bhopal University. 
All scripts and documentation in this repository are authored by SHREYASH PAWAR (Registration: 24BCE10929).
