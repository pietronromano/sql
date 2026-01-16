/*
    
    ###############################################################
*/

-- fijar el Schema por defecto, dos maneras
-- Schema por defecto es "public"
SHOW search_path;
-- fijar el Schema por defecto, donde se crean las tablas
SET search_path = colegio; 

----------------------------------------------------------------------
-- Seleccionar todas las columnas, ordenar por fecha_nacimiento
SELECT * FROM alumnos ORDER BY fecha_nacimiento ASC;

-- Orden descendiente
SELECT * FROM alumnos ORDER BY fecha_nacimiento DESC;

-- Ordenar por 2 columnas, Seleccionar los primeros 3
SELECT * FROM alumnos ORDER BY nombres,fecha_nacimiento ASC LIMIT 3;

----------------------------------------------------------------------
-- Comparison Operators: https://www.postgresql.org/docs/current/functions-comparison.html
-- igual a
SELECT * FROM alumnos WHERE dni = '23451234J';

-- no igual a
SELECT * FROM alumnos WHERE dni <> '23451234J';
SELECT * FROM alumnos WHERE dni != '23451234J';

-- Seleccionar fecha_nacimiento mayor que ">"
SELECT * FROM alumnos WHERE fecha_nacimiento > '2003-03-01';

-- Seleccionar fecha_nacimiento menor que "<"
SELECT * FROM alumnos WHERE fecha_nacimiento < '2003-03-01';

-- Seleccionar fecha_nacimiento ENTRE (inclusivo)
SELECT * FROM alumnos WHERE fecha_nacimiento BETWEEN '2003-01-01' AND '2003-02-09';


-- Seleccionar varios appelidos 
SELECT * FROM alumnos WHERE apellidos IN ('Maroto','Cano','Penelope');


-- Comentarios no tiene valor (NULL)
SELECT * FROM alumnos WHERE comentarios IS NULL;

-- Tiene valor (IS NOT NULL)
SELECT * FROM alumnos WHERE comentarios IS NOT NULL;

-- Si la columns comentarios contiene 'comentario' con cualquier número de characteres antes o después
SELECT * FROM alumnos WHERE comentarios LIKE '%comentario%';

----------------------------------------------------------------------------
-- Columnas
-- Seleccionar todas las columnas
SELECT * FROM alumnos;


-- Seleccionar columnas específicas
SELECT dni, nombres, apellidos FROM alumnos;

-- Combinar nombre y apellidos, usar un alias para la nueva columna
SELECT dni, CONCAT(nombres, ' ', apellidos) AS nombre_completo FROM alumnos;


----------------------------------------------------------------------
/*
    JOINS: https://www.postgresql.org/docs/current/queries-table-expressions.html#QUERIES-JOIN
*/

/*
    Requisito: Seleccionar alumnos y sus matriculas:
    Tabla alumnos: id_alumno, dni, nombres, apellidos 
    Tabla matriculas: id_matricula, id_curso, fecha_matricula
*/

-- 1er paso: select de cada tabla por separado (incluir nombre de las tablas para evitar ambiguedad):
-- Seleccionar de alumnos    
SELECT 
    alumnos.id_alumno, alumnos.nombres, alumnos.apellidos 
FROM alumnos;

-- Seleccionar de matriculas
SELECT
    matriculas.id_matricula, matriculas.id_alumno, matriculas.id_curso, matriculas.fecha_matricula 
FROM matriculas;


-- 2do paso: usar ALIAS para abreviar las tablas
SELECT 
    a.id_alumno, a.nombres, a.apellidos 
FROM alumnos AS a;
-- Seleccionar de matriculas
SELECT 
    m.id_matricula, m.id_curso, m.fecha_matricula 
FROM matriculas AS m;


-- 3er paso: juntar la lista de las columnas de ambas tablas y luego juntar las tablas usando INNER JOIN
SELECT 
    a.id_alumno, a.nombres, a.apellidos,
    m.id_matricula, m.id_curso, m.fecha_matricula  
FROM alumnos AS a
INNER JOIN matriculas AS m ON a.id_alumno = m.id_alumno;


----------------------------------------------------------------------

-- Requisito: Seleccionar cursos y los alumnos matriculados en cada curso
-- Seleccionar de cursos y matriculas, juntarlas usando cursos.id_curso = matriculas.id_curso
SELECT cursos.id_curso, cursos.nombre, matriculas.id_alumno
FROM cursos INNER JOIN matriculas 
ON cursos.id_curso = matriculas.id_curso;

-- Usar alias  c(cursos) m (matriculas) para abreviar las tablas
SELECT c.id_curso, c.nombre, m.id_alumno
FROM cursos AS c INNER JOIN matriculas AS m 
ON c.id_curso = m.id_curso

----------------------------------------------------------------------
-- Seleccionar nombres completos de alumnos y los cursos en los que están matriculados
-- Query without aliases: Fully qualified table names throughout
SELECT cursos.id_curso, alumnos.nombres, alumnos.apellidos, cursos.nombre AS nombre_curso, matriculas.fecha_matricula
FROM alumnos
INNER JOIN matriculas ON alumnos.id_alumno = matriculas.id_alumno
INNER JOIN cursos ON matriculas.id_curso = cursos.id_curso;

-- Query with aliases: Using table aliases for brevity
SELECT c.id_curso, a.nombres, a.apellidos, c.nombre AS nombre_curso, m.fecha_matricula
FROM cursos AS c 
INNER JOIN matriculas AS m ON c.id_curso = m.id_curso
INNER JOIN alumnos AS a ON m.id_alumno = a.id_alumno;