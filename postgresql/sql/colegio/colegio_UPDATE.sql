/*
    Update
    ###############################################################
*/

-- fijar el Schema por defecto
SET search_path = colegio; 

UPDATE alumnos SET apellidos = 'Romero Blanco' WHERE dni = '76983214G';
SELECT * FROM alumnos WHERE dni = '76983214G';

--Intentar poner fecha_nacimiento < 2000, no está permitido según check constraint "chk_edad"
UPDATE alumnos SET fecha_nacimiento = '1999-12-31' WHERE dni = '76983214G';
    --new row for relation "alumnos" violates check constraint "chk_edad"
    --DETAIL: Failing row contains (76983214G, Juan, Romero, 1999-12-31, juanromero@gmail.com, null).

-- Usar "RETURNING" para obtener los nuevos valores automáticamente
UPDATE matriculas SET fecha_matricula = '2025-11-01' WHERE id_matricula = 1
RETURNING id_matricula, fecha_matricula;

