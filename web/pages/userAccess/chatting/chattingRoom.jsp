<%
    if(request.getSession().getAttribute("loginUsername") != null){
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
%>
<%@ include file="../../../templates/head.jsp"%>
<title>Chatting...</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/chattingRoom.css">
<%@ include file="../../../templates/nav.jsp"%>
<div class="container" style="width: 100%; margin-bottom: 50px;">
    <div class="row">
        <div class="col-md-12">
            <span style="font-size: 36px;">${requestScope.room.user1} and ${requestScope.room.user2}'s chatting room ... </span>
        </div>
    </div>
    <div class="row" style="margin-bottom: 50px;">
        <div class="col-md-12">
            <textarea id="history_messages" style="width: 100%; height: 800px; font-size: 20px;"></textarea>
        </div>
    </div>
    <div class="row">
        <div class="col-md-11">
            <input type="text" id="message_send_input" style="width: 100%; font-size: 20px;">
        </div>
        <div class="col-md-1">
            <button type="button" id="message_send_button" style="width: 100%;">send</button>
        </div>
    </div>
</div>

<%@ include file="../../../templates/end.jsp"%>

<script>
    var history_messages = $("#history_messages");
    function down() {
        history_messages.scrollTop = history_messages.scrollHeight;
    }


    $("#message_send_button").click(function () {
        sendMessage();
    });

    var request_interval = setInterval(getRoomMessage, 1000);

    $(document).keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        console.log(keycode);
        if(keycode == '13'){
            sendMessage();
        }
    });

    function sendMessage() {
        $.ajax({
            url: '<%=request.getContextPath()%>/sendChattingMessage',
            type: 'POST',
            dataType: 'json',
            data: {
                user1: '${requestScope.room.user1}',
                user2: '${requestScope.room.user2}',
                message: $("#message_send_input").val()
            },
            success: function(data){
                console.log(data);
                $("#message_send_input").val("");
                toastr.success(data.message);
                clearInterval(request_interval);
                request_interval = setInterval(getRoomMessage, 1000);
            },
            error: function(error){
                console.log(error);
                toastr.error(JSON.parse(error.responseText).message);
            }
        })
    }

    function getRoomMessage() {
        $.ajax({
            url: '<%=request.getContextPath()%>/getRoomMessage',
            type: 'POST',
            dataType: 'text',
            data: {
                user1: '${requestScope.room.user1}',
                user2: '${requestScope.room.user2}',
            },
            success: function(data){
                console.log(data);
                $("#history_messages").val(data);
                down();
            },
            error: function(error){
                console.log(error);
                toastr.error(JSON.parse(error.responseText).message);
                clearInterval(request_interval);
            }
        })
    }

</script>