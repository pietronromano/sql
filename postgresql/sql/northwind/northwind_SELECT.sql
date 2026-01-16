/*
    SELECT examples with Northwind
    SEE: https://www.udemy.com/course/postgresqlmasterclass/learn/lecture/24193332#overview
*/

SET search_path TO northwind;

-- Orders shipping to USA or France (SEE _index.sql to see effect of adding index)
SELECT * FROM orders
WHERE ship_country = 'USA' OR ship_country = 'France'
ORDER BY ship_country;

-- List products that need re-ordering:
-- units_in_stock <= reorder_level
SELECT 
    product_id,
    product_name,
    units_in_stock,
    reorder_level
FROM products
WHERE
    units_in_stock < reorder_level
ORDER BY product_name;


-- Customers with no orders
-- Use a LEFT JOIN: all customers joined to orders - whether have orders or not
SELECT
    c.company_name,
    c.customer_id,
    o.customer_id as orders_customer_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE
    o.customer_id IS NULL