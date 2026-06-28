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

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# 1. Capture Metrics
FREE_RAM=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
DISK_USAGE=$(df -h / | awk '$NF=="/"{printf "%s", $5}')

if systemctl is-active --quiet nginx; then
    NGINX_STATUS="RUNNING"
    NGINX_COLOR="${GREEN}RUNNING${NC}"
else
    NGINX_STATUS="OFFLINE / FAILED"
    NGINX_COLOR="${RED}OFFLINE / FAILED${NC}"
fi

# 2. Write Plain Text to Log File (Keeps the file clean!)
echo "----------------------------------------------------" >> "$LOG_FILE"
echo "System Health Audit - $(date)" >> "$LOG_FILE"
echo "----------------------------------------------------" >> "$LOG_FILE"
echo "[RAM] Usage: $FREE_RAM" >> "$LOG_FILE"
echo "[DISK] Root Partition Usage: $DISK_USAGE" >> "$LOG_FILE"
echo "[NGINX] Status: $NGINX_STATUS" >> "$LOG_FILE"

# 3. Print Colored Output to Console (Looks great for the user!)
echo -e "${CYAN}----------------------------------------------------${NC}"
echo -e "${CYAN}System Health Audit - $(date)${NC}"
echo -e "${CYAN}----------------------------------------------------${NC}"
echo -e "${YELLOW}[RAM]${NC} Usage: $FREE_RAM"
echo -e "${YELLOW}[DISK]${NC} Root Partition Usage: $DISK_USAGE"
echo -e "${YELLOW}[NGINX]${NC} Status: $NGINX_COLOR"
echo -e "\n${GREEN}✅ Health check complete. Results logged to: $LOG_FILE${NC}"
