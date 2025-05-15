/**
 * @title DbConnection
 * @author praveenkumar raja
 * @version 1.0
 */
package com.praveen.crud_operations;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

final public class DbConnection {
    private Connection connection;

    /**
     * DbConnection constructor
     */
    private DbConnection() throws SQLException {
    	try {
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://localhost:5432/shopping";
            String username = "postgres";
            String password = "root";
            this.connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException ex) {
            System.out.println("PostgreSQL JDBC Driver not found: " + ex.getMessage());
        } catch (SQLException ex) {
            System.out.println("Connection failed: " + ex.getMessage());
        }
    }

    /**
     * get connection
     *
     * @return Connection
     */
    public Connection getConnection() {
        return connection;
    }

    /**
     * get DbConnection
     *
     * @return DbConnection
     */
    public static DbConnection getInstance() throws SQLException {
        try {
            return new DbConnection();
        } catch (Exception exception) {
            System.out.println(exception.getMessage());
        }
        return null;
    }
}
