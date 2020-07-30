<%@ include file="../templates/head.jsp"%>
<title>Search</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/search.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/paging.css">
<%@ include file="../templates/nav.jsp"%>

<div id="search_header" class="row">
    <div class="col-md-7"><input style="width: 100%;" id="search_content" type="text"/></div>
    <div class="col-md-2">Field: <span class="" id="title_span">title</span>&nbsp/&nbsp<span class="" id="theme_span">theme</span></div>
    <div class="col-md-2">Order by: <span class="" id="heat_span">heat</span>&nbsp/&nbsp<span class="" id="time_span">time</span></div>
    <div class="col-md-1"><button id="search_button">Search</button></div>
</div>

<div class="separator_line"></div>

<div id="no_results"><span>Sorry! No results</span><br></div>

<div id="search_results" class="container" style="width: 80%;">
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
</div>
<%@ include file="../templates/end.jsp"%>

<script>
    var no_results = $("#no_results");
    var search_results = $("#search_results");
    // haven't search yet
    no_results.hide();
    search_results.hide();

    var searchContent = "";
    var searchField;
    var searchOrder;
    var selectedSearchField;
    var selectedSearchOrder;
    var newSearch;
    // initialize
    title_span_clicked();
    heat_span_clicked();

    //set image click event
    var imgUrls = ["","","",""];
    function showPicDetail(index){
        window.location.href = imgUrls[index];
    }
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

    var pageSize = 4;
    var pictureCount = 0;
    var totalPage = 0;
    var currentIndex = 1;
    $("#search_button").click(function () {
        searchField = selectedSearchField;
        searchOrder = selectedSearchOrder;
        searchContent = $("#search_content").val();
        newSearch = true;
        refresh(1);
        newSearch = false;
    });
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

    function refresh(pageIndex) {
        console.log("pageIndex: " + pageIndex);
        if(!newSearch && (pageIndex <= 0 || pageIndex > totalPage)){
            refresh(1);
            return;
        }
        $.ajax({
            url: '<%=request.getContextPath()%>/searchPictures',
            type: 'GET',
            dataType: 'json',
            data: {
                searchContent : searchContent,
                searchField : searchField,
                searchOrder : searchOrder,
                pageSize : pageSize,
                pageIndex : pageIndex
            },
            success: function(data){
                pictureCount = data.totalPictureCount;
                if(pictureCount === 0){
                    no_results.show();
                    search_results.hide();
                    return;
                }
                totalPage = Math.ceil(pictureCount / pageSize);
                $("#totalPage").text(totalPage);

                var picIndex = 0;
                for(var pic in data.pics){
                    imgUrls[picIndex] = "<%=request.getContextPath()%>/getPictureDetail?id=" + data.pics[picIndex].id;
                    update(picIndex, data.pics[picIndex]);
                    picIndex++;
                }
                for(var i = picIndex; i < pageSize; i++){
                    hide(i);
                }
                // update paging div
                currentIndex = pageIndex;
                $("#pageIndex").text(pageIndex);
                no_results.hide();
                search_results.show();
            },
            error: function(error){
                console.log(error);
                toastr.error(JSON.parse(error.responseText).message);
            }
        })

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

    // radio select
    $("#title_span").click(function () {
        title_span_clicked();
    });
    $("#theme_span").click(function () {
        theme_span_clicked();
    });
    $("#heat_span").click(function () {
        heat_span_clicked();
    });
    $("#time_span").click(function () {
        time_span_clicked();
    });
    function title_span_clicked() {
        console.log("title_span_clicked");
        selectedSearchField = "TITLE";
        $("#title_span").addClass("selected");
        $("#theme_span").removeClass("selected");
    }
    function theme_span_clicked() {
        console.log("theme_span_clicked");
        selectedSearchField = "THEME";
        $("#title_span").removeClass("selected");
        $("#theme_span").addClass("selected");
    }
    function heat_span_clicked() {
        console.log("heat_span_clicked");
        selectedSearchOrder = "HEAT";
        $("#heat_span").addClass("selected");
        $("#time_span").removeClass("selected");
    }
    function time_span_clicked() {
        console.log("time_span_clicked");
        selectedSearchOrder = "TIME";
        $("#heat_span").removeClass("selected");
        $("#time_span").addClass("selected");
    }

</script>
