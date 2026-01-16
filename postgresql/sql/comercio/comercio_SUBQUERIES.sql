/*
    --Ejemplos de sub-consulta: Suqueriess
    ###############################################################
*/

-- fijar el Schema por defecto
SET search_path TO comercio; 

--Ver los precios de productos
SELECT id_producto,precio, nombre  FROM productos;


/*
    Tipo Subquery 1: Una columna, una fila: "Scalar Value"
    ###############################################################  
*/

-- Media de productos
SELECT CAST(AVG(precio) AS integer) as avg_precio FROM productos;

-- Combinar en clausula FROM 
SELECT id_producto, nombre,precio, 
(
    SELECT CAST(AVG(precio) AS integer) as avg_precio  FROM productos
) 
FROM productos;

-- Seleccionar productoswhere el precio > la media de precios de productos
-- Combinar en clausula WHERE
SELECT id_producto, nombre,precio  FROM productos
WHERE precio > (
    SELECT CAST(AVG(precio) AS integer) as avg_precio  FROM productos
);

-- Seleccionar productos de pedidos_productos where el precio > la media de precios de productos
SELECT p.id_producto, p.nombre,p.precio  
FROM productos p
INNER JOIN pedidos_productos pp ON pp.id_producto = p.id_producto
WHERE precio > (
    SELECT CAST(AVG(precio) AS integer) as avg_precio  FROM productos
);

-- Obtener la media del número de pedidos por cliente
SELECT AVG(numero_pedidos)
FROM (
    SELECT id_cliente, COUNT(*) as numero_pedidos
    FROM comercio.pedidos
    GROUP BY id_cliente
); 