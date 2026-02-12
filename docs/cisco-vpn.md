# Cisco Secure Client

In order to connect to AU's VPN we need Cisco Secure Client.
I use the AUR Package titled cisco-secure-client.

Sometimes you need to make sure the VPN agent is enabled.
Here are commands for that:

Check the service status:

```bash
bashsudo systemctl status vpnagentd
```

If it's not running, start and enable it:

```
bashsudo systemctl start vpnagentd
sudo systemctl enable vpnagentd
```
