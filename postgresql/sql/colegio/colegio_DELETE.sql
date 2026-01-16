/*
    
    ###############################################################
*/

-- fijar el Schema por defecto
SET search_path = colegio; 


-- Insertar un registro para luego borrarlo
insert into alumnos
	(dni, nombre, apellidos, fecha_nacimiento, email)
VALUES
	('9999999', 'Mr', 'X', '2001-01-01', 'mrx@gmail.com');

SELECT * FROM alumnos WHERE dni = '9999999';

INSERT INTO matriculas
	(id_alumno, id_curso)
VALUES  
	( '9999999', '1º')
RETURNING id_matricula;

SELECT * FROM matriculas WHERE id_matricula = 10;


SELECT * FROM alumnos WHERE dni = '9999999';


-- DA ERROR: existe un registro en matriculas que se quedaría huerfano
DELETE FROM alumnos  WHERE dni = '9999999';
    --update or delete on table "alumnos" violates foreign key constraint "fk_alumno" on table "matriculas"
    --DETAIL: Key (dni)=(9999999) is still referenced from table "matriculas".

--Hay que eliminar el registro en matriculas primero
DELETE FROM matriculas  WHERE id_matricula = 10;
--Ahora funciona
DELETE FROM alumnos  WHERE dni = '9999999';

