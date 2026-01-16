/*
    WITH, CTEs
    REFS: 
        - https://www.postgresql.org/docs/18/queries-with.html
        - Learn PostreSQL - Second Edition, Chapter 5 Advanced Statements->  Exploring CTEs
*/
SET search_path = comercio; 

-- CTE
WITH precios_productos AS (
    SELECT
    pedidos_productos.id_producto,
    id_cliente,
    nombre as nombre_producto,
    precio,
    (
        CASE
            WHEN precio < 1000 THEN 'BARATO'
            WHEN precio > 2000 THEN 'CARO'
            ELSE 'NORMAL'
        END
    ) as rango_precio
    FROM productos
    INNER JOIN pedidos_productos ON pedidos_productos.id_producto = productos.id_producto
    INNER JOIN pedidos ON pedidos.id_pedido = pedidos_productos.id_pedido
)
SELECT DISTINCT
    clientes.id_cliente, precios_productos.nombre_producto, precio, rango_precio
FROM clientes 
INNER JOIN precios_productos ON precios_productos.id_cliente = clientes.id_cliente;


/*
    Recursive CTE: para crear un árbol
*/
WITH RECURSIVE arbol_categorias AS (
     -- non recursive statement: categories sin padre, nivel empieza en 0
     -- CAST(categoria AS text) se requiere porque la expresión recursiva abajo es tipo "text": arbol_categorias.categoria || ' -> ' || categorias.categoria 
     SELECT id_categoria,id_padre,CAST(categoria AS text) AS arbol, 0 AS nivel
     FROM categorias WHERE id_padre IS NULL
     UNION 
     -- recursive statement
     SELECT categorias.id_categoria, categorias.id_padre,arbol_categorias.arbol || ' -> ' || categorias.categoria,  arbol_categorias.nivel + 1
     FROM categorias
     JOIN arbol_categorias  ON arbol_categorias.id_categoria = categorias.id_padre
)
SELECT id_categoria, id_padre, nivel, arbol FROM arbol_categorias
order by nivel; 

