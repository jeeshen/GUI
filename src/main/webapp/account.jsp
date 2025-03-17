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

                <div class="float-label-input mb-6 relative">
                    <input type="password" id="password" placeholder="Password" class="w-full">
                    <label for="password">Password</label>
                    <button type="button" id="togglePassword" class="absolute right-2 top-1/2 transform -translate-y-1/2 hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                            <circle cx="12" cy="12" r="3"></circle>
                        </svg>
                    </button>
                </div>

                <div class="mb-4">
                    <a href="#" class="text-black group inline-flex items-center">
                        <span>Forgot password?</span>
                        <span class="transition-transform duration-200 ease-in-out transform group-hover:translate-x-1 ml-1">›</span>
                    </a>
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
                <div class="float-label-input mb-6">
                    <input type="text" id="register-email" placeholder="Email">
                    <label for="email">Email</label>
                </div>

                <div class="float-label-input mb-6">
                    <input type="text" id="username" placeholder="Username">
                    <label for="username">Username</label>
                </div>

                <div class="float-label-input mb-6">
                    <input type="password" id="register-password" placeholder="Password">
                    <label for="register-password">Password</label>
                    <button type="button" id="toggleRegisterPassword" class="absolute right-2 top-1/2 transform -translate-y-1/2 hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                            <circle cx="12" cy="12" r="3"></circle>
                        </svg>
                    </button>
                </div>

                <div class="float-label-input mb-6">
                    <input type="password" id="register-password-confirm" placeholder="<PASSWORD>">
                    <label for="register-password-confirm">Confirm Password</label>
                    <button type="button" id="toggleRegisterPasswordConfirm" class="absolute right-2 top-1/2 transform -translate-y-1/2 hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                            <circle cx="12" cy="12" r="3"></circle>
                        </svg>
                    </button>
                </div>

                <button type="submit" class="w-full bg-black text-white py-4 font-bold uppercase tracking-wider">Register</button>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Tab switching logic
        const signinTab = document.getElementById('signin-tab');
        const registerTab = document.getElementById('register-tab');
        const signinContent = document.getElementById('signin-content');
        const registerContent = document.getElementById('register-content');

        if (signinTab && registerTab && signinContent && registerContent) {
            signinTab.addEventListener('click', function() {
                // Add border to signin tab, remove from register tab
                signinTab.classList.add('border-b-2', 'border-black');
                registerTab.classList.remove('border-b-2', 'border-black');

                // Show signin content, hide register content
                signinContent.classList.remove('hidden');
                signinContent.classList.add('block');
                registerContent.classList.add('hidden');
                registerContent.classList.remove('block');
            });

            registerTab.addEventListener('click', function() {
                // Add border to register tab, remove from signin tab
                registerTab.classList.add('border-b-2', 'border-black');
                signinTab.classList.remove('border-b-2', 'border-black');

                // Show register content, hide signin content
                registerContent.classList.remove('hidden');
                registerContent.classList.add('block');
                signinContent.classList.add('hidden');
                signinContent.classList.remove('block');
            });
        }

        // 使用通用函数设置密码切换功能
        setupPasswordToggle('password', 'togglePassword');
        setupPasswordToggle('register-password', 'toggleRegisterPassword');
        setupPasswordToggle('register-password-confirm', 'toggleRegisterPasswordConfirm');
    });

    function setupPasswordToggle(inputId, buttonId) {
        const input = document.getElementById(inputId);
        const button = document.getElementById(buttonId);

        if (input && button) {
            // 初始状态设置 - 如果输入框已有值，显示切换按钮
            if (input.value && input.value.length > 0) {
                button.classList.remove('hidden');
            } else {
                button.classList.add('hidden');
            }

            // 输入监听事件
            input.addEventListener('input', function() {
                if (this.value.length > 0) {
                    button.classList.remove('hidden');
                } else {
                    button.classList.add('hidden');
                }
            });

            // 切换按钮点击事件
            button.addEventListener('click', function() {
                if (input.type === 'password') {
                    input.type = 'text';
                    this.innerHTML = `
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                        <circle cx="12" cy="12" r="3"></circle>
                        <line x1="1" y1="1" x2="23" y2="23"></line>
                    </svg>
                `;
                } else {
                    input.type = 'password';
                    this.innerHTML = `
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                        <circle cx="12" cy="12" r="3"></circle>
                    </svg>
                `;
                }
            });
        }
    }
</script>
</body>
<style>
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
</html>