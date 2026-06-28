#!/bin/bash
# ==============================================================================
# Script Name: monitor.sh
# Description: Audits system health (CPU, RAM, Disk, Nginx) and logs the output.
# ==============================================================================
# Text Color Variables
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

LOG_DIR="$HOME/server-logs"
LOG_FILE="$LOG_DIR/health-check.log"
LOG_MAX_LINES=1000

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# 1. Capture Metrics
FREE_RAM=$(free -m | awk 'NR==2{printf "%.2f%%", (1-$7/$2)*100 }')
DISK_USAGE=$(df -h / | awk '$NF=="/"{printf "%s", $5}')

HEALTH_STATUS=0  # 0 = healthy, 1 = degraded

if systemctl is-active --quiet nginx; then
    NGINX_STATUS="RUNNING"
    NGINX_COLOR="${GREEN}RUNNING${NC}"
else
    NGINX_STATUS="OFFLINE / FAILED"
    NGINX_COLOR="${RED}OFFLINE / FAILED${NC}"
    HEALTH_STATUS=1
fi

# 2. Log rotation — trim to last LOG_MAX_LINES if file is getting large
if [[ -f "$LOG_FILE" ]]; then
    CURRENT_LINES=$(wc -l < "$LOG_FILE")
    if (( CURRENT_LINES > LOG_MAX_LINES )); then
        tail -n "$LOG_MAX_LINES" "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
    fi
fi

# 3. Write plain text to log file (keeps the file clean!)
{
    echo "----------------------------------------------------"
    echo "System Health Audit - $(date)"
    echo "----------------------------------------------------"
    echo "[RAM] Usage: $FREE_RAM"
    echo "[DISK] Root Partition Usage: $DISK_USAGE"
    echo "[NGINX] Status: $NGINX_STATUS"
} >> "$LOG_FILE"

# 4. Print colored output to console
echo -e "${CYAN}----------------------------------------------------${NC}"
echo -e "${CYAN}System Health Audit - $(date)${NC}"
echo -e "${CYAN}----------------------------------------------------${NC}"
echo -e "${YELLOW}[RAM]${NC} Usage: $FREE_RAM"
echo -e "${YELLOW}[DISK]${NC} Root Partition Usage: $DISK_USAGE"
echo -e "${YELLOW}[NGINX]${NC} Status: $NGINX_COLOR"
echo -e "\n${GREEN}✅ Health check complete. Results logged to: $LOG_FILE${NC}"

exit $HEALTH_STATUS
