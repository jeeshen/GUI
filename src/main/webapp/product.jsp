<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <%@ include file="components/header.jsp" %>
    <body class="bg-base-100 pb-20">
        <p class="w-1/2 text-black-500 font-inter text-5xl font-bold pl-30">Shop Jevore</p>
        <p class="mt-20 mb-5 w-1/2 text-black-500 font-inter text-3xl font-bold pl-30">All Models.<span class="text-gray-500">Take your pick.</span></p>
        <div class="flex justify-left gap-8 mx-30">
            <% for (int i = 0; i < 5; i++) { %>
            <div class="transition duration-300 ease-in-out hover:scale-103">
                <div class="card bg-base-100 w-80 h-110 shadow-2xl">
                    <figure class="h-200">
                        <img class="object-contain w-full h-full"
                             src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-card-40-iphone16prohero-202409?wid=680&hei=528&fmt=p-jpg&qlt=95&.v=1725567335931"
                             alt="topsold" />
                    </figure>
                    <div class="card-body">
                        <div class="ml-2">
                            <h2 class="card-title text-xl">JPhone <%= i + 1 %></h2>
                            <div class="card-actions mt-3 justify-evenly">
                                <p class="text-md my-auto">RM <%= String.format("%,d", new java.util.Random().nextInt(3001) + 1000) %>.00</p>
                                <button class="btn btn-neutral">ADD TO CART</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </body>
</html>