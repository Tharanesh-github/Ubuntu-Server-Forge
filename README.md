# 🛡️ Ubuntu Server Forge & Automated Operations Suite

An automated Bash suite to instantly provision, secure, and monitor production Ubuntu web servers.

## 📖 Overview

Manually configuring servers is error-prone and time-consuming. This project contains a suite of automation scripts that take a raw Ubuntu environment and transform it into a secure, reverse-proxied production server in seconds.

### ✨ Key Features

- **Automated Security:** Installs and configures UFW (Uncomplicated Firewall), locking down all ports except SSH (22), HTTP (80), and HTTPS (443).
- **Reverse Proxy Setup:** Installs and starts Nginx as a gateway for backend applications.
- **System Health Monitoring:** Includes a monitoring script that audits RAM, Disk Space, and Nginx health, logging alerts for the system administrator.

---

# 🚀 How to Use

## 1. Provision the Server

Run the setup script on a fresh Ubuntu instance to automatically install dependencies and configure the firewall.

```bash
chmod +x setup.sh
sudo ./setup.sh
```

---

## 2. Start the Health Monitor

Run the health monitoring script to generate a diagnostic report showing RAM, Disk usage, and Nginx status.

```bash
chmod +x monitor.sh
./monitor.sh
```

> 💡 **Pro Tip:** Add `monitor.sh` to your crontab to perform automated health checks every hour.

---

# 🛠️ Technologies Used

| Category | Technology |
|----------|------------|
| **Operating System** | Ubuntu / Linux |
| **Scripting** | Bash |
| **Security** | UFW (Uncomplicated Firewall) |
| **Web Server** | Nginx |
| **Service Management** | Systemctl |

---

# 📂 Project Structure

```text
.
├── setup.sh          # Server provisioning & firewall configuration
├── monitor.sh        # Health monitoring (RAM, Disk, Nginx)
└── README.md
```

---

# ✅ Outcome

After completing all steps, your Ubuntu server will have:

- 🔒 A secured firewall using UFW
- 🌐 Nginx configured as a reverse proxy
- 📊 Automated system health monitoring
