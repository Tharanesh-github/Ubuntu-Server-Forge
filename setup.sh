#!/bin/bash
# ==============================================================================
# Script Name: setup.sh
# Description: Automates the provisioning of a secure Ubuntu web server environment.
# ==============================================================================

# Text Color Variables for aesthetic terminal output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Ubuntu Server Forge Provisioning...${NC}"

# 1. Update the System
echo -e "${YELLOW}[1/4] Updating system packages...${NC}"
sudo apt update -y && sudo apt upgrade -y

# 2. Install Core Dependencies
echo -e "${YELLOW}[2/4] Installing Nginx and Python3...${NC}"
sudo apt install nginx python3 python3-pip -y

# 3. Configure the Firewall (UFW)
echo -e "${YELLOW}[3/4] Securing perimeter with UFW...${NC}"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh        # Port 22
sudo ufw allow 'Nginx Full' # Ports 80 & 443

# Enable UFW without prompting for y/n
echo "y" | sudo ufw enable

# 4. Start and Enable Services
echo -e "${YELLOW}[4/4] Starting Nginx...${NC}"
sudo systemctl enable nginx
sudo systemctl restart nginx

echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}✅ PROVISIONING COMPLETE!${NC}"
echo -e "Firewall is ACTIVE. Nginx is RUNNING."
echo -e "Test your server by visiting http://$(hostname -I | awk '{print $1}')"
echo -e "${GREEN}==========================================${NC}"
