#!/bin/bash

#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
CREATE USER pleroma WITH ENCRYPTED PASSWORD 'pleroma';
CREATE DATABASE pleroma OWNER pleroma;
\c pleroma;
CREATE EXTENSION IF NOT EXISTS citext;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
EOSQL