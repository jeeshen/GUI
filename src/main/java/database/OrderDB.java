package database;

import main.Order;
import main.OrderItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderDB {
    public static boolean placeOrder(Order order) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        conn.setAutoCommit(false);
        try {
            String insertOrderSQL = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(insertOrderSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, order.getUserID());
            stmt.setDouble(2, order.getTotalAmount());
            stmt.setString(3, "Pending");
            stmt.executeUpdate();

            int orderID = 0;
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                orderID = rs.getInt(1);
            }

            String insertOrderItemSQL = "INSERT INTO order_items (order_id, product_id, quantity, subtotal) VALUES (?, ?, ?, ?)";
            PreparedStatement itemStmt = conn.prepareStatement(insertOrderItemSQL);
            for (OrderItem item : order.getOrderItems()) {
                itemStmt.setInt(1, orderID);
                itemStmt.setInt(2, item.getProduct().getId());
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.setDouble(4, item.getSubtotal());
                itemStmt.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
