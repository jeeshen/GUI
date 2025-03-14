<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <%@ include file="header.jsp" %>
    <body>
        <p class="w-1/2 text-black-500 font-inter text-5xl font-bold pl-30">Jevore. <span class="text-gray-500">Best place to buy the <br/>products you love.</span></p>
        <p class="w-1/2 text-black-500 font-inter text-2xl font-bold pl-30 mt-30 mb-5">Promotions. <span class="text-gray-500">Get goods for better prices.</span></p>
        <div class="flex justify-left gap-8 mx-30">
            <% for (int i = 0; i < 4; i++) { %>
                <div class="relative shadow-2xl w-100 h-130 rounded-[1rem]">
                    <div class="text-white absolute top-10 left-10">
                        <p class="text-3xl font-semibold">jPhone 16 Pro</p>
                        <p class="text-xl">From RM 3,000</p>
                    </div>
                    <img class="object-fill w-full h-full rounded-[1rem]" src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/store-card-40-iphone-16-pro-202409?wid=800&hei=1000&fmt=jpeg&qlt=95&.v=1726165763242" alt="promotion">
                </div>
            <% } %>
        </div>
        <p class="w-1/2 text-black-500 font-inter text-2xl font-bold pl-30 mt-30 mb-5">Top Product. <span class="text-gray-500">Product loved by majority.</span></p>
        <div class="flex justify-left gap-8 mx-30 mb-50">
            <% for (int i = 0; i < 5; i++) { %>
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
            <% } %>
        </div>
    </body>
</html>