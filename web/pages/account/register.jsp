<%
    if(request.getSession().getAttribute("loginUsername") != null){
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
%>
<%@ include file="../../templates/head.jsp"%>
<title>Register</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/register.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/passwordStrengthCheck.css">
<%@ include file="../../templates/nav.jsp"%>
<div class="container form">
    <%--    username--%>
    <div class="row form_line">
        <div class="col-md-3">username:</div>
        <div class="col-md-9">
            <input class="form_input" type="text" id="r_username" onkeyup="r_isValidUsername()" onblur="r_isValidUsername()"/>
        </div>
    </div>
    <div class="row form_hint_line">
        <div class="col-md-3"></div>
        <div class="col-md-9">
            <span id="r_usernameHint">only characters and digits, length 4-15</span>
        </div>
    </div>
    <%--    email--%>
    <div class="row form_line">
        <div class="col-md-3">email:</div>
        <div class="col-md-9">
            <input class="form_input" type="text" id="r_email" onkeyup="r_isValidEmail()" onblur="r_isValidEmail()"/>
        </div>
    </div>
    <div class="row form_hint_line">
        <div class="col-md-3"></div>
        <div class="col-md-9">
            <span id="r_emailHint">input your email</span>
        </div>
    </div>
    <%--    pass--%>
    <div class="row form_line">
        <div class="col-md-3">password:</div>
        <div class="col-md-9">
            <input class="form_input" type="password" id="r_password" onblur="r_isValidPassword()" onkeyup="r_isValidPassword()"/>
        </div>
    </div>
    <div class="row form_hint_line">
        <div class="col-md-3"></div>
        <div class="col-md-9">
            <span id="r_passwordHint">length 6-12</span>
            <div id="r_password_strength">
                <div class="progress-bar_wrap">
                    <div class="progress-bar_item progress-bar_item-1"></div>
                    <div class="progress-bar_item progress-bar_item-2"></div>
                    <div class="progress-bar_item progress-bar_item-3"></div>
                </div>
                <span class="progress-bar_text"></span>
            </div>
        </div>
    </div>
    <%--    pass confirm--%>
    <div class="row form_line">
        <div class="col-md-3">password confirm:</div>
        <div class="col-md-9">
            <input class="form_input" type="password" id="r_passwordConfirm" onkeyup="r_isValidPassword()" onblur="r_passwordConfirm()"/>
        </div>
    </div>
    <div class="row form_hint_line">
        <div class="col-md-3"></div>
        <div class="col-md-9">
            <span id="r_passwordConfirmHint">input your password again</span>
        </div>
    </div>
    <%--    verification code--%>
    <div class="row form_line">
        <div class="col-md-3">verification code:</div>
        <div class="col-md-6">
            <input class="form_input" type="text" id="r_verificationCode" onkeyup="r_verificationCodeConfirm()" onblur="r_verificationCodeConfirm()"/>
        </div>
        <div class="col-md-3"><canvas id="verification_code_canvas"></canvas></div>
    </div>
    <div class="row form_hint_line">
        <div class="col-md-3"></div>
        <div class="col-md-9">
            <span id="r_verificationCodeHint">input verification code</span>
        </div>
    </div>
    <%--    register submit--%>
    <div class="row form_line last_form_line">
        <div class="col-md-12">
            <button id="register_button" onclick="register()">register</button>
        </div>
    </div>
</div>
<%@ include file="../../templates/end.jsp"%>

<script>
    var verification_code;
    createCode();
    $("#r_password_strength").hide();

    function r_isValidUsername() {
        var username_regex = /^[a-zA-Z0-9]{4,15}$/;
        var valid = username_regex.test($("#r_username").val());
        if(valid){
            $("#r_usernameHint").text("");
        }else{
            $("#r_usernameHint").text("only characters and digits, length 4-15");
        }
        return valid
    }
    function r_isValidEmail() {
        var email_regex = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
        var valid = email_regex.test($("#r_email").val());
        if(valid){
            $("#r_emailHint").text("");
        }else{
            $("#r_emailHint").text("email format error");
        }
        return valid
    }
    var changeText = function (el, text, color) {
        el.text(text).css('color', color);
    };
    function r_isValidPassword() {
        var password_regex = /^.{6,12}$/;
        var valid = password_regex.test($("#r_password").val());
        if(valid){
            $("#r_passwordHint").text("");
            $("#r_password_strength").show();
            var len = $("#r_password").val().length;
            if (len >=6  && len <= 7) {
                $('.progress-bar_item-1').addClass('active');
                $('.progress-bar_item-2').removeClass('active');
                $('.progress-bar_item-3').removeClass('active');
                $('.active').css('background-color', '#FF4B47');
                changeText($('.progress-bar_text'), 'Weak');
            } else if (len >= 8 && len <= 10) {
                $('.progress-bar_item-2').addClass('active');
                $('.progress-bar_item-3').removeClass('active');
                $('.active').css('background-color', '#F9AE35');
                changeText($('.progress-bar_text'), 'Medium');
            } else {
                $('.progress-bar_item').each(function() {
                    $(this).addClass('active');
                });
                $('.active').css('background-color', '#2DAF7D');
                changeText($('.progress-bar_text'), 'Strong');
            }

        }else{
            $("#r_password_strength").hide();
            $("#r_passwordHint").text("length 6-12");
        }
        return valid;
    }
    function r_passwordConfirm() {
        var r_password = $("#r_password").val();
        var r_passwordConfirm = $("#r_passwordConfirm").val();
        console.log("r_password: " + r_password + " r_passwordConfirm: " + r_passwordConfirm);
        if(r_password === r_passwordConfirm){
            $("#r_passwordConfirmHint").text("");
            return true;
        }else{
            $("#r_passwordConfirmHint").text("different password!");
            return false;
        }
    }
    function r_verificationCodeConfirm() {
        if($("#r_verificationCode").val() === verification_code){
            $("#r_verificationCodeHint").text("");
            return true;
        }else{
            $("#r_verificationCodeHint").text("verification code incorrect");
            return false;
        }
    }
    function register() {
        if(!r_isValidUsername() || !r_isValidEmail() || !r_isValidPassword() || !r_passwordConfirm() || !r_verificationCodeConfirm()){
            toastr.warning("Please check your form");
            return;
        }
        $.ajax({
            url: '<%=request.getContextPath()%>/register',
            type: 'POST',
            dataType: 'json',
            data: {
                username: $("#r_username").val(),
                email: $("#r_email").val(),
                password: $("#r_password").val()
            },
            success: function(data){
                console.log(data);
                toastr.success(data.message);
                setTimeout(function () {
                    window.location.href = "<%=request.getContextPath()%>/index.jsp";
                }, 1000);
            },
            error: function(error){
                console.log(error);
                toastr.error(JSON.parse(error.responseText).message);
                $("#r_verificationCode").val("");
                createCode();
            }
        })
    }

    function createCode() {
        verification_code = "";
        var codeLength = 4;
        var canvas = document.getElementById('verification_code_canvas');
        var selectChar = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

        for (var i = 0; i < codeLength; i++) {
            var charIndex = Math.floor(Math.random() * 10);
            verification_code += selectChar[charIndex];
        }
        if (canvas) {
            var ctx = canvas.getContext('2d');
            ctx.fillStyle='#FFFFFF';
            ctx.fillRect(0,0,canvas.width, canvas.height);
            ctx.font = "100px arial";
            // 创建渐变
            var gradient=ctx.createLinearGradient(0, 0, canvas.width, 0);
            gradient.addColorStop("0","magenta");
            gradient.addColorStop("0.5","blue");
            gradient.addColorStop("1.0","red");
            // 用渐变填色
            ctx.strokeStyle = gradient;
            ctx.strokeText(verification_code, 80, 80);//画布上添加验证码
        }
    }
</script>