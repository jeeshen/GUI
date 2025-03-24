<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<%@ include file="components/header.jsp" %>
    <body class="bg-base-100">
        <div class="pt-30 pb-200 flex flex-col items-center justify-center px-4 text-center">
            <h1 class="text-5xl font-bold text-black">Order Failed!</h1>
            <div class="w-24 h-1 bg-black my-6 mx-auto"></div>
            <h2 class="text-2xl font-semibold mb-4">Please try again!</h2>
            <p class="text-lg text-gray-600 mb-6">
                <%=request.getParameter("error")+"!"+"<br/>"%>
                Your order has been cancelled. Please order them again!
            </p>

            <div class="space-x-4 mt-8">
                <a href="index.jsp">
                    <button class="btn btn-neutral">Go Home</button>
                </a>
            </div>
        </div>
    </body>
</html>
