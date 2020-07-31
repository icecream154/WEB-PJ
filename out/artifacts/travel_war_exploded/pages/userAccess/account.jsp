<%
    if(request.getSession().getAttribute("loginUsername") == null){
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
%>
<%@ include file="../../templates/head.jsp"%>
<title>Account Page</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/account.css">
<%@ include file="../../templates/nav.jsp"%>

<div class="row">
    <div class="col-md-5">
        <div class="container" style="width: 100%; font-size: 24px;">
            <div class="row" style="margin-top: 40px; margin-bottom: 40px">
                <div class="col-md-12">
                    <span style="font-size: 32px;"><span style="font-weight: bold">${requestScope.user.username}</span>'s page.</span><br><br>
                </div>
            </div>
            <div class="row"><div style="font-weight: bold" class="col-md-4">Username:</div><div class="col-md-8">${requestScope.user.username}</div></div>
            <div class="row"><div style="font-weight: bold" class="col-md-4">Email:</div><div class="col-md-8">${requestScope.user.email}</div></div>
            <div class="row"><div style="font-weight: bold" class="col-md-4">Friends:</div><div class="col-md-8"><span id="friend_size_span">${requestScope.user.friendSize}</span></div></div>
            <div class="row"><div style="font-weight: bold" class="col-md-4">Pictures:</div><div class="col-md-8">${requestScope.user.pictureCount}</div></div>
            <div class="row"><div style="font-weight: bold" class="col-md-4">Collections:</div><div class="col-md-8">${requestScope.user.collectionSize}</div></div>

            <div class="row" style="margin-top: 40px;">
                <div class="col-md-12">
                    <span id="open_status_span">
                    </span>
                    <button id="open_switch">change open status</button>
                </div>
            </div>

        </div>
    </div>
    <div class="col-md-7">
        <div class="container" style="width: 100%; font-size: 24px;">
            <div class="row" style="margin-top: 55px; margin-bottom: 45px">
                <div class="col-md-4 button-col">
                    <button style="width: 95%;" id="my_friends_button">my friends</button>
                </div>
                <div class="col-md-4 button-col">
                    <button style="width: 95%;" id="check_received_invitations_button">check invitations</button>
                </div>
                <div class="col-md-4 button-col">
                    <button style="width: 95%;" id="search_other_users_button">search other users</button>
                </div>
            </div>

            <div class="row">
                <div id="friends_div">
                    <span class="hint-title">My friends</span><br><br>
                    <div class="col-md-12" id="friends_table"></div>
                </div>
                <div id="received_invitations_div">
                    <span class="hint-title">Received invitations</span><br><br>
                    <div class="col-md-12" id="received_invitations_table"></div>
                </div>
                <div id="search_other_users_div">
                    <span class="hint-title">Search user</span><br>
                    <input style="width: 70%; margin-left: 1.6%;" type="text" id="search_username">
                    <button style="width: 24%;" type="button" id="search_button">search</button><br><br>
                    <div class="col-md-12" id="search_results_table"></div>
                </div>
            </div>
        </div>
    </div>
</div>


<%@ include file="../../templates/end.jsp"%>
<script>
    var friend_size_span = $("#friend_size_span");

    var received_invitations_div = $("#received_invitations_div");
    var search_other_users_div = $("#search_other_users_div");
    var friends_div = $("#friends_div");

    var received_invitations_data;
    var received_invitations_table = $("#received_invitations_table");
    var friends_table = $("#friends_table");
    var search_results_table = $("#search_results_table");

    // display my friends at the very beginning
    my_friends_button_clicked();

    function dealInvitation(index, op) {
        $.ajax({
            url: 'dealInvitation',
            type: 'GET',
            dataType: 'json',
            data: {
                operation: op === 1 ? 'ACCEPT' : 'DENY',
                sender: received_invitations_data[index].sender
            },
            success: function(data){
                toastr.success(data.message);
                if(op === 1){
                    friend_size_span.text(parseInt(friend_size_span.text()) + 1);
                }
                check_received_invitations_button_clicked();
            },
            error: function(error){
                console.log(error);
                toastr.error(JSON.parse(error.responseText).message);
            }
        });
    }
    function createReceivedInvitationTable(invitations) {
        var container = '<div class="container" style="width: 100%">';
        // first line
        container += '<div class="row first-row">';
        container += '<div class="col-md-4">';
        container += '<span class="table_title">Sender</span>';
        container += '</div>';
        container += '<div class="col-md-4">';
        container += '<span class="table_title">Time</span>';
        container += '</div>';
        container += '<div class="col-md-2">';
        container += '</div>';
        container += '<div class="col-md-2">';
        container += '</div>';
        container += '</div>';

        for(var i in invitations){
            container += '<div class="row normal-row">';
            container += '<div class="col-md-4">';
            container += '<span class="table_content">' + invitations[i].sender + '</span>';
            container += '</div>';
            container += '<div class="col-md-4">';
            container += '<span class="table_content">' + invitations[i].time + '</span>';
            container += '</div>';
            container += '<div class="col-md-2">';
            container += '<button type="button" onclick="dealInvitation(' + i + ', 1)">accept</button>';
            container += '</div>';
            container += '<div class="col-md-2">';
            container += '<button type="button" onclick="dealInvitation(' + i + ', -1)">deny</button>';
            container += '</div>';
            container += '</div>';
        }

        container += '</div>';
        return container;
    }
    function check_received_invitations_button_clicked() {
        search_other_users_div.hide();
        friends_div.hide();
        received_invitations_div.show();
        received_invitations_table.html("Please waiting ... ");
        $.ajax({
            url: 'getReceivedInvitations',
            type: 'GET',
            dataType: 'json',
            data: {
                status: 'PENDING'
            },
            success: function(data){
                console.log(data);
                received_invitations_data = data;
                received_invitations_table.html(createReceivedInvitationTable(data));
            },
            error: function(error){
                console.log(error);
                toastr.error(JSON.parse(error.responseText).message);
            }
        });
    }

    function createFriendsTable(users){
        var container = '<div class="container" style="width: 100%">';
        // first line
        container += '<div class="row first-row">';
        container += '<div class="col-md-2">';
        container += '<span class="table_title">Username</span>';
        container += '</div>';
        container += '<div class="col-md-4">';
        container += '<span class="table_title">Email</span>';
        container += '</div>';
        container += '<div class="col-md-4">';
        container += '<span class="table_title">Register time</span>';
        container += '</div>';
        container += '<div class="col-md-2">';
        container += '<span class="table_title"></span>';
        container += '</div>';
        container += '</div>';

        for(var i in users){
            container += '<div class="row normal-row">';
            container += '<div class="col-md-2">';
            container += '<span class="table_content"><a href="displayCollections?currentIndex=1&username=' + users[i].username + '">' + users[i].username + '</a></span>';
            container += '</div>';
            container += '<div class="col-md-4">';
            container += '<span class="table_content"><a href="displayCollections?currentIndex=1&username=' + users[i].username + '">' + users[i].email + '</a></span>';
            container += '</div>';
            container += '<div class="col-md-4">';
            container += '<span class="table_content">' + users[i].registerTime+ '</span>';
            container += '</div>';
            container += '<div class="col-md-2">';
            container += '<span class="table_content"><a href="chattingRoom?targetUser=' + users[i].username + '">chat</a></span>';
            container += '</div>';
            container += '</div>';
        }

        container += '</div>';
        return container;
    }
    function my_friends_button_clicked(){
        received_invitations_div.hide();
        search_other_users_div.hide();
        friends_div.show();
        friends_table.html("Please waiting ... ");
        $.ajax({
            url: '<%=request.getContextPath()%>/getFriends',
            type: 'GET',
            dataType: 'json',
            data: {},
            success: function(data){
                console.log(data);
                friends_table.html(createFriendsTable(data));
            },
            error: function(error){
                console.log(error);
                toastr.error(JSON.parse(error.responseText).message);
            }
        });
    }

    function send_invitation(receiver) {
        console.log("receiver in send_invitation called: " + receiver);
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
    function createSearchResultsTable(users) {
        var container = '<div class="container" style="width: 100%">';
        // first line
        container += '<div class="row first-row">';
        container += '<div class="col-md-2">';
        container += '<span class="table_title">Username</span>';
        container += '</div>';
        container += '<div class="col-md-4">';
        container += '<span class="table_title">Email</span>';
        container += '</div>';
        container += '<div class="col-md-4">';
        container += '<span class="table_title">Register time</span>';
        container += '</div>';
        container += '<div class="col-md-2">';
        container += '</div>';
        container += '</div>';

        for(var i in users){
            container += '<div class="row normal-row">';
            container += '<div class="col-md-2">';
            container += '<span class="small_table_content">' + users[i].username + '</span>';
            container += '</div>';
            container += '<div class="col-md-4">';
            container += '<span class="small_table_content">' + users[i].email + '</span>';
            container += '</div>';
            container += '<div class="col-md-4">';
            container += '<span class="small_table_content">' + users[i].registerTime+ '</span>';
            container += '</div>';
            container += '<div class="col-md-2">';
            container += '<span class="small_table_content"><button onclick="send_invitation(\'' + users[i].username + '\')">become friends</button></span>';
            container += '</div>';
            container += '</div>';
        }

        container += '</div>';
        return container;
    }
    function search(username) {
        $.ajax({
            url: '<%=request.getContextPath()%>/searchUsers',
            type: 'GET',
            dataType: 'json',
            data: {
                username: username
            },
            success: function(data){
                search_results_table.html(createSearchResultsTable(data));
            },
            error: function(error){
                console.log(error);
                toastr.error(JSON.parse(error.responseText).message);
            }
        });
    }
    function search_other_users_button_clicked(){
        friends_div.hide();
        received_invitations_div.hide();
        search_other_users_div.show();
    }

    var isOpen = ${requestScope.user.open};
    function changeStatus(){
        if(isOpen){
            $("#open_status_span").text("open  to friends");
        }else{
            $("#open_status_span").text("close to friends");
        }
    }
    changeStatus();

    $("#open_switch").click(function () {
        $.ajax({
            url: '<%=request.getContextPath()%>/changeCollectionOpenStatus',
            type: 'GET',
            dataType: 'json',
            data: {},
            success: function(data){
                console.log(data);
                toastr.success(data.message);
                isOpen = !isOpen;
                changeStatus();
            },
            error: function(error){
                console.log(error);
                toastr.error(JSON.parse(error.responseText).message);
            }
        })
    });
    $("#check_received_invitations_button").click(function () {
        check_received_invitations_button_clicked();
    });
    $("#my_friends_button").click(function () {
        my_friends_button_clicked();
    });
    $("#search_button").click(function () {
        search($("#search_username").val());
    });
    $("#search_other_users_button").click(function () {
        search_other_users_button_clicked();
    });
</script>