# R2 = abonado1 (MikroTik CHR como cliente PPPoE)
# Export de RouterOS 7.20.4 — /export oculta la contraseña del pppoe-client.
# Para recrearlo: agregar password=<contraseña de abonado1> al pppoe-client.
#
/interface ethernet
set [ find default-name=ether2 ] name=ether3
/interface vlan
add interface=ether3 name=vlan-acceso vlan-id=100
/interface pppoe-client
add add-default-route=yes disabled=no interface=vlan-acceso name=wan-pppoe \
    user=abonado1
/port
set 0 name=serial0
set 1 name=serial1
/ip dhcp-client
add interface=ether1
/system identity
set name=R2
