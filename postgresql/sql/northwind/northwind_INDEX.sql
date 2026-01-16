SET search_path TO northwind;

-- order_details ------------------
SELECT COUNT (*) FROM order_details;

DROP INDEX IF EXISTS idx_order_details_product_id;
--Antes de crear el indice
EXPLAIN SELECT * FROM order_details where product_id = 20;
    -->QUERY PLAN
    -->Seq Scan on order_details  (cost=0.00..38.94 rows=16 width=14)
      -->Filter: (product_id = 20)

CREATE INDEX idx_order_details_product_id ON order_details(product_id);

--Después de crear el indice
EXPLAIN SELECT * FROM order_details where product_id = 20;
  /*
    QUERY PLAN
    Bitmap Heap Scan on order_details  (cost=4.40..17.22 rows=16 width=14)
      Recheck Cond: (product_id = 20)
       ->  Bitmap Index Scan on idx_order_details_product_id  (cost=0.00..4.40 rows=16 width=0)
             Index Cond: (product_id = 20)
  */
-- orders ------------


DROP INDEX IF EXISTS idx_orders_ship_country;
--Antes de crear el indice
EXPLAIN SELECT * FROM orders
WHERE ship_country = 'USA' OR ship_country = 'France'
ORDER BY ship_country;
  /*
  QUERY PLAN
  Sort  (cost=33.55..34.02 rows=188 width=90)
    Sort Key: ship_country
    ->  Seq Scan on orders  (cost=0.00..26.45 rows=188 width=90)
          Filter: (((ship_country)::text = 'USA'::text) OR ((ship_country)::text = 'France'::text))
  */

CREATE INDEX idx_orders_ship_country ON orders(ship_country);

--Después de crear el indice
EXPLAIN SELECT * FROM orders
WHERE ship_country = 'USA' OR ship_country = 'France'
ORDER BY ship_country;
  /*
  QUERY PLAN
  Sort  (cost=29.78..30.25 rows=188 width=90)
    Sort Key: ship_country
    ->  Bitmap Heap Scan on orders  (cost=5.69..22.67 rows=188 width=90)
          Filter: (((ship_country)::text = 'USA'::text) OR ((ship_country)::text = 'France'::text))
          ->  Bitmap Index Scan on idx_orders_ship_country  (cost=0.00..5.64 rows=199 width=0)
                Index Cond: (ship_country = ANY ('{USA,France}'::text[]))
  */
