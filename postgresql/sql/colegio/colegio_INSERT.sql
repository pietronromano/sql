/*
    
    ###############################################################
*/

-- Schema por defecto es "public"
SHOW search_path;
-- fijar el Schema por defecto, donde se crean las tablas
SET search_path = colegio; 


-- alumnos ----------------------------------------------------------------
-- id_alumno se genera automáticamente al ser SERIAL
insert into alumnos
	(dni, nombres, apellidos, fecha_nacimiento, email, comentarios)
VALUES
	('76983214G', 'Juan', 'Romero', '2003-02-09', 'juanromero@gmail.com',NULL),
	('23451234J', 'Pablo', 'Guzman', '2003-12-23', 'pablog@gmail.com',NULL),
	('90078432Y', 'Julian', 'Martin', '2003-08-16', 'julianmartin@gmail.com',NULL),
	('54678908I', 'Javier', 'Maroto', '2003-12-12', 'javierm@gmail.com','un comentario...'),
	('55467234X', 'Alvaro', 'Sotogrande', '2003-04-19', 'alvaros@gmail.com','otro comentario...'),
	('45457890G', 'Felipe', 'Cano', '2003-07-28', 'felipec@gmail.com','un comentario...'),
	('34126789K', 'Andres', 'Penelope', '2003-10-11', 'andresp@gmail.com','otro comentario...')
	RETURNING *;



-- cursos ----------------------------------------------------------------

INSERT INTO cursos 
	(id_curso, nombre)
VALUES 
	('1', 'Primer Curso'), 
	('2', 'Segundo Curso')
RETURNING *;


-- matriculas ----------------------------------------------------------------
-- id_matricula se genera automáticamente al ser SERIAL
INSERT INTO matriculas
	( id_alumno, id_curso)
VALUES  
	(14,  '1'),
	(15,  '1'),
	(16,  '1'),
	(17,  '2'),
	(18,  '2'),
	(19,  '2'),
	(20,  '2')
RETURNING *;


SELECT * from matriculas;



