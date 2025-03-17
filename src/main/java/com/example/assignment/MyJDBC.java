package com.example.assignment;
import java.sql.*;

public class MyJDBC {
    public static void main(String[] args) throws SQLException {
        Connection conn = DriverManager.getConnection(
          "jdbc:mysql://127.0.0.1:3306/jevore",
                "nbuser",
                "nbuser"
        );

        Statement statement = conn.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM user");

        while (resultSet.next()) {
            System.out.println(resultSet.getString("name"));
        }
    }
}
