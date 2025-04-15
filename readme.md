# 📱 Java Web Application: JEVORE Phone Store

This is a Java web application built for a phone store named **JEVORE**.  
The application uses **Java SDK 21** and is deployed on **Apache Tomcat 11.0.5**. It was developed using **IntelliJ IDEA**.

---

## 🧩 Project Overview

This web application is designed to manage the operations of a phone store, including user registration, product listings, and order processing.  
It follows standard **Java EE architecture** with **Servlets** and **JSP**, and supports deployment on a **Tomcat server**.

---

## 🚀 Technologies Used

- **Java Version:**
  - Runtime: Java 1.8.0_202  
  - SDK: Java 21  
- **Server:** Apache Tomcat 11.0.5  
- **IDE:** IntelliJ IDEA  
- **Database:** MySQL

---

## 🗃️ Database Setup

1. **Create the Database and Tables:**

   Run the following SQL script in your MySQL server:

   ```sql
   CREATE DATABASE `jevore`;

   CREATE TABLE jevore.users (
       id INT PRIMARY KEY AUTO_INCREMENT,
       username VARCHAR(255) NOT NULL,
       email VARCHAR(255) NOT NULL UNIQUE,
       password VARCHAR(255) NOT NULL,
       role VARCHAR(50) DEFAULT 'USER',
       status VARCHAR(50) DEFAULT 'ACTIVE',
       createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   CREATE TABLE jevore.products (
       id INT PRIMARY KEY AUTO_INCREMENT,
       name VARCHAR(255) NOT NULL,
       description TEXT,
       price DOUBLE NOT NULL,
       stock_quantity INT NOT NULL,
       image_url VARCHAR(255),
       status VARCHAR(255) NOT NULL
   );

   CREATE TABLE jevore.orders (
       order_id INT AUTO_INCREMENT PRIMARY KEY,
       user_id INT NOT NULL,
       total_amount DECIMAL(10,2) NOT NULL,
       order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       status VARCHAR(20) DEFAULT 'Pending',
       FOREIGN KEY (user_id) REFERENCES users(id)
   );

   CREATE TABLE jevore.order_items (
       order_item_id INT AUTO_INCREMENT PRIMARY KEY,
       order_id INT NOT NULL,
       product_id INT NOT NULL,
       quantity INT NOT NULL,
       subtotal DECIMAL(10,2) NOT NULL,
       FOREIGN KEY (order_id) REFERENCES orders(order_id),
       FOREIGN KEY (product_id) REFERENCES products(id)
   );
