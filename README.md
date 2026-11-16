# Linux System Audit Automation with Bash

## Overview

A Bash scripting project developed on Ubuntu Server 24.04 LTS to practice Linux system administration, text processing, file permissions, logging, and basic automation.

The script collects system information, generates audit reports, creates a protected backup of `/etc/hosts`, and cleans up temporary reports according to the exercise requirements.

## Features

- Creates a dedicated audit output directory.
- Extracts local usernames from `/etc/passwd`.
- Identifies accounts configured with `/bin/bash`.
- Generates a shell-replacement preview without modifying `/etc/passwd`.
- Collects Linux kernel and system architecture information.
- Summarizes entries from `/etc/group`.
- Searches for `.conf` files under `/etc`.
- Reports the ten largest accessible files under `/var/log`.
- Backs up `/etc/hosts` and applies `600` file permissions.
- Removes temporary `.txt` reports while preserving the required files.
- Archives diagnostic logs in separate directories for later troubleshooting.

## Technologies

- Bash
- Ubuntu Server 24.04 LTS
- Linux command-line tools (`awk`, `sed`, `find`, `sort`, `cut`, `chmod`)
- Git and GitHub

## Project Structure

```text
system-audit/
├── system_audit_exam.sh
├── README.md
└── .gitignore
```

## Usage

Clone the repository and enter the project directory:

```bash
git clone <repository-url>
cd system-audit
```

Check the script syntax:

```bash
bash -n system_audit_exam.sh
```

Run the script:

```bash
bash system_audit_exam.sh
```

## Output

Generated audit files are written to:

```text
~/exam_results/audit/
```

After the cleanup step, the expected remaining files are:

```text
hosts.bak
hosts_perm.txt
notes.txt
```

Diagnostic logs are archived separately under:

```text
~/audit-debug-logs/
```

## Permissions and Limitations

The script is designed to run as a regular Linux user without requiring root privileges for the entire workflow.

Some directories under `/etc` and `/var/log` may be inaccessible to the current user. As a result, the configuration-file and log-file inventories may be incomplete. Related errors are captured in diagnostic logs.

The script generates a preview of shell-path substitutions but does not modify the original `/etc/passwd` file.

## Learning Outcomes

This is an educational project experience with Bash scripting, Linux file-system navigation, command pipelines, text processing, basic error handling, file permissions.
