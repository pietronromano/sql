/*
    Schema used for java-spring Hibernate examples
*/
SET search_path = company;

DROP TABLE IF EXISTS students;
DROP SCHEMA IF EXISTS company;

-- Create a Schema ----------------------------------------------------------------
CREATE SCHEMA company;

CREATE TABLE employees(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL
);

--
-- Data for table `employee`
--

INSERT INTO employees 
(id, first_name, last_name, email)
VALUES
	(1,'Leslie','Andrews','leslie@luv2code.com'),
	(2,'Emma','Baumgarten','emma@luv2code.com'),
	(3,'Avani','Gupta','avani@luv2code.com'),
	(4,'Yuri','Petrov','yuri@luv2code.com'),
	(5,'Juan','Vega','juan@luv2code.com');

SELECT * FROM employees;