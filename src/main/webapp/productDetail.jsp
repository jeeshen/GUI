<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="main.Product" %>
<%@ page import="database.ProductDB" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<%@ include file="components/header.jsp" %>
<body class="bg-base-100 pb-150 font-inter">
<%
  String productIDParam = request.getParameter("productID");
  int productID = 0;
  Product product = null;

  if (productIDParam != null && !productIDParam.isEmpty()) {
    try {
      productID = Integer.parseInt(productIDParam);
      product = ProductDB.getProductById(productID);
    } catch (NumberFormatException e) {
    }
  }

  DecimalFormat formatter = new DecimalFormat("#,##0.00");
%>

<% if (product != null) { %>
<div class="flex gap-10 mx-90">
  <div class="w-2/3">
    <img class="object-contain h-auto w-full"
         src="<%= !product.getImageUrl().isEmpty() ? request.getContextPath() + "/" + product.getImageUrl() : "images/empty product.png" %>"
         alt="<%= product.getName() %>" />
  </div>
  <div class="w-1/2 bg-base-200 p-10 rounded-lg">
    <p class="text-3xl font-bold"><%=product.getName()%></p>
    <div class="flex justify-between my-5">
      <p class="text-2xl font-semibold"><span class="text-lg">RM</span> <%=formatter.format(product.getPrice())%></p>
      <div class="flex items-center">
        <div class="flex">
          <% for (int i = 0; i < 5; i++) { %>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 <%= i < 4 ? "text-yellow-400" : "text-gray-300" %>" viewBox="0 0 20 20" fill="currentColor">
            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118l-2.8-2.034c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
          </svg>
          <% } %>
        </div>
        <span class="ml-2 text-sm">4.7/5</span>
      </div>
    </div>
    <div>
      <p class="text-lg font-bold my-4">Description</p>
      <p class="text-lg text-gray-500"><%=!product.getDescription().isEmpty() ? product.getDescription() : "-"%></p>
    </div>
    <div>
      <p class="text-lg font-bold my-4">Features</p>
      <table class="table w-full p-0">
        <tr>
          <td>
            <div class="flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
              </svg>
              <div>24-hour battery life</div>
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div class="flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 15a4 4 0 004 4h9a5 5 0 10-.1-9.999 5.002 5.002 0 10-9.78 2.096A4.001 4.001 0 003 15z" />
              </svg>
              <div>Water-resistant (IP56)</div>
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div class="flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
              </svg>
              <div>Drop-resistant</div>
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div class="flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.111 16.404a5.5 5.5 0 017.778 0M12 20h.01m-7.08-7.071c3.904-3.905 10.236-3.905 14.141 0M1.394 9.393c5.857-5.857 15.355-5.857 21.213 0" />
              </svg>
              <div>WiFi</div>
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div class="flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 3v2m6-2v2M9 19v2m6-2v2M5 9H3m2 6H3m18-6h-2m2 6h-2M7 19h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v10a2 2 0 002 2zM9 9h6v6H9V9z" />
              </svg>
              <div>Bluetooth®</div>
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div class="flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19V6l12-3v13M9 19c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zm12-3c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zM9 10l12-3" />
              </svg>
              <div>Automatic Trueplay™</div>
            </div>
          </td>
        </tr>
      </table>
    </div>
    <div class="flex gap-10 mt-10">
      <form method="post" action="${pageContext.request.contextPath}/CartServlet" class="w-full">
        <input type="hidden" name="action" value="add"/>
        <input type="hidden" name="productID" value="<%=product.getId()%>"/>
        <input type="hidden" name="quantity" value="1"/>
        <button type="submit" class="btn btn-success w-full">
          Add to Cart
        </button>
      </form>

      <div class="w-full">
        <a href="${pageContext.request.contextPath}/product.jsp" class="btn btn-outline w-full">
          Back to Products
        </a>
      </div>
    </div>
  </div>
</div>
<% } else { %>
<div class="text-center py-10">
  <h1 class="text-2xl font-bold mb-4">Product Not Found</h1>
  <a href="${pageContext.request.contextPath}/product.jsp" class="btn btn-outline">Return to Shop</a>
</div>
<% } %>
</body>
</html>