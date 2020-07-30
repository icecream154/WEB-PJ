<%@ include file="../templates/head.jsp"%>
<title>${requestScope.user.username}'s Page</title>
<%@ include file="../templates/nav.jsp"%>


<div class="container" style="width: 80%; font-size: 24px;">
    <div class="row" style="margin-top: 40px; margin-bottom: 40px">
        <div class="col-md-12">
            <span style="font-size: 32px;"><span style="font-weight: bold">${requestScope.user.username}</span>'s page.</span><br><br>
        </div>
    </div>
    <div class="row"><div style="font-weight: bold" class="col-md-4">Username:</div><div class="col-md-8">${requestScope.user.username}</div></div>
    <div class="row"><div style="font-weight: bold" class="col-md-4">Email:</div><div class="col-md-8">${requestScope.user.email}</div></div>
    <div class="row"><div style="font-weight: bold" class="col-md-4">Friends:</div><div class="col-md-8">${requestScope.user.friendSize}</div></div>
    <div class="row"><div style="font-weight: bold" class="col-md-4">Pictures:</div><div class="col-md-8">${requestScope.user.pictureCount}</div></div>
    <div class="row"><div style="font-weight: bold" class="col-md-4">Collections:</div><div class="col-md-8">${requestScope.user.collectionSize}</div></div>

    <div class="row" style="margin-top: 40px;">
        <div class="col-md-12">
            <c:if test="${sessionScope.loginUsername != null}">
                <c:if test="${requestScope.isFriend}">
                    <a href="displayCollections?username=${requestScope.user.username}">view his/her collection</a><br>
                </c:if>
                <c:if test="${!requestScope.isFriend}">
                    <button class="btn btn-default" type="button" id="become_friends_button">become friends</button><br>
                </c:if>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="../templates/end.jsp"%>

<script>
    $("#become_friends_button").click(function () {
        send_invitation('${requestScope.user.username}');
    });

    function send_invitation(receiver) {
        $.ajax({
            url: '<%=request.getContextPath()%>/sendInvitation',
            type: 'GET',
            dataType: 'json',
            data: {
                receiver: receiver
            },
            success: function(data){
                toastr.success(data.message);
            },
            error: function(error){
                console.log(error);
                toastr.error(JSON.parse(error.responseText).message);
            }
        });
    }

</script>
