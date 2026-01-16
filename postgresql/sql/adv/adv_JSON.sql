/*
Using JSON in PostgreSQL
REFS: 
    - https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Scripting/JSON
    - https://www.postgresql.org/docs/current/datatype-json.html
    - https://www.postgresql.org/docs/current/functions-json.html
    - https://www.udemy.com/course/postgresqlmasterclass/learn/lecture/23207334#overview
*/

DROP TABLE IF EXISTS products_json;

-- Creating a table with JSON columns
CREATE TABLE products_json (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    attributes_json JSON,
    metadata_json JSONB
);

-- Inserting JSON data
INSERT INTO products_json (name, attributes_json, metadata_json) VALUES
    ('Laptop', '{"brand": "Dell", "ram": "16GB", "storage": "512GB"}', '{"warranty": "2 years", "rating": 4.5}'),
    ('Phone', '{"brand": "Apple", "model": "iPhone 14", "color": "black"}', '{"warranty": "1 year", "rating": 4.8}');

SELECT * FROM products_json;

-- Querying JSON data with -> (returns JSON)
SELECT name, attributes_json->'brand' AS brand
FROM products_json;

-- Querying JSON data with ->> (returns text)
SELECT name, attributes_json->>'brand' AS brand
FROM products_json
WHERE attributes_json->>'brand' = 'Dell';

-- Accessing nested JSON
SELECT name, metadata_json->>'warranty' AS warranty
FROM products_json;

-- Using JSONB operators for containment
SELECT * FROM products_json
WHERE metadata_json @> '{"rating": 4.5}';

-- Filtering by JSON property
SELECT * FROM products_json
WHERE (attributes_json->>'ram') IS NOT NULL;

-- Updating JSON fields
UPDATE products_json
SET metadata_json = jsonb_set(metadata_json, '{warranty}', '"3 years"')
WHERE name = 'Laptop';

-- Adding new JSON property
UPDATE products_json
SET metadata_json = metadata_json || '{"certified": true}'::jsonb
WHERE id = 1;

-- JSON aggregation
SELECT json_agg(json_build_object('name', name, 'brand', attributes_json->>'brand'))
FROM products_json;

-- Creating JSON from query results
SELECT row_to_json(p) FROM products_json p;

-- Expanding JSON to rows
SELECT * FROM json_each('{"a": 1, "b": 2}');