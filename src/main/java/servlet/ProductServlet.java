package servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import main.Product;
import database.ProductDB;

@WebServlet("/ProductServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class ProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("action").equals("add")) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            description = description == null ? "" : description;
            Part filePart = request.getPart("image");

            String imagePath = "";

            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = getServletContext().getRealPath("") + File.separator + "uploads";
                System.out.println(uploadDir);
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) uploadDirFile.mkdir();
                String filePath = uploadDir + File.separator + fileName;
                filePart.write(filePath);
                imagePath = "uploads/" + fileName;
            }

            Product product = new Product(0, name, description, price, quantity, imagePath, "active");
            ProductDB.addProduct(product);

            request.getSession().setAttribute("successMessage", "Product added successfully!");
            response.sendRedirect("/admin/product.jsp");
        } else if (request.getParameter("action").equals("bulkDelete")) {
            String[] selectedProductIds = request.getParameterValues("selectedProduct");
            if (selectedProductIds != null) {
                for (String id : selectedProductIds) {
                    int productId = Integer.parseInt(id);
                    ProductDB.deleteProduct(productId);
                }
            }
            request.getSession().setAttribute("successMessage", "Selected products deleted successfully!");
            response.sendRedirect("/admin/product.jsp");
        } else if (request.getParameter("action").equals("delete")) {
            String productIdParam = request.getParameter("productID");
            String[] selectedProductIds = request.getParameterValues("selectedProduct");

            if (selectedProductIds != null && selectedProductIds.length > 0) {
                for (String id : selectedProductIds) {
                    int productId = Integer.parseInt(id);
                    ProductDB.deleteProduct(productId);
                }
                request.getSession().setAttribute("successMessage", "Selected products deleted successfully!");
            }
            else if (productIdParam != null && !productIdParam.trim().isEmpty()) {
                int productId = Integer.parseInt(productIdParam);
                ProductDB.deleteProduct(productId);
                request.getSession().setAttribute("successMessage", "Selected product deleted successfully!");
            }
            else {
                request.getSession().setAttribute("errorMessage", "No product selected for deletion.");
            }

            response.sendRedirect("/admin/product.jsp");
        }
    }
}
