package com.miempresa.jdbctests;

import java.io.*;
import java.math.BigDecimal;
import java.util.Properties;

import java.sql.*;
import java.util.Scanner;

public class TestApp {
    public static void main(String[] args) {
        Connection myConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;

        try {
            myConn = connect();
            if (myConn == null)
                return;
            //Comment/uncomment the methods below to test:
            select(myConn);
            //insert(myConn);
            //update(myConn);
            //delete(myConn);
            //preparedStatement(myConn);
            //storeProcedure(myConn);
            //transaction(myConn);
            //metadata(myConn);
            //writeBlob(myConn);
            //readBlob(myConn);

        } catch (Exception e) {
            System.out.println("An error occurred while connecting to PostgreSQL:");
            e.printStackTrace();
        }
        finally {
            close(myConn, myStmt, myRs);
        }

    }

    private static Connection connect() {
        // 1. Load the properties file
        Properties props = new Properties();
        try {
            props.load(new FileInputStream("db.properties"));
        } catch (IOException e) {
            System.out.println("Couldn't load db.properties file:");
            e.printStackTrace();
        }


        String user = "postgres";

        // 2. Read the props
        String user = props.getProperty("user");
        String password = props.getProperty("password");
        String dburl = props.getProperty("dburl");
        String schema = props.getProperty("schema");

        System.out.println("Connecting to database...");
        System.out.println("Database URL: " + dburl);
        System.out.println("User: " + user);

        // 3. Get a connection to database
        try {
            Connection myConn = DriverManager.getConnection(dburl, user, password);
            System.out.println("\nConnection successful!\n");
            myConn.setSchema(schema);
            return myConn;
        } catch (SQLException e) {
            System.out.println("An error occurred while connecting to PostgreSQL:");
            e.printStackTrace();
            return null;
        }
    }
    /**
     * Prompts the user. Return true if they enter "yes", false otherwise
     * @return response
     */
    private static boolean askUserIfOkToSave() {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Is it okay to save?  yes/no: ");
        String input = scanner.nextLine();

        scanner.close();

        return input.equalsIgnoreCase("yes");
    }

    private static void close(Connection myConn, Statement myStmt, ResultSet myRs)
    {
        try {
            if (myRs != null && !myRs.isClosed()) {
                myRs.close();
            }

            if (myStmt != null && !myStmt.isClosed()) {
                myStmt.close();
            }

            if (myConn != null && !myConn.isClosed()) {
                myConn.close();
            }
        }
        catch (SQLException e) {
            System.out.println("An error occurred while closing connection to PostgreSQL:");
            e.printStackTrace();
        }
    }

    private static void select(Connection myConn) {
        Statement myStmt = null;
        ResultSet myRs = null;
        try {
            // 2. Create a statement
            myStmt = myConn.createStatement();

            // 3. Execute SQL query
            myRs = myStmt.executeQuery("SELECT * FROM clientes");

            // 4. Process the result set
            while (myRs.next()) {
                System.out.println(myRs.getString("apellidos") + ", " + myRs.getString("nombres"));
            }
        }
        catch (Exception exc) {
            exc.printStackTrace();
        }
        finally {
            close(null,myStmt,myRs);
        }
    }

    private static void insert(Connection myConn) {
        Statement myStmt = null;
        ResultSet myRs = null;
        try {
            // 1. Create a statement
            myStmt = myConn.createStatement();

            // 2. Insert a new employee
            System.out.println("Insertand un nuevo cliente en la base de datos\n");
            // Use a Java 15 Text Block
            String sql = """
                    INSERT INTO clientes
                    	(nif,nombres, apellidos, fecha_alta, activo, comentarios)
                    VALUES
                    	('99999999Z', 'Nombres9', 'Apellidos9', '2009-01-01', TRUE,'Commentarios 9')
                    RETURNING *;
                    """;
            boolean success= myStmt.execute(sql); //Update

            /*Alternative
            //int rowsAffected= myStmt.executeUpdate(sql); //But this doesn't allow RETURNING *
            //System.out.println("Inserted " + rowsAffected + " rows.");
            */

            // 4. Process the result set from RETURNING *, Obtener nuevo ID
            myRs = myStmt.getResultSet();
            while (myRs.next()) {
                System.out.println(myRs.getInt("id_cliente") + ", " + myRs.getString("nombres") + ", " + myRs.getString("apellidos"));
            }
        }
        catch (Exception exc) {
            exc.printStackTrace();
        }
        finally {
            close(null,myStmt,myRs);
        }
    }

    private static void update(Connection myConn) {
        Statement myStmt = null;
        ResultSet myRs = null;
        try {
            // 1. Create a statement
            myStmt = myConn.createStatement();

            // 2. Insert a new employee
            System.out.println("Actualizar un cliente\n");
            // Use a Java 15 Text Block
            String sql = """
                    UPDATE clientes SET apellidos = 'Apellidos Modficado' WHERE nif = '99999999Z'
                    """;
            int rowsAffected= myStmt.executeUpdate(sql);
            System.out.println("Updated " + rowsAffected + " rows.");
        }
        catch (Exception exc) {
            exc.printStackTrace();
        }
        finally {
            close(null,myStmt,myRs);
        }
    }

    private static void delete(Connection myConn) {
        Statement myStmt = null;
        ResultSet myRs = null;
        try {
            // 1. Create a statement
            myStmt = myConn.createStatement();

            // 2. Insert a new employee
            System.out.println("Suprimir un cliente\n");
            // Use a Java 15 Text Block
            String sql = """
                    DELETE FROM clientes WHERE nif = '99999999Z'
                    """;
            int rowsAffected= myStmt.executeUpdate(sql);
            System.out.println("Deleted " + rowsAffected + " rows.");
        }
        catch (Exception exc) {
            exc.printStackTrace();
        }
        finally {
            close(null,myStmt,myRs);
        }
    }

    private static void preparedStatement(Connection myConn) {
        PreparedStatement myStmt = null;
        ResultSet myRs = null;
        try {
            // 1. Prepare statement
            myStmt = myConn.prepareStatement("select * from productos where precio = ? and nombre = ?");

            // 2. Set the parameters
            myStmt.setBigDecimal(1, BigDecimal.valueOf(1000));
            myStmt.setString(2, "Portátil 1");

            // 3. Execute SQL query
            myRs = myStmt.executeQuery();

            // 4. Process the result set
            while (myRs.next()) {
                System.out.println(myRs.getString("nombre") + ", " + myRs.getBigDecimal("precio"));
            }

            // Reuse the prepared statement:
            System.out.println("\n\nReuse the prepared statement:  salary > 25000,  department = HR");
            // 5. Set the parameters
            myStmt.setBigDecimal(1, BigDecimal.valueOf(2000));
            myStmt.setString(2, "Portátil 2");

            // 6. Execute SQL query
            myRs = myStmt.executeQuery();

            // 7. Process the result set
            while (myRs.next()) {
                System.out.println(myRs.getString("nombre") + ", " + myRs.getBigDecimal("precio"));
            }
            myStmt.close();
        }
        catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    private static void storeProcedure(Connection myConn) {
        CallableStatement myStmt = null;
        ResultSet myRs = null;
        try {

            // 1. Prepare the stored procedure call: num_pedidos
            myStmt = myConn.prepareCall("CALL pedidos_insert(?)");

            // Set the parameters
            int num_pedidos = 10;
            myStmt.setInt(1, num_pedidos);
            // Call stored procedure
            System.out.println("Calling stored procedure: pedidos_insert(" + num_pedidos + ", ?)");
            myStmt.execute();
            System.out.println("Finished calling stored procedure");
            myStmt.close();
        }
        catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    private static void transaction(Connection myConn) {
        Statement myStmt = null;
        ResultSet myRs = null;
        try {
            // 1. Start the transaction by setting AutoCommit to false
            myConn.setAutoCommit(false);

            // 1. Create a statement
            myStmt = myConn.createStatement();

            // 2. Insert a new employee
            System.out.println("Actualizar un cliente\n");
            // Use a Java 15 Text Block
            String sql = """
                    UPDATE clientes SET apellidos = 'Apellidos Modficado en transacción' WHERE nif = '11111111A'
                    """;
            int rowsAffected= myStmt.executeUpdate(sql);
            System.out.println("Updated " + rowsAffected + " rows.");

            System.out.println("\n>> Transaction steps are ready.\n");

            // Ask user if it is okay to save
            boolean ok = askUserIfOkToSave();

            if (ok) {
                // store in database
                myConn.commit();
                   System.out.println("\n>> Transaction COMMITTED.\n");
            } else {
                // discard
                myConn.rollback();
                System.out.println("\n>> Transaction ROLLED BACK.\n");
            }
        }
        catch (Exception exc) {
            exc.printStackTrace();
        }
        finally {
            close(null,myStmt,myRs);
        }
    }

    private static void metadata(Connection myConn) {
        Statement myStmt = null;
        ResultSet myRs = null;
        try {
            // 2. Create a statement
            myStmt = myConn.createStatement();

            // 3. Execute SQL query
            myRs = myStmt.executeQuery("SELECT * FROM clientes WHERE id_cliente = -1");

            ResultSetMetaData rsMetaData = myRs.getMetaData();
            // 4. Display info
            int columnCount = rsMetaData.getColumnCount();
            System.out.println("Column count: " + columnCount + "\n");

            for (int column=1; column <= columnCount; column++) {
                System.out.println("Column name: " + rsMetaData.getColumnName(column));
                System.out.println("Column type name: " + rsMetaData.getColumnTypeName(column));
                System.out.println("Is Nullable: " + rsMetaData.isNullable(column));
                System.out.println("Is Auto Increment: " + rsMetaData.isAutoIncrement(column) + "\n");
            }

            // 4. Process the result set
            while (myRs.next()) {
                System.out.println(myRs.getString("apellidos") + ", " + myRs.getString("nombres"));
            }
        }
        catch (Exception exc) {
            exc.printStackTrace();
        }
        finally {
            close(null,myStmt,myRs);
        }
    }

    /**
     * Ejemplo: POR implementar en comercio db
     * @param myConn
     */
    public static void readBlob(Connection myConn) {

        Statement myStmt = null;
        ResultSet myRs = null;

        InputStream input = null;
        FileOutputStream output = null;

        try {
            // 1. Execute statement
            myStmt = myConn.createStatement();
            String sql = "select resume from employees where email='john.doe@foo.com'";
            myRs = myStmt.executeQuery(sql);

            // 3. Set up a handle to the file
            File theFile = new File("resume_from_db.pdf");
            output = new FileOutputStream(theFile);

            if (myRs.next()) {

                input = myRs.getBinaryStream("resume");
                System.out.println("Reading resume from database...");
                System.out.println(sql);

                byte[] buffer = new byte[1024];
                while (input.read(buffer) > 0) {
                    output.write(buffer);
                }

                System.out.println("\nSaved to file: " + theFile.getAbsolutePath());

                System.out.println("\nCompleted successfully!");
            }

        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    /**
     * Ejemplo: POR implementar en comercio db
     * @param myConn
     */
    public static void writeBlob(Connection myConn) {

        PreparedStatement myStmt = null;
        FileInputStream input = null;

        try {
            // 2. Prepare statement
            String sql = "update employees set resume=? where email='john.doe@foo.com'";
            myStmt = myConn.prepareStatement(sql);

            // 3. Set parameter for resume file name
            File theFile = new File("sample_resume.pdf");
            input = new FileInputStream(theFile);
            myStmt.setBinaryStream(1, input);

            System.out.println("Reading input file: " + theFile.getAbsolutePath());

            // 4. Execute statement
            System.out.println("\nStoring resume in database: " + theFile);
            System.out.println(sql);

            myStmt.executeUpdate();

            System.out.println("\nCompleted successfully!");
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }
}


