#!/bin/sh

#Config xray
UUID=ad806487-2d26-4636-98b6-ab85cc8521f7
PORT=80
rm -rf /etc/xray/config.json
cat << EOF > /etc/xray/config.json
{
    "inbounds": 
    [
        {
      "port": $PORT,
			"protocol": "vmess",
            "settings": {
			"clients": [
			{
			"id": "$AUUID"
			}
			]
			},
            "streamSettings": {
			"network": "ws",
			"wsSettings": {
			"path": "/$AUUID-vmess"
			}
			}
        },
        {
             "port": $PORT,
			"protocol": "vless",
            "settings": {
			"clients": [
			{
			"id": "$AUUID"
			}
			],
			"decryption": "none"
			},
            "streamSettings": {
			"network": "ws",
			"wsSettings": {
			"path": "/$AUUID-vless"
			}
			}
        },
        {
                "port": $PORT,
			"protocol": "trojan",
            "settings": {
			"clients": [
			{
			"password":"$AUUID"
			}
			]
			},
            "streamSettings": {
			"network": "ws",
			"wsSettings": {
			"path": "/$AUUID-trojan"
			}
			}
        }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF

#run xray

xray -c /etc/xray/config.json
