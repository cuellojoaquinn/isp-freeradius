#!/bin/bash
# Crea los usuarios de la base con permisos mínimos.
# Es .sh (y no .sql) para leer las contraseñas de variables de entorno (db/.env).
set -euo pipefail

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<EOSQL
-- FreeRADIUS: lee la config de abonados y escribe accounting. Sin DELETE.
CREATE ROLE radius LOGIN PASSWORD '${RADIUS_DB_PASSWORD}';
GRANT SELECT ON radcheck, radreply, radgroupcheck, radgroupreply,
                radusergroup, nas, nasreload TO radius;
GRANT SELECT, INSERT, UPDATE ON radacct, radpostauth, nasreload TO radius;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO radius;

-- Grafana: solo lectura, sin acceso a radcheck (contraseñas en claro por CHAP).
CREATE ROLE grafana LOGIN PASSWORD '${GRAFANA_DB_PASSWORD}';
GRANT SELECT ON radacct, radpostauth, radusergroup,
                radgroupreply, nas TO grafana;
EOSQL
