/*
    Cursors in PostgreSQL

    References:
        - https://www.postgresql.org/docs/current/plpgsql-cursors.html

    What is a cursor?
    SQL queries typically return a complete result set all at once.
    However, Rather than executing a whole query at once, it is possible to set up a cursor that encapsulates the query, 
    and then read the query result a few rows at a time. 
    One reason for doing this is to avoid memory overrun when the result contains a large number of rows. 
    (However, PL/pgSQL users do not normally need to worry about that, since FOR loops automatically use a cursor internally to avoid memory problems.) 
    A more interesting usage is to return a reference to a cursor that a function has created, allowing the caller to read the rows. 
    This provides an efficient way to return large row sets from functions.
*/

SET search_path TO comercio;

-- Example of using a cursor in a PL/pgSQL function
CREATE OR REPLACE FUNCTION fetch_cursor_pedidos()
RETURNS refcursor AS $$
DECLARE
    my_cursor refcursor;
BEGIN
    -- Open a cursor for a large query
    OPEN my_cursor FOR
        SELECT * FROM pedidos;
    RETURN my_cursor;       
END;
$$ LANGUAGE plpgsql;


-- See commercio_PROCEDURE.sql for an example of a procedure that inserts data using a loop.


-- Example of calling the function and fetching rows from the cursor
DO $$
DECLARE
    cur refcursor;
    rec RECORD;
BEGIN
    -- Call the function to get the cursor
    cur := fetch_cursor_pedidos(); 

    -- Fetch rows from the cursor
    LOOP
        FETCH cur INTO rec;
        EXIT WHEN NOT FOUND;
        -- Process each row (for demonstration, we just raise a notice)
        RAISE NOTICE 'Row: %', rec;
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END $$; 
