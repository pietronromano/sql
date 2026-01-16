/*
    Grant / Revoke privileges / Role Membership
    
    SEE:
        - https://www.postgresql.org/docs/18/sql-grant.html
        - https://www.postgresql.org/docs/18/sql-revoke.html
    
    The GRANT command has two basic variants: 
        - One that grants privileges on a database object (table, column, view, foreign table, sequence, database, foreign-data wrapper, foreign server, function, procedure, procedural language, large object, configuration parameter, schema, tablespace, or type)
        - One that grants membership in a role. 
    
    The key word PUBLIC indicates that the privileges are to be granted to all roles, including those that might be created later. 
*/

-- Grant insert privilege to all users [PUBLIC] on table films:
GRANT INSERT ON films TO PUBLIC;

-- Grant all available privileges to user manuel on view vw_kinds:
GRANT ALL PRIVILEGES ON vw_kinds TO manuel;

-- Grant membership in role admins to user joe:
GRANT admins TO joe;

-- Revoke --------------
/*
    --The REVOKE command revokes previously granted privileges from one or more roles.
*/

-- Revoke insert privilege for the public on table films:
REVOKE INSERT ON films FROM PUBLIC;

-- Revoke all privileges from user manuel on view vw_kinds:
REVOKE ALL PRIVILEGES ON vw_ kinds FROM manuel;
-- Note that this actually means “revoke all privileges that I granted”.

-- Revoke membership in role admins from user joe:
REVOKE admins FROM joe;