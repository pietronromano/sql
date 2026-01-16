/*
    Database Roles #
    
    SEE:
        - https://www.postgresql.org/docs/18/database-roles.html
    
    PostgreSQL manages database access permissions using the concept of roles. 
    A role can be thought of as either a database user, or a group of database users
    Database roles are conceptually completely separate from operating system users. 
    In practice it might be convenient to maintain a correspondence, but this is not required. 
    Database roles are global across a database cluster installation (and not per individual database). 

*/

--  To create a role use the CREATE ROLE SQL command:
CREATE ROLE my_role;
 
 
-- login privilege: Only roles that have the LOGIN attribute can be used as the initial role name for a database connection. 
-- A role with the LOGIN attribute can be considered the same as a “database user”. 
--To create a role with login privilege, use either:
CREATE ROLE name LOGIN;
CREATE USER name;
-- (CREATE USER is equivalent to CREATE ROLE except that CREATE USER includes LOGIN by default, while CREATE ROLE does not.)

-- Create a role with a password that is valid until the end of 2004
CREATE ROLE miriam WITH LOGIN PASSWORD 'jw8s0F4' VALID UNTIL '2005-01-01';

-- Create a role that can create databases and manage roles:
CREATE ROLE admin WITH CREATEDB CREATEROLE;


-- To remove an existing role, use the analogous DROP ROLE command:
DROP ROLE name;

-- For convenience, the programs createuser and dropuser are provided as wrappers around these SQL commands that can be called from the shell command line:
createuser name
dropuser name

-- To determine the set of existing roles, examine the pg_roles system catalog, for example:

SELECT * FROM pg_roles;

--or to see just those capable of logging in:
SELECT rolname FROM pg_roles WHERE rolcanlogin;


-- Role Membership ----------------------------------------------------------------
/*
    Create a role that represents the group, and then granting membership in the group role to individual user roles.
    Once the group role exists, you can add and remove members using the GRANT and REVOKE commands:
    SEE: https://www.postgresql.org/docs/18/role-membership.html
*/

GRANT group_role TO role1, ... ;
REVOKE group_role FROM role1, ... ;

-- Dropping Roles  ----------------------------------------------------------------
/*
    Because roles can own database objects and can hold privileges to access other objects, 
    Dropping a role is often not just a matter of a quick DROP ROLE. 
    Any objects owned by the role must first be dropped or reassigned to other owners; and any permissions granted to the role must be revoked.
*/

-- Ownership of objects can be transferred one at a time using ALTER commands, for example:
ALTER TABLE bobs_table OWNER TO alice;

-- the most general recipe for removing a role that has been used to own objects is:
REASSIGN OWNED BY doomed_role TO successor_role;
DROP OWNED BY doomed_role;
-- repeat the above commands in each database of the cluster
DROP ROLE doomed_role;