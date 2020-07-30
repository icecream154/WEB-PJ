<%@ page import="repositoryImplementation.Repo" %>
<%@ page import="domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String loginUsername = (String) request.getSession().getAttribute("loginUsername");
    if(loginUsername == null){
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    User loginUser = Repo.userRepository.findUserByUsername(loginUsername);
    request.setAttribute("loginUser", loginUser);
    int currentIndex = Integer.parseInt(request.getParameter("currentIndex"));
%>

<%@ include file="../../templates/head.jsp"%>
<title>My Pictures</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/picture.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/paging.css">
<%@ include file="../../templates/nav.jsp"%>


        <div class="container" style="width: 80%;">
            <c:if test="${requestScope.loginUser.pictureCount == 0}">
                <span class="no_results">No pictures!&nbsp<a href="<%=request.getContextPath()%>/pages/userAccess/upload.jsp">Go Upload!</a></span>
            </c:if>
            <c:if test="${requestScope.loginUser.pictureCount != 0}">
                <div id="pics">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="paging_pic_block" id="pic0">
                                <img class="paging_img" id="img0" src="" alt=""><br>
                                <table cellspacing="10" cellpadding="10" class="paging_info_table">
                                    <tr><td class="paging_item_td">title:</td><td class="paging_content_td"><span id="title0"></span></td></tr>
                                    <tr><td class="paging_item_td">theme:</td><td class="paging_content_td"><span id="theme0"></span></td></tr>
                                    <tr><td class="paging_item_td">country:</td><td class="paging_content_td"><span id="country0"></span></td></tr>
                                    <tr><td class="paging_item_td">city:</td><td class="paging_content_td"><span id="city0"></span></td></tr>
                                </table>
                                <button class="btn btn-default" type="button" id="modify0">modify</button>&nbsp
                                <button class="btn btn-default" type="button" id="delete0">delete</button><br>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="paging_pic_block" id="pic1">
                                <img class="paging_img" id="img1" src="" alt=""><br>
                                <table cellspacing="10" cellpadding="10" class="paging_info_table">
                                    <tr><td class="paging_item_td">title:</td><td class="paging_content_td"><span id="title1"></span></td></tr>
                                    <tr><td class="paging_item_td">theme:</td><td class="paging_content_td"><span id="theme1"></span></td></tr>
                                    <tr><td class="paging_item_td">country:</td><td class="paging_content_td"><span id="country1"></span></td></tr>
                                    <tr><td class="paging_item_td">city:</td><td class="paging_content_td"><span id="city1"></span></td></tr>
                                </table>
                                <button class="btn btn-default" type="button" id="modify1">modify</button>&nbsp
                                <button class="btn btn-default" type="button" id="delete1">delete</button><br>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="paging_pic_block" id="pic2">
                                <img class="paging_img" id="img2" src="" alt=""><br>
                                <table cellspacing="10" cellpadding="10" class="paging_info_table">
                                    <tr><td class="paging_item_td">title:</td><td class="paging_content_td"><span id="title2"></span></td></tr>
                                    <tr><td class="paging_item_td">theme:</td><td class="paging_content_td"><span id="theme2"></span></td></tr>
                                    <tr><td class="paging_item_td">country:</td><td class="paging_content_td"><span id="country2"></span></td></tr>
                                    <tr><td class="paging_item_td">city:</td><td class="paging_content_td"><span id="city2"></span></td></tr>
                                </table>
                                <button class="btn btn-default" type="button" id="modify2">modify</button>&nbsp
                                <button class="btn btn-default" type="button" id="delete2">delete</button><br>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="paging_pic_block" id="pic3">
                                <img class="paging_img" id="img3" src="" alt=""><br>
                                <table cellspacing="10" cellpadding="10" class="paging_info_table">
                                    <tr><td class="paging_item_td">title:</td><td class="paging_content_td"><span id="title3"></span></td></tr>
                                    <tr><td class="paging_item_td">theme:</td><td class="paging_content_td"><span id="theme3"></span></td></tr>
                                    <tr><td class="paging_item_td">country:</td><td class="paging_content_td"><span id="country3"></span></td></tr>
                                    <tr><td class="paging_item_td">city:</td><td class="paging_content_td"><span id="city3"></span></td></tr>
                                </table>
                                <button class="btn btn-default" type="button" id="modify3">modify</button>&nbsp
                                <button class="btn btn-default" type="button" id="delete3">delete</button><br>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="paging" class="paging_list">
                    <div class="row" style="text-align: center">
                        <button class="btn btn-default" id="firstPage"> << </button>
                        <button class="btn btn-default"  id="previousPage"> < </button>
                        Current Page: <span id="pageIndex"></span> of <span id="totalPage"></span>
                        <button class="btn btn-default"  id="nextPage"> > </button>
                        <button class="btn btn-default"  id="lastPage"> >> </button>
                        <input id="goPageNum" type="number"/><button class="btn btn-default" id="goPage">Go</button>
                        <br>
                    </div>
                </div>
            </c:if>
        </div>


<%@ include file="../../templates/end.jsp"%>

<script>
    <c:if test="${requestScope.loginUser.pictureCount != 0}">

        var pageSize = 4;
        var pictureCount = <%= loginUser.getPictureCount()%>;
        var totalPage = Math.ceil(pictureCount / pageSize);
        $("#totalPage").text(totalPage);
        var currentIndex = <%= currentIndex%>;

        var modifyUrls = ["","","",""];
        var deleteUrls = ["","","",""];
        var imgUrls = ["","","",""];

        function modifyPic(index) {
            console.log("modifyPic: " + index);
            console.log(modifyUrls);
            window.location.href = modifyUrls[index];
        }

        function showPicDetail(index){
            window.location.href = imgUrls[index];
        }

        function deletePic(i){
            console.log("deletePic: " + i);
            console.log(deleteUrls);
            if(confirm("Do you really want to delete this picture?")){
                $.ajax({
                    url: deleteUrls[i],
                    type: 'GET',
                    dataType: 'json',
                    data: {},
                    success: function(data){
                        console.log(data);
                        toastr.success(data.message);
                        setTimeout(function () {
                            if(currentIndex === totalPage && pictureCount % pageSize === 1){
                                // last picture of last page
                                window.location.href = "<%=request.getContextPath()%>/pages/userAccess/picture.jsp?currentIndex=" + (currentIndex-1);
                            }else{
                                window.location.href = "<%=request.getContextPath()%>/pages/userAccess/picture.jsp?currentIndex=" + currentIndex;
                            }
                        }, 1000);
                    },
                    error: function(error){
                        console.log(error);
                        toastr.error(JSON.parse(error.responseText).message);
                    }
                })
            }
        }

        //set image click event
        $("#img0").click(function () {
            showPicDetail(0);
        });
        $("#img1").click(function () {
            showPicDetail(1);
        });
        $("#img2").click(function () {
            showPicDetail(2);
        });
        $("#img3").click(function () {
            showPicDetail(3);
        });

        // set function of modify and delete button
        $("#modify0").click(function () {
            modifyPic(0);
        });
        $("#delete0").click(function () {
            deletePic(0);
        });
        $("#modify1").click(function () {
            modifyPic(1);
        });
        $("#delete1").click(function () {
            deletePic(1);
        });
        $("#modify2").click(function () {
            modifyPic(2);
        });
        $("#delete2").click(function () {
            deletePic(2);
        });
        $("#modify3").click(function () {
            modifyPic(3);
        });
        $("#delete3").click(function () {
            deletePic(3);
        });
        //set ending


        $("#firstPage").click(function(){
            refresh(1);
        });

        $("#lastPage").click(function(){
            refresh(totalPage);
        });

        $("#previousPage").click(function(){
            refresh(currentIndex - 1);
        });

        $("#nextPage").click(function(){
            refresh(currentIndex + 1);
        });

        $("#goPage").click(function(){
           refresh($("#goPageNum").val());
        });

        refresh(currentIndex);

        function refresh(pageIndex) {
            if(pageIndex <= 0 || pageIndex > totalPage){
                refresh(1);
                return;
            }

            $.ajax({
                url: '<%=request.getContextPath()%>/getMyPictures',
                type: 'GET',
                dataType: 'json',
                data: {
                    pageIndex: pageIndex,
                    pageSize: pageSize
                },
                success: function(data){
                    // alert("success");
                    // update pic divs
                    var picIndex = 0;
                    for(var pic in data){
                        update(picIndex, data[picIndex]);
                        // update modify urls and delete urls
                        updateImgAndModifyAndDeleteUrls(picIndex, data[picIndex].id);
                        picIndex++;
                    }
                    for(var i = picIndex; i < pageSize; i++){
                        hide(i);
                    }
                    // update paging div
                    currentIndex = pageIndex;
                    $("#pageIndex").text(pageIndex);

                },
                error: function(error){
                    console.log(error);
                    toastr.error(JSON.parse(error.responseText).message);
                }
            })

        }

        function updateImgAndModifyAndDeleteUrls(index, picId){
            modifyUrls[index] = "<%=request.getContextPath()%>/pages/userAccess/upload.jsp?picId=" + picId;
            deleteUrls[index] = "<%=request.getContextPath()%>/deletePicture?picId=" + picId;
            imgUrls[index] = "<%=request.getContextPath()%>/getPictureDetail?id=" + picId;
        }

        function update(index, pic) {
            console.log(pic);
            $("#pic" + index).show();
            $("#img" + index).attr('src', '<%=request.getContextPath()%>' + pic.url.substring(1, pic.url.length));
            $("#title" + index).text(pic.title);
            $("#theme" + index).text(pic.theme);
            $("#country" + index).text(pic.country);
            $("#city" + index).text(pic.city);
        }

        function hide(index) {
            $("#pic" + index).hide();
        }

    </c:if>
</script>