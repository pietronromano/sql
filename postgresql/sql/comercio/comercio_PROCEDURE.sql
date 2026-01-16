/*

    SEE:
        - https://www.postgresql.org/docs/current/sql-createprocedure.html

    USAGE: call (pedidos_insert(num_pedidos)
*/

SET search_path TO comercio;

-- pedidos_insert ------------------------------------------------
DROP PROCEDURE IF EXISTS pedidos_insert;

CREATE OR REPLACE PROCEDURE pedidos_insert(num_pedidos integer) 
LANGUAGE plpgsql
AS $$
DECLARE 
    ultimo_id_pedido int;
BEGIN
    FOR i IN 1..num_pedidos LOOP
        WITH ultimo_pedido as(
            INSERT INTO pedidos
                (id_cliente,fecha,pagado,comentarios)
            VALUES
                (1, '2001-01-01', TRUE,'Commentarios ' || i)
            RETURNING id_pedido
        )
        -- Save the last SERIAL id generated into ultimo_id_pedido 
        SELECT id_pedido FROM ultimo_pedido INTO ultimo_id_pedido;

        INSERT INTO pedidos_productos
	        (id_pedido, id_producto, cantidad,comentarios)
        VALUES
            (ultimo_id_pedido,'be3de19e-f6ee-4393-8b6b-23bfbf3ee9f5',i,'Comentarios ' || i);
    END LOOP;

END;
$$;


-- Llamar al procedimiento
CALL pedidos_insert(10);

SELECT pedidos.id_pedido, pedidos_productos.id_producto, pedidos_productos.cantidad FROM pedidos
INNER JOIN pedidos_productos ON pedidos_productos.id_pedido = pedidos.id_pedido;

