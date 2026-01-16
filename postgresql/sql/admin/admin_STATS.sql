
/*
    Admin queries related to Table Size
    REFS: 
        - https://www.postgresql.org/docs/18/catalogs.html
        - https://www.udemy.com/course/postgresqlmasterclass/learn/lecture/24017104#overview
        - Learn PostreSQL - Second Edition, 13 Query Tuning, Indexes, and Performance Optimization
*/


-- Get the namespaces
SELECT * FROM pg_namespace;
-- Tables, Relations, Indexes
SELECT  * FROM pg_class

-- Specific to northwind
SET search_path TO northwind;

-- Size of orders table
SELECT pg_size_pretty(pg_relation_size('orders'));
-- Size of orders indexes
SELECT pg_size_pretty(pg_indexes_size('orders'));

-- Join
SELECT  pg_class.oid, relkind, reltuples, pg_size_pretty( pg_relation_size( pg_class.oid ) ), relname
FROM pg_class 
INNER JOIN pg_namespace ON pg_namespace.oid = pg_class.relnamespace
WHERE pg_namespace.nspname = 'northwind';
--WHERE relname LIKE 'productos%';



