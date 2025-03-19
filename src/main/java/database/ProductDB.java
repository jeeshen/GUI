package database;

import main.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDB {
    public static void addProduct(Product product) {
        String sql = "INSERT INTO products (name, description, price, stock_quantity, image_url, status) VALUES (?, ?, ?, ?, ?, 'ACTIVE')";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getDescription());
            pstmt.setDouble(3, product.getPrice());
            pstmt.setInt(4, product.getStockQuantity());
            pstmt.setString(5, product.getImageUrl());

            pstmt.executeUpdate();
            System.out.println("Product added successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE status = 'ACTIVE'";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"),
                        rs.getString("status")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public static Product getProductById(int productId) {
        String sql = "SELECT * FROM products WHERE id = ? AND status = 'ACTIVE'";
        Product product = null;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"),
                        rs.getString("status")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

    public static List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? AND status = 'ACTIVE'";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"),
                        rs.getString("status")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public static void updateProduct(Product product) {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, stock_quantity = ?, image_url = ? WHERE id = ? AND status = 'ACTIVE'";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            System.out.println("sds");
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getDescription());
            pstmt.setDouble(3, product.getPrice());
            pstmt.setInt(4, product.getStockQuantity());
            pstmt.setString(5, product.getImageUrl());
            pstmt.setInt(6, product.getId());

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Product updated successfully!");
            } else {
                System.out.println("Product not found or inactive.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static void updateStock(int productId, int newStock) {
        String sql = "UPDATE products SET stock_quantity = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, newStock);
            pstmt.setInt(2, productId);
            pstmt.executeUpdate();

            System.out.println("Stock updated successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteProduct(int productId) {
        String sql = "UPDATE products SET status = 'DELETED' WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, productId);
            pstmt.executeUpdate();

            System.out.println("Product deleted successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
