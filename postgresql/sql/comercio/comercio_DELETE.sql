/*
    Suprimir registros
    ###############################################################
*/

-- fijar el Schema por defecto
SET search_path = comercio; 


-- Insertar un registro para luego borrarlo
insert into clientes
	(nif, nombres, apellidos, fecha_alta)
VALUES
	('9999999', 'Mr', 'X', '2001-01-01');

SELECT * FROM clientes WHERE nif = '9999999'
RETURNING *;

INSERT INTO pedidos
	(id_cliente,fecha,pagado,comentarios)
VALUES
	(8, '2001-01-01', TRUE,'Commentarios 1');

-- DA ERROR: existe un registro en pedidos que se quedaría huerfano
DELETE FROM clientes  WHERE nif = '9999999';
	-- update or delete on table "clientes" violates foreign key constraint "fk_cliente" on table "pedidos"
	-- DETAIL: Key (id_cliente)=(8) is still referenced from table "pedidos".


--Hay que eliminar el registro en pedidos primero
DELETE FROM pedidos  WHERE id_cliente = 8;
--Ahora funciona
DELETE FROM clientes  WHERE nif = '9999999';

