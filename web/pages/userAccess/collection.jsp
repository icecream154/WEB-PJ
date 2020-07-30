<%
    if(request.getSession().getAttribute("loginUsername") != null){
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
%>
<%@ include file="../../templates/head.jsp"%>
<title>
    <c:if test="${requestScope.isValid}">
        <c:if test="${requestScope.isOwnCollection}">
            My
        </c:if>
        <c:if test="${!requestScope.isOwnCollection}">
            ${requestScope.username}'s
        </c:if>
    </c:if>
    collection
</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/collection.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/paging.css">
<%@ include file="../../templates/nav.jsp"%>
    <div class="row" style="margin-top: 60px;">
        <div class="col-md-3" style="padding-left: 20px;">
            <c:if test="${requestScope.isValid && requestScope.isOwnCollection}">
                <%--footPrintList--%>
                <span style="font-size: 26px; font-weight: bold">My Footprint List</span><br><br>
                <c:forEach items="${requestScope.footprints}" var="pic">
                    <a style="font-size: 20px;" href="getPictureDetail?id=${pic.id}">${pic.title}</a><br>
                </c:forEach>
                <br>
            </c:if>
        </div>
        <div class="col-md-9">
            <span style="font-size: 32px; font-weight: bold">
                <c:if test="${requestScope.isValid}">
                    <c:if test="${requestScope.isOwnCollection}">
                        My
                    </c:if>
                    <c:if test="${!requestScope.isOwnCollection}">
                        ${requestScope.username}'s
                    </c:if>
                </c:if>
                collection
            </span><br><br>
            <c:if test="${!requestScope.isValid}">
                <span class="no_results">${requestScope.invalidMessage}</span>
            </c:if>
            <c:if test="${requestScope.isValid}">
                <c:if test="${requestScope.collectionSize == 0}">
                    <span class="no_results">No collections</span>
                </c:if>
                <div class="container" style="width: 100%;">
                    <c:if test="${requestScope.collectionSize != 0}">
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
                                        <c:if test="${requestScope.isOwnCollection}">
                                            <button class="btn btn-default" type="button" id="remove0">remove</button><br>
                                        </c:if>
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
                                        <c:if test="${requestScope.isOwnCollection}">
                                            <button class="btn btn-default" type="button" id="remove1">remove</button><br>
                                        </c:if>
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
                                        <c:if test="${requestScope.isOwnCollection}">
                                            <button class="btn btn-default" type="button" id="remove2">remove</button><br>
                                        </c:if>
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
                                        <c:if test="${requestScope.isOwnCollection}">
                                            <button class="btn btn-default" type="button" id="remove3">remove</button><br>
                                        </c:if>
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

            </c:if>
        </div>
    </div>




<%@ include file="../../templates/end.jsp"%>

<script>
    <c:if test="${requestScope.isValid && requestScope.collectionSize != 0}">
        var pageSize = 4;
        var pictureCount = ${requestScope.collectionSize};
        var totalPage = Math.ceil(pictureCount / pageSize);
        $("#totalPage").text(totalPage);
        var currentIndex = ${requestScope.currentIndex};
        //alert("currentIndex: [" + currentIndex + "] pictureCount: [" + pictureCount + "] totalPage: [" + totalPage + "]");
        var imgUrls = ["","","",""];
        function showPicDetail(index){
            window.location.href = imgUrls[index];
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

        <c:if test="${requestScope.isOwnCollection}">
            var removeUrls = ["","","",""];
            function removePic(i){
                console.log("removePic: " + i);
                console.log(removeUrls);
                //if(confirm("Do you really want to remove this picture from your collection?")){
                    $.ajax({
                        url: removeUrls[i],
                        type: 'GET',
                        dataType: 'json',
                        data: {},
                        success: function(data){
                            console.log(data);
                            toastr.success(data.message);
                            setTimeout(function () {
                                if(currentIndex === totalPage && pictureCount % pageSize === 1){
                                    // last picture of last page
                                    window.location.href = "displayCollections?username=${requestScope.username}&currentIndex=" + (currentIndex-1);
                                }else{
                                    window.location.href = "displayCollections?username=${requestScope.username}&currentIndex=" + currentIndex;
                                }
                            }, 1000);
                        },
                        error: function(error){
                            console.log(error);
                            toastr.error(JSON.parse(error.responseText).message);
                        }
                    })
                //}
            }
            // set function of remove button
            $("#remove0").click(function () {
                removePic(0);
            });
            $("#remove1").click(function () {
                removePic(1);
            });
            $("#remove2").click(function () {
                removePic(2);
            });
            $("#remove3").click(function () {
                removePic(3);
            });
        </c:if>

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
                url: '<%=request.getContextPath()%>/getCollections',
                type: 'GET',
                dataType: 'json',
                data: {
                    username: "${requestScope.username}",
                    pageIndex: pageIndex,
                    pageSize: pageSize
                },
                success: function(data){
                    // update pic divs
                    var picIndex = 0;
                    for(var pic in data){
                        update(picIndex, data[picIndex]);
                        // update modify urls and delete urls
                        updateImgAndRemoveUrls(picIndex, data[picIndex].id);
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

        function updateImgAndRemoveUrls(index, picId){
            <c:if test="${requestScope.isOwnCollection}">
                removeUrls[index] = "<%=request.getContextPath()%>/updateCollection?operation=REMOVE&id=" + picId;
            </c:if>
            imgUrls[index] = "<%=request.getContextPath()%>/getPictureDetail?id=" + picId;
        }

        function update(index, pic) {
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