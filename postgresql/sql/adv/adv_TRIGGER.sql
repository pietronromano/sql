/*
    -Triggers en PostgreSQL
    ###############################################################
    Documentación oficial de PostgreSQL sobre Triggers:
    - https://www.postgresql.org/docs/18/triggers.html
    - https://www.postgresql.org/docs/18/plpgsql-trigger.html

    - Advantages of Using Triggers:
        * Data Integrity: Triggers help maintain data integrity by enforcing business rules and constraints automatically.
        * Automation: They automate repetitive tasks, such as logging changes or updating related tables.
        * Centralized Logic: Business logic can be centralized in the database, reducing redundancy in application code.
        * Auditing: Triggers can be used to track changes to data for auditing purposes.
        * Complex Validations: They allow for complex validations that may not be possible with standard constraints.
    - Disadvantages of Using Triggers:
        * Performance Overhead: Triggers can introduce performance overhead, especially if they are complex or if they fire frequently.
        * Hidden Logic: Business logic in triggers can be "hidden" from developers who are not aware of their existence, leading to confusion.
        * Compexity of Recursion: Triggers can inadvertently cause recursive calls if not carefully designed.
        * Nesting Issues: Triggers that call other triggers can lead to complex interactions that are hard to manage.
        * Debugging Complexity: Debugging issues related to triggers can be challenging, as they operate at the database level and may not be visible in application code.
        * Maintenance Challenges: Triggers can complicate database maintenance and schema changes, as they may need to be updated alongside the tables they affect.
        * Transactional Behavior: Triggers operate within the context of a transaction, which can lead to unexpected behavior if not properly understood.

*/


/*
Example 41.4. A PL/pgSQL Trigger Function for Auditing
ROW Level Trigger Example:
- This example trigger ensures that any insert, update or delete of a row in the emp table is recorded (i.e., audited) in the emp_audit table. 
- The current time and user name are stamped into the row, together with the type of operation performed on it.
*/


-- Reset: eliminar tablas, funciones y triggers si ya existen
DROP TABLE IF EXISTS emp;  
DROP TABLE IF EXISTS emp_audit; 
DROP FUNCTION IF EXISTS process_emp_audit(); 
DROP TRIGGER IF EXISTS emp_audit ON emp;
DROP TRIGGER IF EXISTS emp_audit_ins ON emp;
DROP TRIGGER IF EXISTS emp_audit_upd ON emp;
DROP TRIGGER IF EXISTS emp_audit_del ON emp;

CREATE TABLE emp (
    empname           text NOT NULL,
    salary            integer
);

CREATE TABLE emp_audit(
    operation         char(1)   NOT NULL,
    stamp             timestamp NOT NULL,
    userid            text      NOT NULL,
    empname           text      NOT NULL,
    salary            integer
);

CREATE OR REPLACE FUNCTION process_emp_audit() RETURNS TRIGGER AS $emp_audit$
    BEGIN
        --
        -- Create a row in emp_audit to reflect the operation performed on emp,
        -- making use of the special variable TG_OP to work out the operation.
        --
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO emp_audit SELECT 'D', now(), current_user, OLD.*;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO emp_audit SELECT 'U', now(), current_user, NEW.*;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO emp_audit SELECT 'I', now(), current_user, NEW.*;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$emp_audit$ LANGUAGE plpgsql;

CREATE TRIGGER emp_audit
AFTER INSERT OR UPDATE OR DELETE ON emp
    FOR EACH ROW EXECUTE FUNCTION process_emp_audit();

-- Insert some test data
INSERT INTO emp VALUES ('Alice', 50000);
--See the audit log
SELECT * FROM emp_audit;

UPDATE emp SET salary = 55000 WHERE empname = 'Alice';
DELETE FROM emp WHERE empname = 'Alice';


/*
Example 41.7. Auditing with Transition Tables
Statement Level Trigger Example:
- This example produces the same results as Example 41.4, but instead of using a trigger that fires for every row, 
- it uses a trigger that fires once per statement, after collecting the relevant information in a transition table. 
- This can be significantly faster than the row-trigger approach when the invoking statement has modified many rows. 
- Notice that we must make a separate trigger declaration for each kind of event, since the REFERENCING clauses must be different for each case. 
- But this does not stop us from using a single trigger function if we choose. (In practice, it might be better to use three separate functions and avoid the run-time tests on TG_OP.)
*/

DROP TRIGGER emp_audit ON emp;  -- Eliminar el trigger si ya existe

CREATE OR REPLACE FUNCTION process_emp_audit() RETURNS TRIGGER AS $emp_audit$
    BEGIN
        --
        -- Create rows in emp_audit to reflect the operations performed on emp,
        -- making use of the special variable TG_OP to work out the operation.
        --
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO emp_audit
                SELECT 'D', now(), current_user, o.* FROM old_table o;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO emp_audit
                SELECT 'U', now(), current_user, n.* FROM new_table n;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO emp_audit
                SELECT 'I', now(), current_user, n.* FROM new_table n;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$emp_audit$ LANGUAGE plpgsql;

CREATE TRIGGER emp_audit_ins
    AFTER INSERT ON emp
    REFERENCING NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION process_emp_audit();
CREATE TRIGGER emp_audit_upd
    AFTER UPDATE ON emp
    REFERENCING OLD TABLE AS old_table NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION process_emp_audit();
CREATE TRIGGER emp_audit_del
    AFTER DELETE ON emp
    REFERENCING OLD TABLE AS old_table
    FOR EACH STATEMENT EXECUTE FUNCTION process_emp_audit();