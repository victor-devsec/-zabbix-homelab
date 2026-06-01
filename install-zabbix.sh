#!/bin/bash
# Zabbix 7.0 Installation Script
# Ubuntu Server 26.04 LTS
# Author: victor-devsec
# Date: 2026-06-01

echo "======================================"
echo " Zabbix 7.0 HomeLab Installation"
echo "======================================"

# Update system
echo "[1/6] Updating system..."
apt update && apt upgrade -y

# Install dependencies
echo "[2/6] Installing dependencies..."
apt install -y curl wget mysql-server

# Download Zabbix repository
echo "[3/6] Adding Zabbix repository..."
curl -L https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu26.04_all.deb -o /tmp/zabbix-release.deb
dpkg -i /tmp/zabbix-release.deb
apt update

# Install Zabbix
echo "[4/6] Installing Zabbix..."
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# Configure Apache PHP-FPM
echo "[5/6] Configuring Apache..."
a2enmod proxy proxy_http proxy_fcgi setenvif
a2enconf php8.5-fpm
systemctl start php8.5-fpm

# Enable services
echo "[6/6] Enabling services..."
systemctl enable zabbix-server zabbix-agent apache2 mysql php8.5-fpm
systemctl restart zabbix-server zabbix-agent apache2

echo "======================================"
echo " Installation complete!"
echo " Access: http://YOUR-IP/zabbix"
echo " Default user: Admin"
echo " Default pass: zabbix"
echo "======================================"
