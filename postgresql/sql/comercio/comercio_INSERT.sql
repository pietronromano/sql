/*
    Insertar registros
    ###############################################################
*/

-- Schema por defecto es "public"
SHOW search_path;
-- fijar el Schema por defecto, donde se crean las tablas
SET search_path = comercio; 

-- categorias  ----------------------------------------------------------------
INSERT INTO categorias
	(id_categoria, nombre, id_padre, comentarios)
VALUES
	(1, 'Electrónica', NULL, 'Primer Nivel'),
	(2, 'Muebles', NULL, 'Primer Nivel'),
	(4, 'PCs', 1, 'Segundo Nivel'),
	(5, 'Tabletas', 2, 'Tercer Nivel'),
	(6, 'Portátiles', 4,'Tercer Nivel'),
	(7, 'Mesas', 2,'Segundo Nivel'),
    (8, 'Camas', 2,'Segundo Nivel')
    RETURNING *;



-- productos  ----------------------------------------------------------------
-- Omitir id_producto, ya que tiene valor por defecto uuidv4()
INSERT INTO productos
    (nombre,descripcion, id_categoria ,fecha_alta,activo,precio,comentarios)
VALUES
	('Portátil 1', 'Un Portátil', 4, '2025-04-01',TRUE, 1000,'Commentarios Portátil 1'),
	('Portátil 2', 'Un Portátil', 4, '2025-04-01',TRUE,2000,'Commentarios Portátil 2'),
    ('Mesa 1', 'Una Mesa', 7, '2025-07-01',TRUE,700,'Commentarios Mesa 1'),
    ('Cama 1', 'Una Cama', 8, '2025-08-01',FALSE,800,'Commentarios Cama 2'),
    ('Tableta 1', 'Una Tableta', 5, '2025-05-01',FALSE,500,'Commentarios Tableta 1'),
	('Portáitl Gaming', 'Potente', 4, '2025-06-01',FALSE,3000,'Commentarios Portáitl Gaming')
    RETURNING *;

-- clientes ----------------------------------------------------------------
INSERT INTO clientes
	(nif,nombres, apellidos, fecha_alta, activo, comentarios)
VALUES
	('11111111A', 'Nombres1', 'Apellidos1', '2001-01-01', TRUE,'Commentarios 1'),
	('22222222A', 'Nombres2', 'Apellidos2', '2001-02-01', FALSE,'Commentarios 2'),
	('33333333A', 'Nombres3', 'Apellidos3', '2001-03-01', TRUE,'Commentarios 3'),
	('44444444A', 'Nombres4', 'Apellidos4', '2001-04-01', FALSE,'Commentarios 4'),
	('55555555A', 'Nombres5', 'Apellidos5', '2001-05-01', TRUE,'Commentarios 5'),
	('66666666A', 'Nombres6', 'Apellidos6', '2001-06-01', FALSE,'Commentarios 6'),
	('77777777A', 'Nombres7', 'Apellidos7', '2001-07-01', TRUE,'Commentarios 7')
    RETURNING *;


-- pedidos --------------------------------------------
INSERT INTO pedidos
	(id_cliente,fecha,pagado,comentarios)
VALUES
	(1, '2001-01-01', TRUE,'Commentarios 1'),
	(2, '2001-02-01', FALSE,'Commentarios 2'),
	(3, '2001-03-01', TRUE,'Commentarios 3'),
	(4, '2001-04-01', FALSE,'Commentarios 4'),
	(5, '2001-05-01', TRUE,'Commentarios 5'),
	(6, '2001-06-01', FALSE,'Commentarios 6'),
	(7, '2001-07-01', TRUE,'Commentarios 7')
	RETURNING *;


-- pedidos_productos ----------------------------------
-- NOTA: id_producto cambiará según GUIDs generados para los productos
INSERT INTO pedidos_productos
	(id_pedido, id_producto, cantidad,comentarios)
VALUES
	(1,'be3de19e-f6ee-4393-8b6b-23bfbf3ee9f5',1,'Comentarios 1'),
	(2,'28d588a9-e201-4fa8-92f5-0296c2b4598f',2,'Comentarios 2'),
	(3,'9dfc4978-1584-49c9-894d-be3a03b6a8ec',3,'Comentarios 3'),
	(4,'084716de-c637-4d62-9b97-10c3ec227a6d',4,'Comentarios 4'),
	(5,'df954bea-2743-4d72-b12b-d38537a8b2f2',5,'Comentarios 5')
	RETURNING *;