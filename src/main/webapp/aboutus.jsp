<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <%@ include file="components/header.jsp" %>
    <body class="bg-base-100 pb-20 font-inter">
        <p class="w-full text-black-500 text-7xl font-bold pl-100">ABOUT US</p>
        <div class="flex justify-center mx-30 my-10">
            <div class="w-[70%] h-auto aspect-video">
                <iframe
                        class="w-full h-full rounded-lg"
                        src="https://www.youtube.com/embed/jOTfBlKSQYY?autoplay=1&mute=1&loop=1"
                        frameborder="0"
                        allow="autoplay; encrypted-media"
                        allowfullscreen
                ></iframe>
            </div>
        </div>
        <div class="flex justify-center">
            <div class="w-[70%] h-auto m-auto">
                <p class="mt-20 text-black-400 text-5xl"><span class="text-gray-500">Our mission</span> is to connect people with the latest technology and innovation.</p>
                <p class="mt-20 text-black-400 text-5xl">We believe that everyone deserves access to<br>
                    <span class="text-gray-500">high-quality mobile devices, empowering them to stay connected, express themselves</span>, and <span class="text-gray-500">explore endless possibilities</span>.
                <p class="mt-20 text-black-400 text-5xl">Through exceptional service and trusted expertise, we bring the world closer—one phone at a time.</p>
                <div class="w-full flex justify-center mt-20">
                    <img src="images/phone.png" class="w-1/2 h-auto">
                </div>
            </div>
        </div>
    </body>
</html>