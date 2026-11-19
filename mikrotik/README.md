# MikroTik

| Archivo | Equipo |
|---|---|
| `r1.rsc` | R1: NAS / servidor PPPoE `isp` sobre `vlan-acceso`, solo CHAP, RADIUS en `10.10.10.10` |
| `r2-abonado1.rsc` | R2: abonado1, cliente PPPoE `wan-pppoe` sobre `vlan-acceso` (VLAN 100) |

Guardar acá el export de R1:

```
/export file=r1
```

y bajar `r1.rsc` desde *Files*. En RouterOS 7, `/export` oculta los datos sensibles por defecto (secret del RADIUS, contraseñas de `/ppp secret`), así que se puede subir tal cual. **No usar `show-sensitive`** para el archivo del repo.

Configuración clave de R1 para RADIUS:

```
/ip address add address=10.10.10.1/24 interface=ether1 comment="gestion"
/radius add address=10.10.10.10 secret=<RADIUS_SECRET_R1> service=ppp \
    authentication-port=1812 accounting-port=1813 timeout=3s
/ppp profile add name=pppoe-base-radius local-address=100.64.0.1 remote-address=pool-pppoe
/interface pppoe-server server set [find service-name=isp] default-profile=pppoe-base-radius
/ppp aaa set use-radius=yes accounting=yes interim-update=5m
/system logging add topics=radius,debug action=memory
```
