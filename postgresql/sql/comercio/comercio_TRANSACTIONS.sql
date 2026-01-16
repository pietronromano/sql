/*
    Transacciones
    REFS: 
        - https://www.udemy.com/course/postgresqlmasterclass/learn/lecture/23510400#overview
        - https://www.postgresql.org/docs/current/transaction-iso.html
*/
SET search_path = comercio; 

BEGIN;
-- Actualizar
UPDATE clientes SET apellidos = 'Apellidos' WHERE nif = '11111111A';

--Se ve la actualización en esta sesión, pero no desde otras
SELECT * FROM clientes  WHERE nif = '11111111A';

-- Deshacer la transacción
ROLLBACK;

-- Confirmar la transacción
COMMIT;