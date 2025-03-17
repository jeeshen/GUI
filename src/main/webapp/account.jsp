<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="database.AccountDB" %>
<!DOCTYPE html>
<html>
<%@ include file="components/header.jsp" %>
<body class="bg-white font-inter pb-150">
<%
    // Get or create the session explicitly
    HttpSession userSession = request.getSession();

    String currentTab = request.getParameter("tab");
    if (currentTab == null) {
        currentTab = "signin";
    }

    String formAction = request.getParameter("formAction");
    if (formAction != null) {
        if ("signin".equals(formAction)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String remember = request.getParameter("remember");

            if (email != null && password != null) {
                // Validate user
                boolean isValid = AccountDB.validateUser(email, password);
                if (isValid) {
                    // Create session
                    userSession.setAttribute("user", email);
                    // Get user role
                    String userRole = AccountDB.getUserRole(email);
                    userSession.setAttribute("userRole", userRole);

                    // Handle remember me functionality using session
                    if (remember != null && remember.equals("on")) {
                        // Set session timeout to 30 days (in seconds)
                        userSession.setMaxInactiveInterval(30 * 24 * 60 * 60);
                        userSession.setAttribute("rememberMe", "true");
                    } else {
                        // Default session timeout (e.g., 30 minutes)
                        userSession.setMaxInactiveInterval(30 * 60);
                        userSession.setAttribute("rememberMe", "false");
                    }

                    // Redirect to dashboard
                    response.sendRedirect("dashboard.jsp");
                    return;
                } else {
                    // Set error message
                    request.setAttribute("errorMessage", "Invalid email or password");
                }
            }
        } else if ("register".equals(formAction)) {
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            if (email != null && username != null && password != null && confirmPassword != null) {
                if (!password.equals(confirmPassword)) {
                    request.setAttribute("errorMessage", "Passwords do not match");
                } else {
                    // Register user
                    boolean isRegistered = AccountDB.registerUser(email, username, password);
                    if (isRegistered) {
                        // Registration successful, redirect to login page
                        response.sendRedirect("account.jsp?tab=signin&registered=true");
                        return;
                    } else {
                        request.setAttribute("errorMessage", "Registration failed. Please try again.");
                    }
                }
            }
        }
    }

    String registered = request.getParameter("registered");
    boolean justRegistered = "true".equals(registered);

    // Check if user has a remembered session
    String rememberedEmail = "";
    boolean isRemembered = false;

    // Check if user is already logged in with remember me enabled
    if (userSession.getAttribute("user") != null && "true".equals(userSession.getAttribute("rememberMe"))) {
        rememberedEmail = (String) userSession.getAttribute("user");
        isRemembered = true;

        // Auto redirect to dashboard if they're already logged in with remember me
        // Uncomment the following lines if you want auto-redirect behavior
        // response.sendRedirect("dashboard.jsp");
        // return;
    }
%>

<div class="mt-30 flex justify-center p-4">
    <div class="w-full max-w-md mt-4">
        <h1 class="text-4xl font-bold text-center mb-8">ACCOUNT</h1>

        <div class="flex border-b border-gray-200 mb-8">
            <a href="?tab=signin" class="flex-1 py-3 font-bold text-center <%= "signin".equals(currentTab) ? "border-b-2 border-black" : "" %>">SIGN IN</a>
            <a href="?tab=register" class="flex-1 py-3 font-bold text-center <%= "register".equals(currentTab) ? "border-b-2 border-black" : "" %>">REGISTER</a>
        </div>

        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>

        <% if (justRegistered) { %>
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
            Registration successful! Please sign in with your new account.
        </div>
        <% } %>

        <div id="signin-content" class="<%= "signin".equals(currentTab) ? "block" : "hidden" %>">
            <div class="text-center mb-6">
                <p class="font-bold">WELCOME BACK.</p>
                <p>Sign in with your email and password.</p>
            </div>

            <form action="<%= request.getRequestURI() %>" method="post">
                <input type="hidden" name="formAction" value="signin">
                <input type="hidden" name="tab" value="signin">

                <label class="floating-label block w-[448px] mb-6">
                    <span>Email</span>
                    <input type="text" name="email" placeholder="Email" value="<%= rememberedEmail %>"
                           class="cursor-text appearance-none bg-white align-middle whitespace-nowrap w-[448px] h-[40px] border border-gray-300 shadow-[inset_0_1px_rgba(0,0,0,0.1),inset_0_-1px_rgba(255,255,255,0.1)] rounded-md flex-shrink px-3 text-sm inline-flex items-center gap-2 relative" />
                </label>

                <label class="floating-label block w-[448px] mb-6">
                    <span>Password</span>
                    <input type="password" name="password" placeholder="Password"
                           class="cursor-text appearance-none bg-white align-middle whitespace-nowrap w-[448px] h-[40px] border border-gray-300 shadow-[inset_0_1px_rgba(0,0,0,0.1),inset_0_-1px_rgba(255,255,255,0.1)] rounded-md flex-shrink px-3 text-sm inline-flex items-center gap-2 relative" />
                </label>

                <div class="mb-4">
                    <a href="forgotpassword.jsp" class="text-black group inline-flex items-center">
                        <span>Forgot password?</span>
                        <span class="ml-1">›</span>
                    </a>
                </div>

                <!-- Enhanced Remember Me Section with border and description -->
                <div class="mb-6 border border-gray-200 rounded-md p-4">
                    <div class="flex items-center mb-2">
                        <input type="checkbox" name="remember" id="remember" class="mr-2" <%= isRemembered ? "checked" : "" %>>
                        <label for="remember" class="font-bold">Remember Me</label>
                    </div>
                    <div class="text-sm text-gray-600">
                        <p>Stay signed in on this device. Your session will remain active for 30 days. For security reasons, use this option only on your personal devices.</p>
                    </div>
                </div>

                <button type="submit" class="w-full bg-black text-white py-4 font-bold uppercase tracking-wider">SIGN IN</button>
            </form>
        </div>

        <div id="register-content" class="<%= "register".equals(currentTab) ? "block" : "hidden" %>">
            <div class="mb-6">
                <p>Create an account and benefit from a more personal shopping experience, and quicker online checkout.</p>
            </div>

            <div class="mb-6 text-gray-600 text-sm">
                <p>By proceeding, you consent to receive an SMS for the purpose of verification and to continue with the account creation process.</p>
            </div>

            <form action="<%= request.getRequestURI() %>" method="post">
                <input type="hidden" name="formAction" value="register">
                <input type="hidden" name="tab" value="register">

                <label class="floating-label block w-[448px] mb-6">
                    <span>Email</span>
                    <input type="text" name="email" placeholder="Email"
                           class="cursor-text appearance-none bg-white align-middle whitespace-nowrap w-[448px] h-[40px] border border-gray-300 shadow-[inset_0_1px_rgba(0,0,0,0.1),inset_0_-1px_rgba(255,255,255,0.1)] rounded-md flex-shrink px-3 text-sm inline-flex items-center gap-2 relative" />
                </label>

                <label class="floating-label block w-[448px] mb-6">
                    <span>Username</span>
                    <input type="text" name="username" placeholder="Username"
                           class="cursor-text appearance-none bg-white align-middle whitespace-nowrap w-[448px] h-[40px] border border-gray-300 shadow-[inset_0_1px_rgba(0,0,0,0.1),inset_0_-1px_rgba(255,255,255,0.1)] rounded-md flex-shrink px-3 text-sm inline-flex items-center gap-2 relative" />
                </label>

                <label class="floating-label block w-[448px] mb-6">
                    <span>Password</span>
                    <input type="password" name="password" placeholder="Password"
                           class="cursor-text appearance-none bg-white align-middle whitespace-nowrap w-[448px] h-[40px] border border-gray-300 shadow-[inset_0_1px_rgba(0,0,0,0.1),inset_0_-1px_rgba(255,255,255,0.1)] rounded-md flex-shrink px-3 text-sm inline-flex items-center gap-2 relative" />
                </label>

                <label class="floating-label block w-[448px] mb-6">
                    <span>Confirm Password</span>
                    <input type="password" name="confirmPassword" placeholder="Confirm Password"
                           class="cursor-text appearance-none bg-white align-middle whitespace-nowrap w-[448px] h-[40px] border border-gray-300 shadow-[inset_0_1px_rgba(0,0,0,0.1),inset_0_-1px_rgba(255,255,255,0.1)] rounded-md flex-shrink px-3 text-sm inline-flex items-center gap-2 relative" />
                </label>

                <button type="submit" class="w-full bg-black text-white py-4 font-bold uppercase tracking-wider">REGISTER</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>