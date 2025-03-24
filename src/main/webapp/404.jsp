<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
  <%@ include file="components/header.jsp" %>
  <body class="bg-base-100">
    <div class="pt-30 pb-200 flex flex-col items-center justify-center px-4 text-center">
      <h1 class="text-9xl font-bold text-black">404</h1>
      <div class="w-24 h-1 bg-black my-8 mx-auto"></div>
      <h2 class="text-3xl font-semibold mb-4">Page Not Found</h2>
      <p class="text-lg text-gray-600 mb-8">
        The page you are looking for doesn't exist or has been moved.
      </p>
      <div class="space-x-4">
        <a href="index.jsp">
          <button class="btn btn-neutral">Go Home</button>
        </a>
      </div>
      <div class="mt-16">
        <p class="text-gray-500">
          If you need assistance, please contact our support team.
        </p>
      </div>
    </div>
  </body>
</html>