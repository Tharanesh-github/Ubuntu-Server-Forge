# 🛡️ Ubuntu Server Forge & Automated Operations Suite

An automated Bash suite to instantly provision, secure, monitor, and manage storage for production Ubuntu web servers.

## 📖 Overview

Manually configuring servers is error-prone and time-consuming. This project contains a suite of automation scripts that take a raw Ubuntu environment and transform it into a secure, reverse-proxied production server in seconds. It also includes an automated defense system against disk saturation.

### ✨ Key Features

- **Automated Security:** Installs and configures UFW (Uncomplicated Firewall), locking down all ports except SSH (22), HTTP (80), and HTTPS (443).
- **Reverse Proxy Setup:** Installs and starts Nginx as a gateway for backend applications.
- **System Health Monitoring:** Includes a monitoring script that audits CPU, RAM, Disk Space, and Nginx health, logging alerts for the system administrator.
- **Automated Storage Defense:** Utilizes custom `logrotate` rules and a `cron`-based sentry to compress old files and prevent disk saturation from heavy application logs.

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

Run the health monitoring script to generate a diagnostic report showing CPU, RAM, Disk usage, and Nginx status.

```bash
chmod +x monitor.sh
./monitor.sh
```

> 💡 **Pro Tip:** Add `monitor.sh` to your crontab to perform automated health checks every hour.

---

## 3. Simulate Production Traffic

Launch the background logging application to generate heavy log traffic for testing.

```bash
python3 logger.py
```

---

## 4. Arm the Automated Log Sentry

Configure the sentry script to run every minute using Cron.

Open the crontab:

```bash
crontab -e
```

Add the following rule to the bottom of the file:

```text
* * * * * /bin/bash /home/tharanesh/log-lab/sentry.sh >> /home/tharanesh/log-lab/sentry.log 2>&1
```

This continuously monitors available disk space and triggers protective actions before storage becomes critically full.

---

## 5. Enforce Log Rotation

Create a custom Logrotate configuration.

```bash
sudo nano /etc/logrotate.d/mylablogs
```

To verify that your configuration works correctly, force a manual rotation:

```bash
sudo logrotate -f /etc/logrotate.d/mylablogs
```

This compresses and rotates application logs automatically, preventing uncontrolled disk growth.

---

# 🛠️ Technologies Used

| Category | Technology |
|----------|------------|
| **Operating System** | Ubuntu / Linux |
| **Scripting** | Bash, Python |
| **Security** | UFW (Uncomplicated Firewall) |
| **Web Server** | Nginx |
| **Automation** | Cron |
| **Storage Management** | Logrotate |
| **Service Management** | Systemctl |

---

# 📂 Project Structure

```text
.
├── setup.sh          # Server provisioning & firewall configuration
├── monitor.sh        # Health monitoring (CPU, RAM, Disk, Nginx)
├── logger.py         # Simulates heavy production log generation
├── sentry.sh         # Disk usage watchdog
└── README.md
```

---

# ✅ Outcome

After completing all steps, your Ubuntu server will have:

- 🔒 A secured firewall using UFW
- 🌐 Nginx configured as a reverse proxy
- 📊 Automated system health monitoring
- 📝 Continuous production log simulation
- 💾 Automatic log compression and rotation
- 🛡️ Disk saturation protection using Cron + Logrotate
