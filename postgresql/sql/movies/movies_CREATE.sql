/* 
    SOURCE: https://www.udemy.com/course/postgresqlmasterclass/learn/lecture/24006222#overview
    Description: SQL scripts to create the movies tables
*/


-- fijar el Schema por defecto, donde se crean las tablas
SET search_path = movies; 

-- Eliminar tablas y esquema si ya existen: permite empezar de cero
DROP TABLE IF EXISTS movies_actors; -- 
DROP TABLE IF EXISTS movies_revenues; 
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS movies; 
DROP TABLE IF EXISTS directors; 


-- Eliminar Schema último
DROP SCHEMA IF EXISTS movies;

-- Crear un Schema ----------------------------------------------------------------
CREATE SCHEMA movies;

CREATE TABLE directors (
	director_id SERIAL PRIMARY KEY,
	first_name VARCHAR(150),
	last_name VARCHAR(150) NOT NULL,
	date_of_birth DATE,
	nationality VARCHAR(20),
	add_date DATE,
	update_date DATE
);

SELECT * FROM directors;

CREATE TABLE movies (
	movie_id SERIAL PRIMARY KEY,
	movie_name VARCHAR(100) NOT NULL,
	movie_length INT,
	movie_lang VARCHAR(20),
	age_certificate VARCHAR(10),
	release_date DATE,
	director_id INT REFERENCES directors (director_id)
);
SELECT * FROM movies;

CREATE TABLE actors (
	actor_id SERIAL PRIMARY KEY,
	first_name VARCHAR(150),
	last_name VARCHAR(150) NOT NULL,
	gender CHAR(1),
	date_of_birth DATE,
	add_date DATE,
	update_date DATE
);

CREATE TABLE movies_actors (
	movie_id INT REFERENCES movies (movie_id),
	actor_id INT REFERENCES actors (actor_id),
	PRIMARY KEY (movie_id, actor_id)
);

SELECT * FROM movies_actors; 

CREATE TABLE movies_revenues (
	revenue_id SERIAL PRIMARY KEY,
	movie_id INT REFERENCES movies (movie_id),
	revenues_domestic NUMERIC (10,2),
	revenues_international NUMERIC (10,2)
);

SELECT * FROM movies_revenues; 