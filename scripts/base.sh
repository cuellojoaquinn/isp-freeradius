#!/bin/bash
# Provisión común a todas las VMs: DNS fijo y Docker.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

# DNS persistente (lección de la bitácora: el DHCP pisaba /etc/resolv.conf)
if ! grep -q '^supersede domain-name-servers' /etc/dhcp/dhclient.conf; then
  echo 'supersede domain-name-servers 8.8.8.8, 1.1.1.1;' >> /etc/dhcp/dhclient.conf
fi
echo "nameserver 8.8.8.8" > /etc/resolv.conf

apt-get update -q
apt-get install -y -q docker.io docker-compose postgresql-client freeradius-utils
usermod -aG docker vagrant
