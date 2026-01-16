/*
    --Ejemplos de funciones String en PostgreSQL
    ###############################################################
*/

-- fijar el Schema por defecto
SET search_path TO comercio;

-------------------
-- Examples of String Functions


-- =============================================
-- STRING FUNCTIONS EXAMPLES
-- =============================================

-- 1. CONCATENATION Functions
-- Concatenate first and last names
SELECT 
    nombres,
    apellidos,
    CONCAT(nombres, ' ', apellidos) AS full_name,
    nombres || ' ' || apellidos AS full_name_operator
FROM clientes;

-- 2. LENGTH Functions
-- Get the length of strings
SELECT 
    nombres,
    LENGTH(nombres) AS name_length,
    CHAR_LENGTH(apellidos) AS surname_length,
    OCTET_LENGTH(nombres) AS byte_length
FROM clientes;

-- 3. CASE CONVERSION
SELECT 
    nombres,
    UPPER(nombres) AS uppercase,
    LOWER(nombres) AS lowercase,
    INITCAP(nombres) AS titlecase
FROM clientes;

-- 4. TRIMMING Functions
SELECT 
    nombres,
    LTRIM(nombres) AS left_trimmed,
    RTRIM(nombres) AS right_trimmed,
    TRIM(nombres) AS both_trimmed,
    TRIM(BOTH ' ' FROM nombres) AS custom_trim
FROM clientes;

-- 5. SUBSTRING Extraction
SELECT 
    nombres,
    SUBSTRING(nombres FROM 1 FOR 3) AS first_three_chars,
    SUBSTRING(nombres FROM 2) AS from_second_char,
    LEFT(nombres, 2) AS leftmost_two,
    RIGHT(apellidos, 3) AS rightmost_three
FROM clientes;

-- 6. POSITION & SEARCH Functions
SELECT 
    nombres,
    POSITION('a' IN LOWER(nombres)) AS position_of_a,
    STRPOS(LOWER(nombres), 'e') AS strpos_of_e
FROM clientes
WHERE POSITION('a' IN LOWER(nombres)) > 0;

-- 7. REPLACE Function
SELECT 
    nombres,
    REPLACE(nombres, 'a', '@') AS replaced_a,
    REPLACE(LOWER(nombres), ' ', '_') AS underscored
FROM clientes;

-- 8. PADDING Functions
SELECT 
    nombres,
    LPAD(nombres, 20, '*') AS left_padded,
    RPAD(apellidos, 20, '-') AS right_padded
FROM clientes;

-- 9. REVERSE Function
SELECT 
    nombres,
    REVERSE(nombres) AS reversed_name
FROM clientes;

-- 10. SPLIT_PART Function (useful for parsing)
-- If you have full names in one field
SELECT 
    CONCAT(nombres, ' ', apellidos) AS full_name,
    SPLIT_PART(CONCAT(nombres, ' ', apellidos), ' ', 1) AS first_word,
    SPLIT_PART(CONCAT(nombres, ' ', apellidos), ' ', 2) AS second_word
FROM clientes;

-- 11. REPEAT Function
SELECT 
    nombres,
    REPEAT(LEFT(nombres, 1), 3) AS repeated_initial
FROM clientes;

-- 12. TRANSLATE Function
SELECT 
    nombres,
    TRANSLATE(nombres, 'aeiou', '12345') AS vowels_replaced
FROM clientes;

-- 13. ASCII & CHR Functions
SELECT 
    nombres,
    ASCII(LEFT(nombres, 1)) AS first_char_ascii,
    CHR(ASCII(LEFT(nombres, 1))) AS ascii_to_char
FROM clientes;

-- 14. REGEXP Functions
-- Find names matching a pattern
SELECT 
    nombres,
    apellidos,
    REGEXP_REPLACE(nombres, '[aeiou]', '*', 'gi') AS vowels_starred
FROM clientes
WHERE nombres ~ '^[A-M]';  -- Names starting with A-M

-- 15. FORMAT Function
SELECT 
    nombres,
    apellidos,
    FORMAT('Cliente: %s %s', nombres, apellidos) AS formatted_name,
    FORMAT('ID: %s, Nombre: %s', id, nombres) AS formatted_info
FROM clientes;


---------