/*
    GROUP BY examples with Northwind
    SEE: 
        - https://www.postgresql.org/docs/18/queries-table-expressions.html#QUERIES-GROUP
        - https://www.udemy.com/course/postgresqlmasterclass/learn/lecture/24193332#overview

    After passing the WHERE filter, the derived input table might be subject to grouping, 
    using the GROUP BY clause
    and elimination of group rows using the HAVING clause.

    SELECT select_list
        FROM ...
        [WHERE ...]
        GROUP BY grouping_column_reference [, grouping_column_reference]...
*/

SET search_path TO northwind;

-- Total number of orders shipped to USA or France
SELECT ship_country, COUNT(*) FROM orders
WHERE ship_country = 'USA' OR ship_country = 'France'
GROUP BY ship_country
ORDER BY ship_country;

--  Show total order amount for each order
-- Sum per line item
SELECT
    order_id,
    product_id,
    unit_price,
    quantity,
    discount,
    ((unit_price * quantity) - discount) as total_order_amount
FROM order_details
ORDER BY order_id;



-- Group by order_id to get one line per Order, with its total: 
SELECT
    order_id,
    SUM(((unit_price * quantity) - discount)) as total_order_amount
FROM order_details
GROUP BY order_id
ORDER BY order_id;


-- Total products in each category
SELECT
    c.category_name,
    COUNT(*) as total_products
FROM products p
INNER JOIN categories c on c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY total_products DESC;

-- List freight charges in year 1997,  > 500
SELECT
    ship_country,
    MAX(freight) AS max_freight
FROM orders
WHERE
    order_date BETWEEN ('1997-01-01') AND ('1997-12-31')
GROUP BY ship_country
HAVING  MAX(freight) > 500
ORDER BY max_freight DESC 


-- List top 5 highest freight charges in year 1997
SELECT
    ship_country,
    MAX(freight) AS max_freight
FROM orders
WHERE
    order_date BETWEEN ('1997-01-01') AND ('1997-12-31')
GROUP BY ship_country
ORDER BY max_freight DESC 
LIMIT 5;

-- Top 10 Customers with and their total order amount spend
SELECT
    c.customer_id,
    c.company_name,
    SUM(((od.unit_price * od.quantity) - od.discount)) as total_amount
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_details od ON od.order_id = o.order_id
GROUP BY
    c.customer_id,
    c.company_name
ORDER BY total_amount DESC
LIMIT 10;
