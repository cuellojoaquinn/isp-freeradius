#!/bin/bash
# Muestra radacct legible: horas locales y bytes en MB.
docker exec postgres psql -U postgres -d radius -c "
SELECT radacctid AS id, username AS abonado,
       to_char(acctstarttime  AT TIME ZONE 'America/Argentina/Mendoza', 'HH24:MI:SS') AS inicio,
       to_char(acctupdatetime AT TIME ZONE 'America/Argentina/Mendoza', 'HH24:MI:SS') AS ult_update,
       to_char(acctstoptime   AT TIME ZONE 'America/Argentina/Mendoza', 'HH24:MI:SS') AS fin,
       acctsessiontime AS seg,
       round(acctinputoctets  / 1e6, 2) AS subida_mb,
       round(acctoutputoctets / 1e6, 2) AS bajada_mb,
       acctterminatecause AS causa
FROM radacct ORDER BY radacctid;"
