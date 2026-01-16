-- fijar el Schema por defecto, donde se crean las tablas
SET search_path = colegio; 

SELECT * FROM alumnos;


-- Requisito: Seleccionar cursos y los alumnos matriculados en cada curso
-- Seleccionar de cursos y matriculas, juntarlas usando cursos.id_curso = matriculas.id_curso

select cursos.id_curso, cursos.nombre from cursos

select matriculas.id_alumno from matriculas

select alumnos.nombres, alumnos.apellidos from alumnos


select 
	cursos.id_curso, cursos.nombre, 
	matriculas.id_alumno,
	alumnos.nombres, alumnos.apellidos
from cursos inner join matriculas on cursos.id_curso = matriculas.id_curso
inner join alumnos on alumnos.id_alumno = matriculas.id_alumno



select 
	alumnos.nombres, alumnos.apellidos,
		matriculas.id_alumno, matriculas.id_curso
from alumnos
left join matriculas on alumnos.id_alumno = matriculas.id_alumno



--UPDATE--


begin;
update alumnos set apellidos = 'Romero ' ;

select * from alumnos

commit;
-- o bien
rollback;

delete from alumnos where dni= '76945454G';

delete from alumnos where dni = '23451234J';

select *from cursos

delete from cursos where id_curso = '1';


----------------------------

CREATE TABLE asignaturas(
	id_asignatura SERIAL PRIMARY KEY,
	nombre_asignatura VARCHAR(50) NOT NULL,
	id_curso VARCHAR(5) NOT NULL,
	comentarios text,

	constraint fk_curso foreign key (id_curso) references cursos(id_curso)
	
);


insert into asignaturas
	(nombre_asignatura, id_curso, comentarios)
values
('mates', '1', 'aplicadas'),
('lengua', '2', 'cuaderno azul'),
('fisica', '1', 'cuantica')
returning *;



CREATE TABLE profesores(
	id_profesor SERIAL PRIMARY KEY,
	dni VARCHAR(20) UNIQUE NOT NULL,
	nombres VARCHAR(100) NOT NULL,
	apellidos VARCHAR(100) NOT NULL,
	fecha_incorporacion DATE NOT NULL,
	email VARCHAR(100) CONSTRAINT profesores_unique_email UNIQUE NOT NULL
);

insert into profesores
	(dni, nombres, apellidos, fecha_incorporacion, email)
VALUES
	('76983214G', 'Juan', 'Romero', '2003-02-09', 'juanromero@gmail.com'),
	('23451234J', 'Pablo', 'Guzman', '2003-12-23', 'pablog@gmail.com'),
	('90078432Y', 'Julian', 'Martin', '2003-08-16', 'julianmartin@gmail.com')
	returning *;

alter table asignaturas add column id_profesor int;


alter table asignaturas add constraint fk_profesores
foreign key (id_profesor) references profesores(id_profesor);

select * from asignaturas;



update asignaturas set id_profesor = 1 where id_asignatura = 1;
update asignaturas set id_profesor = 2 where id_asignatura = 2;
update asignaturas set id_profesor = 3 where id_asignatura = 3
returning *;


---------views----


create or replace view vw_alumnos_matriculados AS
select 
	cursos.id_curso, cursos.nombre, 
	matriculas.id_alumno,
	alumnos.nombres, alumnos.apellidos
from cursos inner join matriculas on cursos.id_curso = matriculas.id_curso
inner join alumnos on alumnos.id_alumno = matriculas.id_alumno;


select * from vw_alumnos_matriculados;