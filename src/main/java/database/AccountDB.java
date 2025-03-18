package database;

import main.Account;
import main.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AccountDB {

    public static Account getAccountByEmail(String email) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Account account = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String role = rs.getString("role");
                String status = rs.getString("status");
                String createdAt = rs.getString("createdAt");
                account = new Account(id, email, username, password, role, status, createdAt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return account;
    }

    public static Account getAccountById(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Account account = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                String email = rs.getString("email");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String role = rs.getString("role");
                String status = rs.getString("status");
                String createdAt = rs.getString("createdAt");
                account = new Account(id, email, username, password, role, status, createdAt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return account;
    }

    public static boolean validateUser(String email, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isValid = false;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND status = 'ACTIVE'";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();
            isValid = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return isValid;
    }

    public static String getUserRole(String email) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String role = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT role FROM users WHERE email = ? AND status = 'ACTIVE'";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                role = rs.getString("role");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return role;
    }

    public static List<Account> getAllUsers() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Account> users = new ArrayList<>();

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE status = 'ACTIVE'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String email = rs.getString("email");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String role = rs.getString("role");
                String status = rs.getString("status");
                String createdAt = rs.getString("createdAt");
                users.add(new Account(id, email, username, password, role, status, createdAt));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return users;
    }

    public static List<Account> getAllUsersOnly() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Account> users = new ArrayList<>();

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE status = 'ACTIVE' AND role = 'USER'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String email = rs.getString("email");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String role = rs.getString("role");
                String status = rs.getString("status");
                String createdAt = rs.getString("createdAt");
                users.add(new Account(id, email, username, password, role, status, createdAt));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return users;
    }

    public static boolean registerUser(String email, String username, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            if (getAccountByEmail(email) != null) {
                return false;
            }

            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO users (email, username, password, role, status) VALUES (?, ?, ?, 'USER', 'ACTIVE')";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, username);
            pstmt.setString(3, password);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }

    public static boolean registerUser(Account account) {
        String sql = "INSERT INTO users (username, email, password, role, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, account.getUsername());
            pstmt.setString(2, account.getEmail());
            pstmt.setString(3, account.getPassword());
            pstmt.setString(4, account.getRole());
            pstmt.setString(5, account.getStatus());

            pstmt.executeUpdate();
            System.out.println("User added successfully!");

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateUser(Account account) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE users SET username = ?, email = ?, password = ?, role = ?, status = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, account.getUsername());
            pstmt.setString(2, account.getEmail());
            pstmt.setString(3, account.getPassword());
            pstmt.setString(4, account.getRole());
            pstmt.setString(5, account.getStatus());
            pstmt.setString(6, String.valueOf(account.getId()));

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }

    public static boolean deleteUser(String email) {
        String sql = "UPDATE users SET status = 'DELETED' WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

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