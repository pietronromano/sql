
/*
    Admin queries related to Indexes
    REFS: 
        - https://www.postgresql.org/docs/18/monitoring-stats.html
        - Learn PostreSQL - Second Edition, 13 Query Tuning, Indexes, and Performance Optimization
*/

--Minimum size
SHOW  min_parallel_table_scan_size;

-- Query the cluster about the main costs involved in a node execution:
SELECT name, setting
 FROM pg_settings
 WHERE name LIKE 'cpu%\_cost'
 OR name LIKE '%page\_cost'
 ORDER BY setting DESC;


-- Statistics  ------------
-- tables
SELECT * FROM pg_stat_all_tables
WHERE schemaname = 'northwind';

SELECT * FROM pg_stat_all_indexes
WHERE schemaname = 'comercio';