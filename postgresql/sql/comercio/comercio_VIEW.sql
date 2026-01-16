/*
    --Ejemplos de Views
    ###############################################################
*/

-- fijar el Schema por defecto, dos maneras
SET search_path TO comercio; 

-- Seleccionar de clientes y pedidos 
CREATE OR REPLACE VIEW vw_clientes_pedidos AS
SELECT 
    clientes.id_cliente, nombres, clientes.apellidos, pedidos.fecha, pedidos.pagado
FROM clientes 
INNER JOIN pedidos 
ON pedidos.id_cliente = pedidos.id_cliente;

SELECT * FROM vw_clientes_pedidos;


-- Seleccionar de clientes y sus productos comprados
CREATE OR REPLACE VIEW vw_clientes_productos AS
SELECT DISTINCT
    clientes.id_cliente, productos.nombre as producto
FROM clientes 
INNER JOIN pedidos ON pedidos.id_cliente = pedidos.id_cliente
INNER JOIN pedidos_productos ON pedidos_productos.id_pedido = pedidos.id_pedido
INNER JOIN productos ON productos.id_producto = pedidos_productos.id_producto
ORDER BY clientes.id_cliente,producto;

SELECT * FROM vw_clientes_productos;


  