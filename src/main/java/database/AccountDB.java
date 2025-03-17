package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Class to handle all database operations related to user accounts
 */
public class AccountDB {

    /**
     * Validates a user's credentials
     *
     * @param email User's email
     * @param password User's password
     * @return true if credentials are valid, false otherwise
     */
    public static boolean validateUser(String email, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password); // Note: In production, password hashing should be used

            rs = pstmt.executeQuery();
            return rs.next(); // Returns true if matching user credentials are found
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            // Close resources
            closeResources(rs, pstmt, conn);
        }
    }

    /**
     * Gets the role of a user
     *
     * @param email User's email
     * @return User's role, defaults to "USER" if not found
     */
    public static String getUserRole(String email) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String role = "USER"; // Default role

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT role FROM users WHERE email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                role = rs.getString("role");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            closeResources(rs, pstmt, conn);
        }
        return role;
    }

    /**
     * Registers a new user
     *
     * @param email User's email
     * @param username User's username
     * @param password User's password
     * @return true if registration is successful, false otherwise
     */
    public static boolean registerUser(String email, String username, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            // Using database structure including the role field
            String sql = "INSERT INTO users (email, username, password, role) VALUES (?, ?, ?, 'USER')";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, username);
            pstmt.setString(3, password); // Note: In production, password hashing should be used

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            // Close resources
            closeResources(null, pstmt, conn);
        }
    }

    /**
     * Helper method to close database resources
     *
     * @param rs ResultSet to close
     * @param pstmt PreparedStatement to close
     * @param conn Connection to close
     */
    private static void closeResources(ResultSet rs, PreparedStatement pstmt, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}