#!/bin/bash

set -euo pipefail


# System Audit Script

# Step 1: Prepare the audit environment


AUDIT_DIR="$HOME/exam_results/audit"


mkdir -p "$AUDIT_DIR"


: > "$AUDIT_DIR/notes.txt"


{
    echo "# Current Working Directory"
    pwd
} > "$AUDIT_DIR/cwd.txt"


# Step 2: Extarct usernames from /etc/passwd

{
    echo "# Usernames from /etc/passwd"
    cut -d ':' -f 1 /etc/passwd
} > "$AUDIT_DIR/users.txt"


# Step 3: Extract user with /bin/bash shell"

{
    echo "# Users with /bin/bash shell"
    awk -F ':' '$7 == "/bin/bash" {print $1}' /etc/passwd
} > "$AUDIT_DIR/bash_users.txt"


# Step 4: Preview shell replacement without modifying /etc/passwd

{
    echo "# First 10 lines of the modified passwd preview"
    sed 's|/bin/bash|/usr/bin/zsh|g' /etc/passwd | head -n 10
} > "$AUDIT_DIR/shell_preview.txt"


#Step 5: Collect system information

{
   echo "# System Information"
   echo "Kernel Name: $(uname -s)"
   echo "Kernel Release: $(uname -r)"
   echo "Kernel Version: $(uname -v)"
   echo "Architecture: $(arch)"
} > "$AUDIT_DIR/sysinfo.txt"


#Step 6: Summarize Linux groups

{
   echo "# Group Summary"
   echo "First 3 lines"
   head -n 3 /etc/group

   echo
   echo "Last 2 lines"
   tail -n 2 /etc/group
} > "$AUDIT_DIR/group_summary.txt"


#Step 7: Find configuration files in /etc

{
   echo "# Configuration files under /etc"

    if ! find /etc -type f -name "*.conf" \
        2>"$AUDIT_DIR/find_conf_errors.log"; then
        echo "Warning: Some directories under /etc could not be searched." >&2
    fi

} > "$AUDIT_DIR/conf_files.txt"


#Step 8: Find the 10 largest Log files

{
   echo "# Top 10 largest Files in /var/log"

       if ! find /var/log -type f -printf '%s %p\n' \
        2>"$AUDIT_DIR/find_logs_errors.log" \
        | sort -nr \
        | awk 'NR <= 10'; then
        echo "Warning: Some files under /var/log could not be scanned." >&2
    fi

} > "$AUDIT_DIR/top_logs.txt"


#Step 9: Backup /etc/hosts and set secure permissions

cp /etc/hosts "$AUDIT_DIR/hosts.bak"

chmod 600 "$AUDIT_DIR/hosts.bak"

echo "Backup completed"

{
   echo "# Permission of hosts.bak"
   ls -l "$AUDIT_DIR/hosts.bak"
} > "$AUDIT_DIR/hosts_perm.txt"


#Step 10: Remove temproray TXT files

find "$AUDIT_DIR" \
     -maxdepth 1 \
     -type f \
     -name "*.txt" \
     ! -name "notes.txt" \
     ! -name "hosts_perm.txt" \
     -delete

# Step 11: Archive diagnostic logs without overwriting old logs

DEBUG_DIR="$HOME/audit-debug-logs"

mkdir -p "$DEBUG_DIR"

RUN_DIR=$(mktemp -d "$DEBUG_DIR/run-XXXXXXXX")

mv -- "$AUDIT_DIR/find_conf_errors.log" \
      "$AUDIT_DIR/find_logs_errors.log" \
      "$RUN_DIR/"
