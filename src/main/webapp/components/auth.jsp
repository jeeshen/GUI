<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%--To check whether user has permission to access the page--%>
<%
  HttpSession userSession = request.getSession();
  String sessionName = (String) userSession.getAttribute("user");
  String sessionRole = (String) userSession.getAttribute("userRole");

  if (sessionName == null) {
    sessionName = "";
    sessionRole = "";
  }

  String pagePath = request.getRequestURI();
  if (sessionRole.isEmpty() || sessionRole.equals("USER")) {
    if (pagePath.contains("admin/")) {
      response.sendRedirect(request.getContextPath() + "/account.jsp");
    }
  } else if (sessionRole.equals("STAFF")) {
    if (pagePath.contains("admin/user.jsp")) {
      response.sendRedirect(request.getContextPath() + "home.jsp");
    } else if (pagePath.contains("admin/staff.jsp")) {
      response.sendRedirect(request.getContextPath() + "home.jsp");
    }
  }
%>