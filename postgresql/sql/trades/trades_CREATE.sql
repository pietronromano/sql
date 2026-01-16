/*
    Trades DB - datos para consultas con GROUP BY, ROLLUP, WINDOWS
    https://comtradeplus.un.org/TradeFlow
    https://www.udemy.com/course/postgresqlmasterclass/learn/lecture/24231266#overview
*/

SHOW search_path;
-- fijar el Schema por defecto, donde se crean las tablas
SET search_path = trades; 

-- Eliminar tablas y esquema si ya existen: permite empezar de cero
DROP TABLE IF EXISTS trades; -- quitar esta primero, porque hace referencia a otras

-- Eliminar Schema último
DROP SCHEMA IF EXISTS trades;

-- Crear un Schema ----------------------------------------------------------------
CREATE SCHEMA trades;

CREATE TABLE trades (
    region text,
    country text,
    year int,
    imports numeric(50,0),
    exports numeric(50,0)
)