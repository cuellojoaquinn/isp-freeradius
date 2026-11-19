# Grafana

Acá va el `docker-compose.yml` de Grafana (a cargo de otro integrante).

Si existe `grafana/docker-compose.yml`, `vagrant up grafana` lo levanta solo.

Datos para conectar Grafana a PostgreSQL:

| Campo | Valor |
|---|---|
| Host | `10.10.10.20:5432` |
| Base | `radius` |
| Usuario | `grafana` (solo lectura) |
| Contraseña | `GRAFANA_DB_PASSWORD` de `db/.env` |
| Tablas visibles | `radacct`, `radpostauth`, `radusergroup`, `radgroupreply`, `nas` |

`pg_hba.conf` solo acepta al usuario `grafana` desde `10.10.10.30`. Las horas de `radacct` están en UTC (Grafana las convierte a la zona del navegador).
