/*
    ---TODO - change from colegio
    ###############################################################
*/

-- fijar el Schema por defecto
SET search_path = comercio; 

-- Usar "RETURNING" para obtener los nuevos valores automáticamente
UPDATE clientes SET apellidos = 'Apellidos Modficado' WHERE nif = '11111111A'
RETURNING *;


--Intentar poner fecha_alta a NULL, no está permitido
UPDATE clientes SET fecha_alta = NULL WHERE id_cliente = 1;
    --null value in column "fecha_alta" of relation "clientes" violates not-null constraint
    --DETAIL: Failing row contains (1, 11111111A, Nombres1, Apellidos Modficado, null, t, Commentarios 1).


