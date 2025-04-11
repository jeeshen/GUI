package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

//To build connections with database
public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://127.0.0.1:3306/jevore";
    private static final String USER = "nbuser";
    private static final String PASSWORD = "nbuser";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
