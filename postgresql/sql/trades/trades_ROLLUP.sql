
SET search_path = trades; 

-- 4326
SELECT COUNT (*) FROM trades; 

-- Regions
SELECT DISTINCT (region) FROM TRADES ORDER BY region;

SELECT DISTINCT (region) FROM TRADES ORDER BY region;

-- Countries (206)
SELECT DISTINCT (country) FROM TRADES ORDER BY country;

-- 1988 2019
SELECT MIN(year), MAX(year) FROM trades;

-- Note: USA comes out as SOUTH AMERICA
SELECT * FROM trades WHERE country = 'USA' ORDER BY year;

-- Aggregates with GROUP BY
SELECT
    region,
    country,
    ROUND(MIN (imports)/1000000,0) AS min,
    ROUND(MAX (imports)/1000000,0) AS max,
    ROUND(AVG (imports)/1000000,0) AS avg
FROM trades
GROUP BY region,country
ORDER BY region,country

-- Applying Grouping Sets: ROLLUP gives an additional line as sum (region is NULL)
SELECT
    region,
    ROUND(MIN (imports)/1000000,0) AS min,
    ROUND(MAX (imports)/1000000,0) AS max,
    ROUND(AVG (imports)/1000000,0) AS avg
FROM trades
GROUP BY ROLLUP (region)
ORDER BY region DESC NULLS FIRST

-- Group by country also
SELECT
    region,country,
    ROUND(MIN (imports)/1000000,0) AS min,
    ROUND(MAX (imports)/1000000,0) AS max,
    ROUND(AVG (imports)/1000000,0) AS avg
FROM trades
GROUP BY ROLLUP (region,country)
ORDER BY region DESC NULLS FIRST,country DESC NULLS FIRST;

-- Use windowing function OVER to get an average in the same query
-- NOTE: can't use ROUND or /1000000 FOR avg_exports
SELECT 
    country, year, imports, exports, 
    avg(exports) OVER() as avg_exports
    FROM trades;

SELECT 
    country, year, imports, exports, 
    avg(exports) OVER(PARTITION BY country) as avg_exports
    FROM trades;


SELECT 
    year,
    imports,
    ROW_NUMBER() OVER (ORDER BY imports DESC)
FROM TRADES 
WHERE
    country = 'France';