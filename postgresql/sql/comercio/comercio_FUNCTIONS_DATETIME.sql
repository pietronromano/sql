/*
    --Ejemplos de funciones DateTime en PostgreSQL
    ###############################################################

    Perfect! I can see your comercio schema has several date and timestamp columns:

    clientes.fecha_alta (date)
    pedidos.fecha (date)
    productos.fecha_alta (date)
    users.created_at and updated_at (timestamp with time zone)
*/

-- fijar el Schema por defecto
SET search_path TO comercio;

-- =============================================
-- DATE, TIME, and DATETIME FUNCTIONS EXAMPLES
-- =============================================

-- 1. Current Date/Time Functions
SELECT 
    CURRENT_DATE AS current_date,                    -- 2025-11-15
    CURRENT_TIME AS current_time,                    -- 15:09:34.332296+01
    CURRENT_TIMESTAMP AS current_timestamp,          -- 2025-11-15 15:09:34.332296+01
    NOW() AS now_function,                           -- Same as CURRENT_TIMESTAMP
    CLOCK_TIMESTAMP() AS clock_timestamp,            -- Updates during query execution
    TIMEOFDAY() AS timeofday_string;                 -- String format

-- 2. Extracting Parts of Dates (using clientes.fecha_alta)
SELECT 
    nombres,
    apellidos,
    fecha_alta,
    EXTRACT(YEAR FROM fecha_alta) AS year,
    EXTRACT(MONTH FROM fecha_alta) AS month,
    EXTRACT(DAY FROM fecha_alta) AS day,
    EXTRACT(DOW FROM fecha_alta) AS day_of_week,     -- 0=Sunday, 6=Saturday
    EXTRACT(DOY FROM fecha_alta) AS day_of_year,     -- 1-366
    EXTRACT(WEEK FROM fecha_alta) AS week_number,
    EXTRACT(QUARTER FROM fecha_alta) AS quarter
FROM comercio.clientes;

-- 3. Date Formatting (using TO_CHAR)
SELECT 
    nombres,
    fecha_alta,
    TO_CHAR(fecha_alta, 'DD/MM/YYYY') AS formato_europeo,           -- 01/02/2001
    TO_CHAR(fecha_alta, 'Month DD, YYYY') AS formato_texto,         -- February 01, 2001
    TO_CHAR(fecha_alta, 'Day, DD-Mon-YYYY') AS formato_completo,    -- Thursday, 01-Feb-2001
    TO_CHAR(fecha_alta, 'YYYY-MM-DD') AS formato_iso,               -- 2001-02-01
    TO_CHAR(fecha_alta, 'FMDay, FMMonth DD, YYYY') AS sin_espacios  -- Thursday, February 01, 2001
FROM comercio.clientes;

-- 4. Date Arithmetic (using pedidos.fecha)
SELECT 
    id_pedido,
    fecha AS fecha_original,
    fecha + INTERVAL '7 days' AS una_semana_despues,
    fecha + INTERVAL '1 month' AS un_mes_despues,
    fecha + INTERVAL '1 year' AS un_año_despues,
    fecha - INTERVAL '10 days' AS diez_dias_antes,
    fecha + INTERVAL '2 weeks' AS dos_semanas_despues,
    fecha + INTERVAL '3 months 5 days' AS combinado
FROM comercio.pedidos;

--5. Age and Date Differences
SELECT 
    nombres,
    apellidos,
    fecha_alta,
    AGE(CURRENT_DATE, fecha_alta) AS tiempo_como_cliente,           -- 24 years 9 mons 14 days
    CURRENT_DATE - fecha_alta AS dias_diferencia_simple,            -- 9048 days
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_alta)) AS años_completos
FROM comercio.clientes;

-- 6. Date Truncation (using DATE_TRUNC)
SELECT 
    fecha AS fecha_original,
    DATE_TRUNC('year', fecha::timestamp) AS inicio_año,      -- 2001-01-01 00:00:00
    DATE_TRUNC('month', fecha::timestamp) AS inicio_mes,     -- 2001-02-01 00:00:00
    DATE_TRUNC('week', fecha::timestamp) AS inicio_semana,   -- 2001-01-29 00:00:00
    DATE_TRUNC('day', fecha::timestamp) AS inicio_dia        -- 2001-02-01 00:00:00
FROM comercio.pedidos;

--7. Timestamp Functions (using users table)
SELECT 
    nombre,
    fecha_alta,
    CASE 
        WHEN fecha_alta >= CURRENT_DATE - INTERVAL '30 days' THEN 'Nuevo (último mes)'
        WHEN fecha_alta >= CURRENT_DATE - INTERVAL '90 days' THEN 'Reciente (últimos 3 meses)'
        WHEN fecha_alta >= CURRENT_DATE - INTERVAL '1 year' THEN 'Este año'
        ELSE 'Más de un año'
    END AS antiguedad,
    fecha_alta > '2024-01-01' AS producto_reciente,
    fecha_alta BETWEEN '2024-01-01' AND '2024-12-31' AS del_2024
FROM comercio.productos
ORDER BY fecha_alta DESC;

-- 8. Date Comparisons and Filtering
SELECT 
    nombre,
    fecha_alta,
    CASE 
        WHEN fecha_alta >= CURRENT_DATE - INTERVAL '30 days' THEN 'Nuevo (último mes)'
        WHEN fecha_alta >= CURRENT_DATE - INTERVAL '90 days' THEN 'Reciente (últimos 3 meses)'
        WHEN fecha_alta >= CURRENT_DATE - INTERVAL '1 year' THEN 'Este año'
        ELSE 'Más de un año'
    END AS antiguedad,
    fecha_alta > '2024-01-01' AS producto_reciente,
    fecha_alta BETWEEN '2024-01-01' AND '2024-12-31' AS del_2024
FROM comercio.productos
ORDER BY fecha_alta DESC;

-- 9. String to Date Conversion
SELECT 
    TO_DATE('15/11/2024', 'DD/MM/YYYY') AS fecha_europea,
    TO_DATE('2024-11-15', 'YYYY-MM-DD') AS fecha_iso,
    TO_DATE('November 15, 2024', 'Month DD, YYYY') AS fecha_texto,
    TO_TIMESTAMP('2024-11-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS') AS timestamp_desde_texto,
    CAST('2024-11-15' AS DATE) AS cast_a_fecha,
    '2024-11-15'::DATE AS conversion_directa;

-- 10. Generate Date Series
SELECT 
    generate_series AS fecha_serie,
    TO_CHAR(generate_series, 'Day') AS dia_semana,
    EXTRACT(DOW FROM generate_series) AS numero_dia,
    CASE 
        WHEN EXTRACT(DOW FROM generate_series) IN (0, 6) THEN 'Fin de semana'
        ELSE 'Día laboral'
    END AS tipo_dia
FROM generate_series(
    CURRENT_DATE - INTERVAL '7 days',
    CURRENT_DATE,
    INTERVAL '1 day'
) AS generate_series;

-- 11. Practical Example: Sales Analysis by Month
SELECT 
    DATE_TRUNC('month', fecha)::date AS mes,
    TO_CHAR(fecha, 'Month YYYY') AS mes_texto,
    COUNT(*) AS total_pedidos,
    COUNT(CASE WHEN pagado THEN 1 END) AS pedidos_pagados,
    COUNT(CASE WHEN NOT pagado THEN 1 END) AS pedidos_pendientes,
    ROUND(COUNT(CASE WHEN pagado THEN 1 END) * 100.0 / COUNT(*), 2) AS porcentaje_pagados
FROM comercio.pedidos
GROUP BY DATE_TRUNC('month', fecha), TO_CHAR(fecha, 'Month YYYY')
ORDER BY mes DESC;

-- 12. Customer Activity Timeline Analysis
SELECT 
    c.nombres,
    c.apellidos,
    c.fecha_alta AS cliente_desde,
    MIN(p.fecha) AS primer_pedido,
    MAX(p.fecha) AS ultimo_pedido,
    AGE(MAX(p.fecha), MIN(p.fecha)) AS periodo_actividad,
    COUNT(p.id_pedido) AS total_pedidos
FROM comercio.clientes c
LEFT JOIN comercio.pedidos p ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombres, c.apellidos, c.fecha_alta
HAVING COUNT(p.id_pedido) > 0
ORDER BY total_pedidos DESC;