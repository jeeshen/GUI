package main;

public class ProductSales {
    private Product product;
    private int totalQuantity;
    private double totalSales;

    public ProductSales(Product product, int totalQuantity, double totalSales) {
        this.product = product;
        this.totalQuantity = totalQuantity;
        this.totalSales = totalSales;
    }

    public Product getProduct() {
        return product;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public double getTotalSales() {
        return totalSales;
    }

    @Override
    public String toString() {
        return "Product: " + product.getName() + ", Quantity Sold: " + totalQuantity + ", Sales: RM" + totalSales;
    }
}