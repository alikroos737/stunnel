#!/bin/bash
# setup_stunnel_client_interactive.sh

read -p "لطفا آی‌پی سرور مقصد را وارد کنید: " DEST_IP

if [[ -z "$DEST_IP" ]]; then
  echo "آی‌پی وارد نشده. اسکریپت متوقف شد."
  exit 1
fi

apt update
apt install -y stunnel4

cat > /etc/stunnel/stunnel-client.conf <<EOF
client = yes
foreground = yes
pid = /var/run/stunnel-client.pid
debug = 7

[http]
accept = 80
connect = $DEST_IP:8880

[https]
accept = 443
connect = $DEST_IP:8444
EOF

sed -i 's/ENABLED=0/ENABLED=1/' /etc/default/stunnel4

systemctl restart stunnel4

echo "stunnel روی سرور ایران با اتصال به $DEST_IP راه‌اندازی شد."
echo "برای تست دستی اجرای stunnel:"
echo "    stunnel /etc/stunnel/stunnel-client.conf"
