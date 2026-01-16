/*
    WITH clauses (CTE Expressions) with Northwind

    SEE: 
        - https://www.udemy.com/course/postgresqlmasterclass/learn/lecture/24193332#overview
        - https://www.postgresql.org/docs/current/queries-with.html
*/

SET search_path TO northwind;

--??? NOT SURE THERE ARE ANY... Orders with duplicate line items
WITH duplicate_entries AS 
(
    SELECT
        order_id,
        quantity
    FROM order_details
    GROUP BY
        order_id,
        product_id
    HAVING
        COUNT(*) > 1
    ORDER BY
        order_id
)
SELECT *
FROM order_details
WHERE
    order_id IN (SELECT order_id FROM duplicate_entries)
ORDER BY
    order_id;


-- Late orders
WITH late_orders AS
(
    SELECT
        employee_id,
        COUNT(*) as count_late_orders
    FROM orders
    WHERE
        shipped_date > required_date
    GROUP BY
        employee_id
),
all_orders AS 
(
    SELECT
        employee_id,
        COUNT(*) as count_all_orders
    FROM orders
    GROUP BY
        employee_id
)
SELECT
    e.employee_id,
    e.first_name,
    all_orders.count_all_orders,
    late_orders.count_late_orders
FROM employees e
JOIN all_orders ON all_orders.employee_id = e.employee_id
JOIN late_orders ON late_orders.employee_id = e.employee_id
ORDER BY 
    late_orders.count_late_orders DESC;

-- Countries with Customers OR Suppliers
-- FULL JOIN retrieves rows from either side
WITH countries_suppliers AS 
(
    SELECT DISTINCT country FROM suppliers
),
countries_customers AS 
(
    SELECT DISTINCT country FROM customers
)
SELECT
    cs.country AS country_suppliers, cc.country as customer_suppliers
FROM countries_suppliers cs
FULL JOIN countries_customers cc ON cc.country = cs.country;

-- First Order from each country
-- Window function

WITH orders_by_country AS
(
    SELECT  
        ship_country,
        order_id,
        order_date,
        ROW_NUMBER() OVER (PARTITION BY ship_country ORDER BY ship_country, order_date) country_row_number
    FROM    
        orders
)
SELECT
    *
FROM
    orders_by_country
WHERE
    country_row_number = 1
ORDER BY
    ship_country;

