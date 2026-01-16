/*
    Crear tablas y relaciones
    ###############################################################
*/

-- Schema por defecto es "public"
SHOW search_path;
-- fijar el Schema por defecto, donde se crean las tablas
SET search_path = comercio; 

-- Eliminar tablas y esquema si ya existen: permite empezar de cero
DROP TABLE IF EXISTS pedidos_productos; -- 
DROP TABLE IF EXISTS productos; --  que le hace referencia
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS pedidos; -- quitar esta primero, porque hace referencia a otras
DROP TABLE IF EXISTS clientes; -- quitar esta primero, porque hace referencia a otras


-- Eliminar Schema último
DROP SCHEMA IF EXISTS comercio;

-- Crear un Schema ----------------------------------------------------------------
CREATE SCHEMA comercio;

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nif varchar(20) NOT NULL,
    nombres varchar(50) NOT NULL,
	apellidos varchar(50) NOT NULL,
    fecha_alta DATE DEFAULT CURRENT_DATE NOT NULL,
    activo bool DEFAULT true,
    comentarios text
);

-- referencia recursiva fk_padre para crear un árbol (ver comercio_WITH.sql)
CREATE TABLE categorias (
    id_categoria integer PRIMARY KEY,
    nombre varchar(50) NOT NULL,
    id_padre integer, 
    comentarios text,
    CONSTRAINT fk_padre FOREIGN KEY (id_padre) REFERENCES categorias(id_categoria)

);

-- Example rename a column
ALTER TABLE categorias RENAME COLUMN nombre TO categoria;

CREATE TABLE productos (
    id_producto UUID PRIMARY KEY DEFAULT uuidv4(),
    nombre varchar(50) NOT NULL,
    descripcion varchar(250) NOT NULL,
    id_categoria integer NOT NULL,
    fecha_alta DATE NOT NULL,
    activo bool DEFAULT true,
    precio numeric DEFAULT 9.99 NOT NULL,
    comentarios text,
 
    CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);


CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
	id_cliente integer NOT NULL,
    nif varchar(20) NOT NULL,
    nombres varchar(50) NOT NULL,
	apellidos varchar(50) NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    pagado bool DEFAULT false,
	comentarios text,

    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE pedidos_productos (
    id_pedido integer NOT NULL,
	id_producto UUID NOT NULL,
    cantidad integer NOT NULL CONSTRAINT chk_cantidad CHECK (cantidad > 0),
	comentarios text,
    PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
	CONSTRAINT fk_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);


 CREATE TABLE users (
      id SERIAL PRIMARY KEY,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
      bio VARCHAR(400),
      username VARCHAR(30) NOT NULL
    );