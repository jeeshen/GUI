<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<%@ include file="components/header.jsp" %>
<body class="bg-white font-inter pb-150">
<%
    // 使用 JSP 检查当前显示的是登录还是注册页面
    String currentTab = request.getParameter("tab");
    if (currentTab == null) {
        currentTab = "signin"; // 默认显示登录页面
    }

    // 检查表单提交
    String formAction = request.getParameter("formAction");
    if (formAction != null) {
        if ("signin".equals(formAction)) {
            // 在这里处理登录逻辑
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String remember = request.getParameter("remember");

            // 这里添加你的验证和登录处理代码
            // 例如：
            /*
            if (email != null && password != null) {
                // 验证用户
                boolean isValid = validateUser(email, password);
                if (isValid) {
                    // 创建会话
                    session.setAttribute("user", email);
                    // 重定向到主页或控制面板
                    response.sendRedirect("dashboard.jsp");
                    return;
                } else {
                    // 设置错误消息
                    request.setAttribute("errorMessage", "Invalid email or password");
                }
            }
            */

        } else if ("register".equals(formAction)) {
            // 在这里处理注册逻辑
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            // 这里添加你的验证和注册处理代码
            // 例如：
            /*
            if (email != null && username != null && password != null && confirmPassword != null) {
                if (!password.equals(confirmPassword)) {
                    request.setAttribute("errorMessage", "Passwords do not match");
                } else {
                    // 注册用户
                    boolean isRegistered = registerUser(email, username, password);
                    if (isRegistered) {
                        // 注册成功，重定向到登录页面
                        response.sendRedirect("account.jsp?tab=signin&registered=true");
                        return;
                    } else {
                        request.setAttribute("errorMessage", "Registration failed. Please try again.");
                    }
                }
            }
            */
        }
    }

    // 检查是否刚刚注册成功
    String registered = request.getParameter("registered");
    boolean justRegistered = "true".equals(registered);
%>

<div class="mt-30 flex justify-center p-4">
    <div class="w-full max-w-md mt-4">
        <h1 class="text-4xl font-bold text-center mb-8">ACCOUNT</h1>

        <!-- 标签 -->
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

        <!-- 登录内容 -->
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
                    <input type="text" name="email" placeholder="Email"
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

                <div class="flex items-center mb-6">
                    <input type="checkbox" name="remember" id="remember" class="mr-2">
                    <label for="remember">Remember me (optional)</label>
                </div>

                <button type="submit" class="w-full bg-black text-white py-4 font-bold uppercase tracking-wider">SIGN IN</button>
            </form>
        </div>

        <!-- 注册内容 -->
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

<%-- 可以创建一个单独的 JSP 文件来处理业务逻辑，如下 --%>
<%!
    // 在这里可以定义方法
    /*
    private boolean validateUser(String email, String password) {
        // 实现验证逻辑
        return true; // 示例
    }

    private boolean registerUser(String email, String username, String password) {
        // 实现注册逻辑
        return true; // 示例
    }
    */
%>
</body>
</html>