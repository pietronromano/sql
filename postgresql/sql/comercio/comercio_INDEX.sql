/*
    Crear indices
    ###############################################################
    VER: https://www.postgresql.org/docs/18/indexes.html
*/

-- Schema por defecto es "public"
SHOW search_path;
-- fijar el Schema por defecto, donde se crean las tablas
SET search_path = comercio; 

-- Eliminar índice si existe
DROP INDEX IF EXISTS idx_productos_nombre;

/*
    Visualizar el Query Plan para el SELECT usando where, antes de crear un índice
    VER: 
        - https://www.postgresql.org/docs/18/using-explain.html
        - https://www.postgresql.org/docs/18/sql-explain.html
    
    - EXPLAIN: estima el coste, pero NO ejecuta la consulta
    - EXPLAIN ANALYZE: estima el coste, SÍ ejecuta la consulta y entonces muestra el tiempo real
    - (VERBOSE ON) The VERBOSE option allows every node to report more detailed information, such as the list of the output columns, even when not specified.

    - Results:
        -> Seq Scan: sequential scan on the TABLE - so not using the index: BAD!
        -> Index Scan: using the index: GOOD!
*/

EXPLAIN (VERBOSE ON) SELECT * FROM productos WHERE nombre = 'Una Tableta';
    --> Seq Scan on productos  (cost=0.00..11.25 rows=1 width=723)

-- Crear el índice y repetir la consulta
CREATE INDEX idx_productos_nombre ON productos(nombre);
EXPLAIN ANALYZE SELECT * FROM productos WHERE nombre = 'Una Cama';
    --> Seq Scan on productos  (cost=0.00..1.06 rows=1 width=723)


/*
    Indices en varias columnas
    VER: https://www.postgresql.org/docs/18/indexes-multicolumn.html#INDEXES-MULTICOLUMN
    A multicolumn B-tree index can be used with query conditions that involve any subset of the index's columns, 
    but the index is most efficient when there are constraints on the leading (leftmost) columns.
*/
TODO


