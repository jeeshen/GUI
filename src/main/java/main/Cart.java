package main;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Product, Integer> items;

    public Cart() {
        this.items = new HashMap<>();
    }

    public void addProduct(Product product, int quantity) {
        if (product != null && quantity > 0) {
            items.put(product, items.getOrDefault(product, 0) + quantity);
        }
    }

    public void removeProduct(Product product) {
        if (product != null && items.containsKey(product)) {
            items.remove(product);
        }
    }

    public void updateQuantity(Product product, int quantity) {
        if (product != null && items.containsKey(product)) {
            if (quantity > 0) {
                items.put(product, quantity);
            } else {
                items.remove(product);
            }
        }
    }

    public void plusQuantity(Product product, int quantity) {
        if (product != null && quantity > 0) {
            items.put(product, items.getOrDefault(product, 0) + quantity);
        }
    }

    public void minusQuantity(Product product, int quantity) {
        if (product != null && items.containsKey(product)) {
            int newQuantity = items.get(product) - quantity;

            if (newQuantity > 0) {
                items.put(product, newQuantity);
            } else {
                items.remove(product);
            }
        }
    }


    public double calculateTotal() {
        double total = 0;
        for (Map.Entry<Product, Integer> entry : items.entrySet()) {
            total += entry.getKey().getPrice() * entry.getValue();
        }
        return total;
    }

    public void clearCart() {
        items.clear();
    }

    public void displayCart() {
        if (items.isEmpty()) {
            System.out.println("Cart is empty.");
        } else {
            System.out.println("Cart Items:");
            for (Map.Entry<Product, Integer> entry : items.entrySet()) {
                System.out.println(entry.getKey().getName() + " - Quantity: " + entry.getValue() + ", Price: " + entry.getKey().getPrice());
            }
            System.out.println("Total: " + calculateTotal());
        }
    }

    public int getTotalQuantity() {
        int totalQuantity = 0;
        for (int quantity : items.values()) {
            totalQuantity += quantity;
        }
        return totalQuantity;
    }


    public Map<Product, Integer> getItems() {
        return items;
    }
}
