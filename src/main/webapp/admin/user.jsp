<%@ page import="java.util.List" %>
<%@ page import="main.Account" %>
<%@ page import="database.AccountDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  List<Account> accountList = AccountDB.getAllUsersOnly();
  Account editingAccount = new Account();
%>
<html>
<%@ include file="../components/head.jsp" %>
<body style="margin: 0">
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

  String errorMessage = (String) session.getAttribute("errorMessage");
  if (errorMessage != null) {
    session.removeAttribute("errorMessage");
%>
<div role="alert" class="alert alert-error w-auto px-4 absolute bottom-10 right-5">
  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 shrink-0 stroke-current" fill="none" viewBox="0 0 24 24">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
  </svg>
  <span class="text-semibold text-md"><%= errorMessage%></span>
</div>
<% } %>
<%
  String email = request.getParameter("email");
  if (email != null && !email.isEmpty()) {
    editingAccount = AccountDB.getAccountByEmail(email);
  }
%>
<%@ include file="../components/sidebar.jsp"%>
<dialog id="add_user" class="modal">
  <div class="modal-box" style="width: 300px">
    <h3 class="text-lg font-bold flex justify-center">Adding New User</h3>
    <div class="flex justify-center">
      <form method="post" action="${pageContext.request.contextPath}/UserServlet" onsubmit="return validateAddUser()">
        <fieldset class="fieldset">
          <legend class="fieldset-legend">Username</legend>
          <input type="text" class="input" name="name" id="addName" placeholder="Type here" />
          <p class="fieldset-label">Compulsory</p>
          <span class="text-red-500" id="addNameError"></span>
        </fieldset>

        <fieldset class="fieldset mt-2">
          <legend class="fieldset-legend">Email</legend>
          <input type="text" class="input" name="email" id="addEmail" placeholder="Type here" />
          <p class="fieldset-label">Compulsory</p>
          <span class="text-red-500" id="addEmailError"></span>
        </fieldset>

        <fieldset class="fieldset mt-2">
          <legend class="fieldset-legend">Password</legend>
          <input type="password" class="input" name="password" id="addPassword" placeholder="Type here" />
          <p class="fieldset-label">Compulsory</p>
          <span class="text-red-500" id="addPasswordError"></span>
        </fieldset>

        <input type="hidden" name="action" value="add"/>
        <button type="submit" class="btn btn-outline btn-success w-full mt-4">Add User</button>
      </form>
    </div>
  </div>
  <form method="dialog" class="modal-backdrop">
    <button>close</button>
  </form>
</dialog>
<dialog id="edit_user" class="modal">
  <div class="modal-box" style="width: 300px">
    <h3 class="text-lg font-bold flex justify-center">Editing User</h3>
    <div class="flex justify-center">
      <form method="post" action="${pageContext.request.contextPath}/UserServlet" onsubmit="return validateEditUser()">
        <fieldset class="fieldset">
          <legend class="fieldset-legend">Username</legend>
          <input type="text" class="input" name="name" id="editName" placeholder="Type here" value="<%=editingAccount.getUsername()%>"/>
          <p class="fieldset-label">Compulsory</p>
          <span class="text-red-500" id="editNameError"></span>
        </fieldset>

        <fieldset class="fieldset mt-2">
          <legend class="fieldset-legend">Email</legend>
          <input type="text" class="input" name="email" id="editEmail" placeholder="Type here" value="<%=editingAccount.getEmail()%>"/>
          <p class="fieldset-label">Compulsory</p>
          <span class="text-red-500" id="editEmailError"></span>
        </fieldset>

        <fieldset class="fieldset mt-2">
          <legend class="fieldset-legend">Password</legend>
          <input type="text" class="input" name="password" id="editPassword" placeholder="Type here" value="<%=editingAccount.getPassword()%>"/>
          <p class="fieldset-label">Compulsory</p>
          <span class="text-red-500" id="editPasswordError"></span>
        </fieldset>

        <input type="hidden" name="id" value="<%=editingAccount.getId()%>"/>
        <input type="hidden" name="action" value="update"/>
        <button type="submit" class="btn btn-outline btn-success w-full mt-4">Update User</button>
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
          <th></th>
          <th>Username</th>
          <th>Email</th>
          <th>Joined On</th>
          <th>Role</th>
          <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
          for (Account account : accountList) {
        %>
        <tr>
          <td></td>
          <td>
            <%=account.getUsername()%>
          </td>
          <td>
            <%=account.getEmail()%>
          </td>
          <td>
            <%@ page import="java.text.SimpleDateFormat" %>
            <%@ page import="java.util.Date" %>
            <%
              String createdAtStr = account.getCreatedAt();
              SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
              SimpleDateFormat newFormat = new SimpleDateFormat("EEEE, MMMM dd, yyyy hh:mm a");

              Date createdAt = originalFormat.parse(createdAtStr);
              String formattedDate = newFormat.format(createdAt);
            %>
            <%= formattedDate %>
          </td>
          <td>
            <%
              String role = account.getRole();
              if (role != null && !role.isEmpty()) {
                role = role.substring(0, 1).toUpperCase() + role.substring(1).toLowerCase();
              }
            %>
            <%= role %>
          </td>
          <td>
            <div class="flex gap-4">
              <div>
                <a href="<%= request.getRequestURL().toString() %>?email=<%= account.getEmail() %>" type="button">
                  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-pencil"><path d="M21.174 6.812a1 1 0 0 0-3.986-3.987L3.842 16.174a2 2 0 0 0-.5.83l-1.321 4.352a.5.5 0 0 0 .623.622l4.353-1.32a2 2 0 0 0 .83-.497z"/><path d="m15 5 4 4"/></svg>
                </a>
              </div>
              <form method="post" action="${pageContext.request.contextPath}/UserServlet">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="email" value="<%= account.getEmail() %>"/>
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
            <a onclick="add_user.showModal()" class="flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-plus mr-2"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
              Add new user
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
    <% if (editingAccount != null && editingAccount.getId() != 0) { %>
    edit_user.showModal();
    <% } %>
  });

  function validateAddUser() {
    let isValid = true;

    let name = document.getElementById("addName").value.trim();
    let email = document.getElementById("addEmail").value.trim();
    let password = document.getElementById("addPassword").value.trim();

    document.getElementById("addNameError").textContent = "";
    document.getElementById("addEmailError").textContent = "";
    document.getElementById("addPasswordError").textContent = "";

    if (name === "") {
      document.getElementById("addNameError").textContent = "Username is required.";
      isValid = false;
    } else if (name.length < 3) {
      document.getElementById("addNameError").textContent = "Username must be at least 3 characters.";
      isValid = false;
    }

    let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (email === "") {
      document.getElementById("addEmailError").textContent = "Email is required.";
      isValid = false;
    } else if (!emailPattern.test(email)) {
      document.getElementById("addEmailError").textContent = "Invalid email format.";
      isValid = false;
    }

    if (password === "") {
      document.getElementById("addPasswordError").textContent = "Password is required.";
      isValid = false;
    }

    return isValid;
  }


  function validateEditUser() {
    let isValid = true;

    let name = document.getElementById("editName").value.trim();
    let email = document.getElementById("editEmail").value.trim();
    let password = document.getElementById("editPassword").value.trim();

    document.getElementById("editNameError").textContent = "";
    document.getElementById("editEmailError").textContent = "";
    document.getElementById("editPasswordError").textContent = "";

    if (name === "") {
      document.getElementById("editNameError").textContent = "Username is required.";
      isValid = false;
    } else if (name.length < 3) {
      document.getElementById("editNameError").textContent = "Username must be at least 3 characters.";
      isValid = false;
    }

    let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (email === "") {
      document.getElementById("editEmailError").textContent = "Email is required.";
      isValid = false;
    } else if (!emailPattern.test(email)) {
      document.getElementById("editEmailError").textContent = "Invalid email format.";
      isValid = false;
    }

    if (password === "") {
      document.getElementById("editPasswordError").textContent = "Password is required.";
      isValid = false;
    }

    return isValid;
  }
</script>
</body>
</html>
