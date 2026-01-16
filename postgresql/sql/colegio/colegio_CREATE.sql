/*
    Crear tablas para la gestión de un colegio:
    ###############################################################

	SEE:
	- https://www.postgresql.org/docs/current/ddl-constraints.html
	
	CASCADE specifies that when a referenced row is deleted, row(s) referencing it should be automatically deleted as well.
*/
-- Schema por defecto es "public"
SHOW search_path;
-- fijar el Schema por defecto, donde se crean las tablas
SET search_path = colegio; 

-- Eliminar tablas y esquema si ya existen: permite empezar de cero
DROP TABLE IF EXISTS matriculas; -- quitar esta primero, porque hace referencia a otras
DROP TABLE IF EXISTS cursos; -- después de matriculas, que le hace referencia
DROP TABLE IF EXISTS alumnos; -- después de matriculas, que le hace referencia

-- Eliminar Schema último
DROP SCHEMA IF EXISTS colegio;

-- Crear un Schema ----------------------------------------------------------------
CREATE SCHEMA colegio;

/*
-- alumnos ----------------------------------------------------------------
-- Ejemplos de constraints: 
	dni unique
	email unique
	fecha_nacimiento > 2000
*/
CREATE TABLE alumnos(
	id_alumno SERIAL PRIMARY KEY,
	dni VARCHAR(20) UNIQUE NOT NULL,
	nombres VARCHAR(100) NOT NULL,
	apellidos VARCHAR(100) NOT NULL,
	fecha_nacimiento DATE NOT NULL CONSTRAINT chk_edad CHECK (fecha_nacimiento > '2000-01-01'),
	email VARCHAR(100) CONSTRAINT unique_email UNIQUE NOT NULL
);

-- Añadir una columna tipo 'text' (cadena ilimitada), permite NULL
ALTER TABLE alumnos ADD COLUMN comentarios text;


-- cursos ----------------------------------------------------------------
CREATE TABLE cursos(
	id_curso VARCHAR(5) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL
);


-- matriculas con ID automático SERIAL
-- ON DELETE CASCADE para eliminar automáticamente las matrículas al eliminar un alumno o curso----------------------------------------------------------------
CREATE TABLE matriculas(
	id_matricula SERIAL PRIMARY KEY,
	id_alumno int NOT NULL,
	id_curso VARCHAR(5) NOT NULL,
	fecha_matricula DATE DEFAULT CURRENT_DATE NOT NULL,

	CONSTRAINT fk_alumno FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno) ON DELETE CASCADE,
	CONSTRAINT fk_curso FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);





