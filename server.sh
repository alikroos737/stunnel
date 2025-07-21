#!/bin/bash
# setup_stunnel_server.sh
# روی سرور مقصد اجرا شود

apt update
apt install -y stunnel4

cat > /etc/stunnel/stunnel-server.conf <<EOF
pid = /var/run/stunnel-server.pid
foreground = yes
debug = 7

[http]
accept = 443
connect = 127.0.0.1:1080

[https]
accept = 800
connect = 127.0.0.1:1080
EOF

# اجازه بده stunnel اجرا بشه
sed -i 's/ENABLED=0/ENABLED=1/' /etc/default/stunnel4

systemctl restart stunnel4

# اجرا دستی برای تست
stunnel /etc/stunnel/stunnel-server.conf
