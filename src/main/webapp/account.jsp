<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <%@ include file="components/header.jsp" %>
    <body class="bg-white font-inter pb-150">
    <div class="mt-30 flex justify-center p-4">
        <div class="w-full max-w-md mt-4">
            <h1 class="text-4xl font-bold text-center mb-8">ACCOUNT</h1>

            <!-- Tabs -->
            <div class="flex border-b border-gray-200 mb-8">
                <button id="signin-tab" class="flex-1 py-3 font-bold text-center border-b-2 border-black">SIGN IN</button>
                <button id="register-tab" class="flex-1 py-3 font-bold text-center">REGISTER</button>
            </div>

            <!-- Sign In Content -->
            <div id="signin-content" class="block">
                <div class="text-center mb-6">
                    <p class="font-bold">WELCOME BACK.</p>
                    <p>Sign in with your email and password.</p>
                </div>

                <form>
                    <div class="float-label-input mb-6">
                        <input type="email" id="email" placeholder="Email">
                        <label for="email">Email</label>
                    </div>

                    <div class="float-label-input mb-6">
                        <input type="password" id="password" placeholder="Password">
                        <label for="password">Password</label>
                    </div>

                    <div class="mb-4">
                        <a href="#" class="text-black hover:underline">Forgot password? ›</a>
                    </div>

                    <div class="flex items-center mb-6">
                        <input type="checkbox" id="remember" class="mr-2">
                        <label for="remember">Remember me (optional)</label>
                    </div>

                    <button type="submit" class="w-full bg-black text-white py-4 font-bold uppercase tracking-wider">SIGN IN</button>
                </form>
            </div>

            <!-- Register Content -->
            <div id="register-content" class="hidden">
                <div class="mb-6">
                    <p>Create an account and benefit from a more personal shopping experience, and quicker online checkout.</p>
                </div>

                <div class="mb-6 text-gray-600 text-sm">
                    <p>By proceeding, you consent to receive an SMS for the purpose of verification and to continue with the account creation process.</p>
                </div>

                <form>
                    <div class="mb-2">
                        <label class="text-sm">Location code</label>
                    </div>

                    <div class="flex mb-6">
                        <select class="w-1/3 mr-2 py-2 border-b border-gray-300 focus:outline-none focus:border-black">
                            <option>+60 (MY)</option>
                            <option>+1 (US)</option>
                            <option>+44 (UK)</option>
                        </select>
                        <input type="tel" placeholder="Telephone" class="flex-1 py-2 border-b border-gray-300 focus:outline-none focus:border-black">
                    </div>

                    <button type="submit" class="w-full bg-black text-white py-4 font-bold uppercase tracking-wider">SEND VERIFICATION CODE</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        const signinTab = document.getElementById('signin-tab');
        const registerTab = document.getElementById('register-tab');
        const signinContent = document.getElementById('signin-content');
        const registerContent = document.getElementById('register-content');

        signinTab.addEventListener('click', function() {
            signinTab.classList.add('border-black');
            registerTab.classList.remove('border-black');
            signinContent.classList.remove('hidden');
            signinContent.classList.add('block');
            registerContent.classList.add('hidden');
            registerContent.classList.remove('block');
        });

        registerTab.addEventListener('click', function() {
            registerTab.classList.add('border-black');
            signinTab.classList.remove('border-black');
            registerContent.classList.remove('hidden');
            registerContent.classList.add('block');
            signinContent.classList.add('hidden');
            signinContent.classList.remove('block');
        });
    </script>
    </body>
    <style>
        /* 浮动 placeholder 效果 */
        .float-label-input {
            position: relative;
        }

        .float-label-input input {
            width: 100%;
            height: 40px;
            padding-top: 20px;
            border: none;
            border-bottom: 1px solid #d1d5db;
            outline: none;
        }

        .float-label-input label {
            position: absolute;
            top: 10px;
            left: 0;
            font-size: 16px;
            color: #6b7280;
            transition: all 0.3s ease;
            pointer-events: none;
        }

        .float-label-input input:focus {
            border-bottom-color: #000;
        }

        .float-label-input input:focus + label,
        .float-label-input input:not(:placeholder-shown) + label {
            top: 0px;
            font-size: 12px;
            color: #000;
        }

        .float-label-input input::placeholder {
            opacity: 0;
        }
    </style>