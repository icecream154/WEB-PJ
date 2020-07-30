<%@ include file="../templates/head.jsp"%>
<title>Picture : ${requestScope.picture.title}</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/picDetail.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/magiczoomplus.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/enlargement.css">
<script src="<%=request.getContextPath()%>/static/js/mzp-packed.js"></script>
<%@ include file="../templates/nav.jsp"%>

    <div class="row detail_block">
        <div class="col-md-6">
                <a href="${requestScope.picture.url}" class="MagicZoom MagicThumb">
                    <img src="${requestScope.picture.url}" id="main_img" class="main_img" style="width:80%;" />
                </a>
<%--            <img style="width: 100%;" src="${requestScope.picture.url}" alt="no resource found"><br><br>--%>
        </div>
        <div class="col-md-6" style="font-size: 22px;">
            <div class="container" style="width: 100%">
                <div class="row"><div style="font-weight: bold" class="col-md-4">Author         :</div><div class="col-md-8">
                    <a href="getUserAccount?username=${requestScope.picture.author}">${requestScope.picture.author}</a>
                </div></div>
                <div class="row"><div style="font-weight: bold" class="col-md-4">Title         :</div><div class="col-md-8">${requestScope.picture.title}</div></div>
                <div class="row"><div style="font-weight: bold" class="col-md-4">Theme         :</div><div class="col-md-8">${requestScope.picture.theme}</div></div>
                <div class="row"><div style="font-weight: bold" class="col-md-4">Country       :</div><div class="col-md-8">${requestScope.picture.country}</div></div>
                <div class="row"><div style="font-weight: bold" class="col-md-4">City          :</div><div class="col-md-8">${requestScope.picture.city}</div></div>
                <div class="row"><div style="font-weight: bold" class="col-md-4">ReleaseTime   :</div><div class="col-md-8">${requestScope.picture.releaseTime}</div></div>
                <div class="row"><div style="font-weight: bold" class="col-md-4">Heat          :</div><div class="col-md-8"><span id="heat">${requestScope.picture.heat}</span></div></div>
                <div class="row" style="margin-top: 20px;"><div class="col-md-12"><span style="font-weight: bold">Introduction:</span></div></div>
                <div class="row"><div class="col-md-12"><p style="font-size:20px; font-style: italic;">${requestScope.picture.introduction}</p></div></div>
                <div class="row" style="margin-top: 40px;">
                    <div class="col-md-6">
                        <c:if test="${sessionScope.loginUsername != null}">
                            <button class="btn btn-default" id="collect_heart"></button>&nbsp
                        </c:if>
                    </div>
                    <div class="col-md-6">
                        <c:if test="${requestScope.isAuthor}">
                            <button class="btn btn-default" id="modify">modify</button>&nbsp
                            <button class="btn btn-default" id="delete">delete</button>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

<%@ include file="../templates/end.jsp"%>

<script>
    $("#author_td").click(function () {
        window.location.href = "getUserAccount?username=${requestScope.picture.author}";
    });
    <c:if test="${sessionScope.loginUsername != null}">
        var id = ${requestScope.picture.id};
        var collect_heart = $("#collect_heart");
        var isCollected = ${requestScope.isCollected};
        var heatSpan = $("#heat");
        setIcon(isCollected);
        var operation;

        collect_heart.click(function () {
            operation = isCollected ? "REMOVE" : "ADD";
            $.ajax({
                url: '<%=request.getContextPath()%>/updateCollection',
                type: 'GET',
                dataType: 'json',
                data: {
                    id: id,
                    operation: operation
                },
                success: function(data){
                    console.log(data);
                    toastr.success(data.message);
                    isCollected = !isCollected;
                    if(isCollected){
                        heatSpan.text(parseInt(heatSpan.text()) + 1);
                    }else{
                        heatSpan.text(parseInt(heatSpan.text()) - 1);
                    }
                    setIcon(isCollected);
                },
                error: function(error){
                    console.log(error);
                    toastr.error(JSON.parse(error.responseText).message);
                }
            })
        });

        function setIcon(isCollected) {
            if(isCollected){
                collect_heart.html("remove from collection");
            }else{
                collect_heart.html("add to collection");
            }
        }

    </c:if>
    <c:if test="${requestScope.isAuthor}">
        $("#modify").click(function () {
            window.location.href = "<%=request.getContextPath()%>/pages/userAccess/upload.jsp?picId=${requestScope.picture.id}";
        });
        $("#delete").click(function () {
           deletePic();
        });

        function deletePic(){
            if(confirm("Do you really want to delete this picture?")){
                $.ajax({
                    url: "<%=request.getContextPath()%>/deletePicture",
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        picId: ${requestScope.picture.id}
                    },
                    success: function(data){
                        console.log(data);
                        toastr.success(data.message);
                        setTimeout(function () {
                            window.location.href = "<%=request.getContextPath()%>/pages/userAccess/picture.jsp?currentIndex=1";
                        }, 1000);
                    },
                    error: function(error){
                        console.log(error);
                        toastr.error(JSON.parse(error.responseText).message);
                    }
                })
            }
        }

    </c:if>
</script>