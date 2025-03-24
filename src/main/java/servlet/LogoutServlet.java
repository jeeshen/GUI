package servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        System.out.println(session.getAttribute("user"));
        if (session != null) {
            session.invalidate();
            Cookie cookie = new Cookie("rememberedUser", "");
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
        }

        response.sendRedirect("index.jsp");
    }
}