/*
    --Ejemplos de funciones
    ###############################################################
*/

-- fijar el Schema por defecto
SET search_path TO comercio;

-- Standard SQL syntax
CAST(expression AS target_type)

-- PostgreSQL shorthand (more common)
expression::target_type

-- Text to Integer
SELECT 
    '123' AS original_text,
    CAST('123' AS INTEGER) AS cast_syntax,
    '123'::INTEGER AS shorthand_syntax;

-- Text to Decimal/Numeric
SELECT 
    '123.45' AS original_text,
    CAST('123.45' AS NUMERIC(10,2)) AS with_precision,
    '123.45'::NUMERIC AS simple_numeric;

-- Real-world example: Converting text IDs
SELECT 
    CAST(id_categoria AS TEXT) AS category_id_text
FROM comercio.categorias;

-- Text to Date
-- NOTE: 15-03-2024 WILL NOT WORK as 'DD-MM-YYYY' is not ISO format
SELECT 
    '2024-03-15' AS text_date,
    CAST('2024-03-15' AS DATE) AS date_value,
    '2024-03-15'::DATE AS shorthand;

-- Text to Timestamp
SELECT 
    '2024-03-15 14:30:00'::TIMESTAMP AS full_timestamp;

-- Extract date parts
SELECT 
    fecha_alta,
    EXTRACT(YEAR FROM fecha_alta) AS year,
    EXTRACT(MONTH FROM fecha_alta) AS month,
    CAST(EXTRACT(YEAR FROM fecha_alta) AS TEXT) AS year_text
FROM comercio.clientes;

-- Date calculations with CAST
SELECT 
    fecha_alta,
    CURRENT_DATE - fecha_alta AS days_interval,
    CAST((CURRENT_DATE - fecha_alta) AS INTEGER) AS days_as_number
FROM comercio.clientes;

-- Advanced Date to formatted text
SELECT 
    fecha,
    CAST(fecha AS TEXT) AS simple_text,
    TO_CHAR(fecha, 'DD/MM/YYYY') AS formatted_slash,
    TO_CHAR(fecha, 'Month DD, YYYY') AS full_text
FROM comercio.pedidos;


-- Timestamp to Date/Time
SELECT 
    created_at AS full_timestamp,
    CAST(created_at AS DATE) AS date_only,
    CAST(created_at AS TIME) AS time_only,
    DATE_TRUNC('day', created_at) AS truncated
FROM comercio.users;

---------------

-- Boolean to Text/Integer
SELECT 
    activo AS original_boolean,
    CAST(activo AS TEXT) AS boolean_text,        -- 'true' or 'false'
    CAST(activo AS INTEGER) AS boolean_number,   -- 1 or 0
    CASE 
        WHEN activo THEN 'Activo' 
        ELSE 'Inactivo' 
    END AS custom_text
FROM comercio.clientes;

------

-- Decimal to Integer (truncates)
SELECT 
    precio AS original_price,
    CAST(precio AS INTEGER) AS truncated,
    ROUND(CAST(precio AS NUMERIC)) AS rounded
FROM comercio.productos;

-- Results: 1000.00 → 1000, 2000.00 → 2000

-- UUID to Text
--Sample UUID: be3de19e-f6ee-4393-8b6b-23bfbf3ee9f5
SELECT 
    id_producto AS uuid,
    CAST(id_producto AS TEXT) AS uuid_text,
    LENGTH(id_producto::TEXT) AS length  -- Always 36 characters
FROM comercio.productos;

---------------

-- Safe NULL conversions
SELECT 
    'NULL value' AS description,
    CAST(NULL AS INTEGER) AS result;  -- Returns NULL

-- Convert empty string to NULL
SELECT 
    CAST(NULLIF('', '') AS INTEGER) AS empty_to_null;

-- Safe conversion with validation
SELECT 
    comentarios,
    CASE 
        WHEN comentarios ~ '^[0-9]+$' 
        THEN CAST(comentarios AS INTEGER)
        ELSE NULL 
    END AS safe_number
FROM comercio.clientes
WHERE comentarios IS NOT NULL;


---------------
---Practical Real-World Examples

--Price Formatting:
SELECT 
    nombre,
    precio,
    '$' || CAST(ROUND(precio, 2) AS TEXT) AS simple_format,
    CONCAT('$', TO_CHAR(precio, '999,999.99')) AS with_thousands
FROM comercio.productos;

--Client Age Calculation:
SELECT 
    nombres || ' ' || apellidos AS full_name,
    fecha_alta,
    CAST(
        EXTRACT(YEAR FROM CURRENT_DATE) - 
        EXTRACT(YEAR FROM fecha_alta) 
        AS INTEGER
    ) AS years_as_client,
    CAST((CURRENT_DATE - fecha_alta) AS INTEGER) || ' días' AS days_text
FROM comercio.clientes;

-- JSON and Array Conversions:ACCESS-- JSON conversions
SELECT 
    '{"nombre": "Producto", "precio": 99.99}'::JSON AS json_data,
    CAST('{"key": "value"}' AS JSON) AS text_to_json;

-- Array conversions
SELECT 
    ARRAY[1, 2, 3, 4, 5] AS int_array,
    ARRAY[1, 2, 3]::TEXT[] AS text_array,
    CAST(ARRAY[1, 2, 3] AS TEXT) AS array_to_text;