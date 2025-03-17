package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/ProductServlet")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get product name from form data
        String productName = request.getParameter("name");

        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<html><body>");
        if (productName != null && !productName.trim().isEmpty()) {
            response.getWriter().println("<p style='color: green;'>Product " + productName + " added successfully!</p>");
        } else {
            response.getWriter().println("<p style='color: red;'>Product name cannot be empty!</p>");
        }
        response.getWriter().println("</body></html>");
    }
}
