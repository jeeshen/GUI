<%@ page import="java.util.List" %>
<%@ page import="main.Product" %>
<%@ page import="database.ProductDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  List<Product> productList = ProductDB.getAllProducts();
  Product editingProduct = new Product();
%>
<html>
  <%--Manage products here, able to add, update and delete products--%>
  <%@ include file="../components/head.jsp" %>
  <body style="margin: 0">
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%
      String successMessage = (String) session.getAttribute("successMessage");
      if (successMessage != null) {
        session.removeAttribute("successMessage");
    %>
    <div role="alert" class="alert alert-success w-auto px-4 absolute bottom-10 right-5">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 shrink-0 stroke-current" fill="none" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
      </svg>
      <span class="text-semibold text-md"><%= successMessage%></span>
    </div>
    <%
      }
    %>
    <%
      String productIDStr = request.getParameter("productID");
      if (productIDStr != null && !productIDStr.isEmpty()) {
        int productID = Integer.parseInt(productIDStr);
        editingProduct = ProductDB.getProductById(productID);
      }
    %>
    <%@ include file="../components/sidebar.jsp"%>
    <dialog id="add_product" class="modal">
      <div class="modal-box" style="width: 350px">
      <h3 class="text-lg font-bold flex justify-center">Adding Product</h3>
        <div class="flex justify-center">
          <form method="post" action="${pageContext.request.contextPath}/ProductServlet" enctype="multipart/form-data" onsubmit="return validateAddProduct()">
            <fieldset class="fieldset">
              <legend class="fieldset-legend">Product Name</legend>
              <input type="text" class="input" name="name" id="addName" placeholder="Type here" />
              <p class="fieldset-label">Compulsory</p>
              <span class="text-red-500" id="addNameError"></span>
            </fieldset>

            <fieldset class="fieldset mt-2">
              <legend class="fieldset-legend">Description</legend>
              <input type="text" class="input" name="description" placeholder="Type here" />
              <p class="fieldset-label">Optional</p>
            </fieldset>

            <fieldset class="fieldset mt-2">
              <legend class="fieldset-legend">Price</legend>
              <input type="text" class="input" name="price" id="addPrice" placeholder="Type here" />
              <p class="fieldset-label">Compulsory</p>
              <span class="text-red-500" id="addPriceError"></span>
            </fieldset>

            <fieldset class="fieldset mt-2">
              <legend class="fieldset-legend">Stock Quantity</legend>
              <input type="number" class="input" name="quantity" id="addQuantity" placeholder="Type here" />
              <p class="fieldset-label">Compulsory</p>
              <span class="text-red-500" id="addQuantityError"></span>
            </fieldset>

            <fieldset class="fieldset mt-2">
              <legend class="fieldset-legend">Image</legend>
              <input type="file" class="file-input" name="image" id="addImage"/>
              <p class="fieldset-label">Optional</p>
              <span class="text-red-500" id="addImageError"></span>
            </fieldset>

            <input type="hidden" name="action" value="add"/>
            <button type="submit" class="btn btn-neutral w-full mt-4">Add Product</button>
          </form>
        </div>
      </div>
      <form method="dialog" class="modal-backdrop">
        <button>close</button>
      </form>
    </dialog>
    <dialog id="edit_product" class="modal">
      <div class="modal-box" style="width: 350px">
        <h3 class="text-lg font-bold flex justify-center">Editing Product</h3>
        <div class="flex justify-center">
          <form method="post" action="${pageContext.request.contextPath}/ProductServlet" enctype="multipart/form-data" onsubmit="return validateEditProduct()">
            <fieldset class="fieldset">
              <legend class="fieldset-legend">New Product Name</legend>
              <input type="text" class="input" name="name" id="editName" placeholder="Type here" value="<%=editingProduct.getName()%>"/>
              <p class="fieldset-label">Compulsory</p>
              <span class="text-red-500" id="editNameError"></span>
            </fieldset>

            <fieldset class="fieldset mt-2">
              <legend class="fieldset-legend">Description</legend>
              <input type="text" class="input" name="description" placeholder="Type here" value="<%=editingProduct.getDescription()%>"/>
              <p class="fieldset-label">Optional</p>
            </fieldset>

            <fieldset class="fieldset mt-2">
              <legend class="fieldset-legend">Price</legend>
              <input type="text" class="input" name="price" id="editPrice" placeholder="Type here" value="<%=editingProduct.getPrice()%>"/>
              <p class="fieldset-label">Compulsory</p>
              <span class="text-red-500" id="editPriceError"></span>
            </fieldset>

            <fieldset class="fieldset mt-2">
              <legend class="fieldset-legend">Stock Quantity</legend>
              <input type="number" class="input" name="quantity" id="editQuantity" placeholder="Type here" value="<%=editingProduct.getStockQuantity()%>"/>
              <p class="fieldset-label">Compulsory</p>
              <span class="text-red-500" id="editQuantityError"></span>
            </fieldset>

            <fieldset class="fieldset mt-2">
              <legend class="fieldset-legend">Image</legend>
              <input type="file" class="file-input" name="image" id="editImage"/>
              <p class="fieldset-label">Optional</p>
              <span class="text-red-500" id="editImageError"></span>
            </fieldset>

            <input type="hidden" name="productID" value="<%=editingProduct.getId()%>"/>
            <input type="hidden" name="action" value="update"/>
            <button type="submit" class="btn btn-neutral w-full mt-4">Update Product</button>
          </form>
        </div>
      </div>
      <form method="dialog" class="modal-backdrop">
        <button>close</button>
      </form>
    </dialog>
    <div class="ml-70 font-inter">
      <div class="overflow-x-auto mt-4">
        <form method="post" action="${pageContext.request.contextPath}/ProductServlet">
          <table class="table">
            <thead>
              <tr>
                <th>
                  <label>
                    <input type="checkbox" class="checkbox" id="selectAll"/>
                  </label>
                </th>
                <th>Product Name</th>
                <th>Description</th>
                <th>Price (RM)</th>
                <th>Stock Quantity</th>
                <th>Rating</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
            <%
              for (Product product : productList) {
            %>
              <tr>
                <th>
                  <label>
                    <input type="checkbox" class="checkbox" name="selectedProduct" value="<%= product.getId() %>"/>
                  </label>
                </th>
                <td>
                  <div class="flex items-center gap-3">
                    <div class="avatar">
                      <div class="mask mask-squircle h-12 w-12">
                        <img
                                src="<%= !product.getImageUrl().isEmpty() ? request.getContextPath() + "/" + product.getImageUrl() : "../images/empty product.png" %>"
                                alt="Product Image" />
                      </div>
                    </div>
                    <div>
                      <div class="font-bold"><%=product.getName()%></div>
                    </div>
                  </div>
                </td>
                <td>
                  <%=!product.getDescription().isEmpty() ? product.getDescription() : "-" %>
                </td>
                <td><%=product.getPrice()%></td>
                <td><%=product.getStockQuantity()%></td>
                <td>0</td>
                <td>
                  <div class="flex gap-4">
                    <div>
                      <a href="<%= request.getRequestURL().toString() %>?productID=<%= product.getId() %>" type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-pencil"><path d="M21.174 6.812a1 1 0 0 0-3.986-3.987L3.842 16.174a2 2 0 0 0-.5.83l-1.321 4.352a.5.5 0 0 0 .623.622l4.353-1.32a2 2 0 0 0 .83-.497z"/><path d="m15 5 4 4"/></svg>
                      </a>
                    </div>
                    <form method="post" action="${pageContext.request.contextPath}/ProductServlet">
                      <input type="hidden" name="action" value="delete"/>
                      <input type="hidden" name="productID" value="<%= product.getId() %>"/>
                      <button type="submit">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash-2"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
                      </button>
                    </form>
                  </div>
                </td>
              </tr>
            <% } %>
              <tr>
                <td>
                    <input type="hidden" name="action" value="delete"/>
                    <button type="submit" id="deleteSelected" class="hidden">
                      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash-2 text-red-500"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
                    </button>
                </td>
                <td class="text-gray col-span-4 justify-left text-md">
                  <a onclick="add_product.showModal()" class="flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-plus mr-2"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
                    Add new product
                  </a>
                </td>
              </tr>
            </tbody>
          </table>
        </form>
      </div>
    </div>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        <% if (editingProduct != null && editingProduct.getId() != 0) { %>
        edit_product.showModal();
        <% } %>
      });

      function validateAddProduct() {
        let isValid = true;

        let name = document.getElementById("addName").value.trim();
        let price = document.getElementById("addPrice").value.trim();
        let quantity = document.getElementById("addQuantity").value.trim();
        var imageInput = document.getElementById("addImage");

        document.getElementById("addNameError").textContent = "";
        document.getElementById("addPriceError").textContent = "";
        document.getElementById("addQuantityError").textContent = "";
        document.getElementById("addImageError").textContent = "";

        if (name === "") {
          document.getElementById("addNameError").textContent = "Product Name is required.";
          isValid = false;
        }

        if (price === "" || isNaN(price) || parseFloat(price) <= 0) {
          document.getElementById("addPriceError").textContent = "Enter a valid price.";
          isValid = false;
        }

        if (quantity === "" || isNaN(quantity) || parseInt(quantity) <= 0) {
          document.getElementById("addQuantityError").textContent = "Enter a valid stock quantity.";
          isValid = false;
        }

        if (imageInput.files.length > 0) {
          var fileSize = imageInput.files[0].size;
          var maxSize = 2 * 1024 * 1024;
          if (fileSize > maxSize) {
            document.getElementById("addImageError").textContent = "Image size should be less than 2MB.";
            isValid = false;
          }
        }

        return isValid;
      }

      function validateEditProduct() {
        let isValid = true;

        let name = document.getElementById("editName").value.trim();
        let price = document.getElementById("editPrice").value.trim();
        let quantity = document.getElementById("editQuantity").value.trim();
        var imageInput = document.getElementById("editImage");

        document.getElementById("editNameError").textContent = "";
        document.getElementById("editPriceError").textContent = "";
        document.getElementById("editQuantityError").textContent = "";
        document.getElementById("editImageError").textContent = "";

        if (name === "") {
          document.getElementById("editNameError").textContent = "Product Name is required.";
          isValid = false;
        }

        if (price === "" || isNaN(price) || parseFloat(price) <= 0) {
          document.getElementById("editPriceError").textContent = "Enter a valid price.";
          isValid = false;
        }

        if (quantity === "" || isNaN(quantity) || parseInt(quantity) <= 0) {
          document.getElementById("editQuantityError").textContent = "Enter a valid stock quantity.";
          isValid = false;
        }

        if (imageInput.files.length > 0) {
          var fileSize = imageInput.files[0].size;
          var maxSize = 2 * 1024 * 1024;
          if (fileSize > maxSize) {
            document.getElementById("editImageError").textContent = "Image size should be less than 2MB.";
            isValid = false;
          }
        }

        return isValid;
      }

      document.addEventListener("DOMContentLoaded", function () {
        const selectAllCheckbox = document.getElementById("selectAll");
        const checkboxes = document.querySelectorAll("tbody input[type='checkbox']");
        const deleteButton = document.getElementById("deleteSelected");

        function updateDeleteButtonVisibility() {
          const anyChecked = [...checkboxes].some(checkbox => checkbox.checked);
          deleteButton.style.display = anyChecked ? "block" : "none";
        }

        selectAllCheckbox.addEventListener("change", function () {
          checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
          });
          updateDeleteButtonVisibility();
        });

        checkboxes.forEach(checkbox => {
          checkbox.addEventListener("change", updateDeleteButtonVisibility);
        });
      });
    </script>
  </body>
</html>
