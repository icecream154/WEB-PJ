<%
    if(request.getSession().getAttribute("loginUsername") != null){
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
%>
<%@ include file="../../templates/head.jsp"%>
<title>Login</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/login.css">
<%@ include file="../../templates/nav.jsp"%>
<div class="container form">
    <div class="row form_line">
        <div class="col-md-3">username &nbsp/&nbsp email:</div>
        <div class="col-md-9">
            <input class="form_input" id="usernameOrEmail" type="text" name="usernameOrEmail"/>
        </div>
    </div>
    <div class="row form_line">
        <div class="col-md-3">password:</div>
        <div class="col-md-9">
            <input class="form_input" id="password" type="password" name="password"/>
        </div>
    </div>
    <div class="row form_line">
        <div class="col-md-3">verification code:</div>
        <div class="col-md-6">
            <input class="form_input" type="text" id="verificationCode"/>
        </div>
        <div class="col-md-3"><canvas id="verification_code_canvas"></canvas></div>
    </div>
    <div class="row form_line last_form_line">
        <div id="register_hint" class="col-md-9">No account yet?&nbsp&nbsp<a href="<%=request.getContextPath()%>/pages/account/register.jsp">register one</a></div>
        <div class="col-md-3">
            <button id="log_in_button" onclick="login()">log in</button>
        </div>
    </div>
</div>
<%@ include file="../../templates/end.jsp"%>
<script>
    var verification_code;
    createCode();

    var usernameOrEmail = $("#usernameOrEmail");
    var password = $("#password");
    function checkForm() {
        if(usernameOrEmail.val() === null || usernameOrEmail.val() === ""){
            toastr.warning("Please input username or email");
            return false;
        }
        if(password.val() === null || password.val() === ""){
            toastr.warning("Please input password");
            return false;
        }
        if(!verificationCodeConfirm()){
            toastr.warning("Incorrect verification code");
            return false;
        }
        return true;
    }

    $(document).keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        console.log(keycode);
        if(keycode == '13'){
            login();
        }
    });

    console.log("<%= request.getParameter("href")%>");
    function login() {
        if(checkForm()){
            $.ajax({
                url: '<%=request.getContextPath()%>/login',
                type: 'POST',
                dataType: 'json',
                data: {
                    usernameOrEmail: usernameOrEmail.val(),
                    password: password.val()
                },
                success: function(data){
                    toastr.success(data.message);
                    setTimeout(function () {
                        var href = "<%= request.getParameter("href")%>";
                        if(href === ""){
                            href = "index.jsp";
                        }
                        window.location.href = href;
                    }, 1000);
                },
                error: function(error){
                    console.log(error);
                    toastr.error(JSON.parse(error.responseText).message);
                    password.val("");
                    $("#verificationCode").val("");
                    createCode();
                }
            })
        }
    }

    function verificationCodeConfirm() {
        if($("#verificationCode").val() === verification_code){
            return true;
        }else{
            return false;
        }
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