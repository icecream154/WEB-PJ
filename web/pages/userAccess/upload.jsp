<%@ page import="domain.Picture" %>
<%@ page import="repositoryImplementation.Repo" %>

<%@ include file="../../templates/head.jsp"%>
<title id="page_title">Upload</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/upload.css">
<%@ include file="../../templates/nav.jsp"%>

<%
    String loginUsername = (String) request.getSession().getAttribute("loginUsername");
    if(loginUsername == null){
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    if(request.getParameter("picId") != null){
        Long picId = Long.parseLong(request.getParameter("picId"));
        Picture picture = Repo.pictureRepository.findPictureById(picId);
        request.setAttribute("picture", picture);
    }
%>
<form id="pictureForm" enctype="multipart/form-data" method="post" action="<%=request.getContextPath()%>/uploadPicture" onsubmit="return check();">
    <input type="text" name="id" id="id" style="display: none" value="-1">
    <input type="text" name="changed" id="pic_file_changed" style="display: none" value="false">
    <div class="container form">
            <%--    title--%>
            <div class="row form_line">
                <div class="col-md-3">title:</div>
                <div class="col-md-9">
                    <input class="form_input" type="text" name="title" id="title"/>
                </div>
            </div>
            <%--    theme--%>
            <div class="row form_line">
                <div class="col-md-3">theme:</div>
                <div class="col-md-9">
                    <input class="form_input" type="text" name="theme" id="theme"/>
                </div>
            </div>
            <%--    introduction--%>
            <div class="row form_line">
                <div class="col-md-3">introduction:</div>
                <div class="col-md-9">
                    <textarea class="form_input" name="introduction" id="introduction"></textarea>
                </div>
            </div>
            <%--    country--%>
            <div class="row form_line">
                <div class="col-md-3">country:</div>
                <div class="col-md-9">
                    <select class="form_input" name="country" id="country">
                        <option style="display: none" value=""></option>
                        <option value ="China">China</option>
                        <option value ="America">America</option>
                        <option value="Germany">Germany</option>
                        <option value="France">France</option>
                        <option value ="Australia">Australia</option>
                        <option value="Italy">Italy</option>
                        <option value="Japan">Japan</option>
                        <option value="Tom and Jerry's house">Tom and Jerry's house</option>
                    </select>

                </div>
            </div>
            <%--    city--%>
            <div class="row form_line">
                <div class="col-md-3">city:</div>
                <div class="col-md-9">
                    <select class="form_input" name="city" id="city"></select>
                </div>
            </div>
            <%--    city--%>
            <div class="row form_line">
                <div class="col-md-3">
                    picture: <button type="button" id="picture_choose_button">choose</button>
                        <input style="display: none;" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" type="file" name="picture" id="picture"/>
                </div>
                <div class="col-md-9">

                    <img style="width: 100%; height: 400px" id="picture_preview" src="">
                </div>
            </div>
            <%--    upload submit--%>
            <div class="row form_line last_form_line">
                <div class="col-md-12" style="text-align: right">
                    <button type="submit" id="upload">upload</button>
                </div>
            </div>
    </div>
</form>
<%@ include file="../../templates/end.jsp" %>

<script>
    var isModify = false;
    var city_select = $("#city");
    <c:if test="${requestScope.picture != null}">
        var url = '${requestScope.picture.url}';
        var actUrl = '<%=request.getContextPath()%>/' + url.substring(1, url.length);

        isModify = true;
        $("#id").val("${requestScope.picture.id}");
        $("#title").val("${requestScope.picture.title}");
        $("#theme").val("${requestScope.picture.theme}");
        $("#introduction").val("${requestScope.picture.introduction}");
        $("#country").val("${requestScope.picture.country}");
        country_change();
        $("#city").val("${requestScope.picture.city}");
        $("#picture_preview").attr("src", actUrl);
        $("#upload").text("modify");
        $("#page_title").text("Modify");
    </c:if>

    if(!isModify){
        $("#picture_preview").attr("src", '<%=request.getContextPath()%>/images/plus.jpg');
        $("#picture_preview").css('opacity', '0.2');
    }

    $("#picture").change(function(){
        $("#picture_preview").attr("src", URL.createObjectURL($(this)[0].files[0]));
        $("#picture_preview").css('opacity', '1');
        $("#pic_file_changed").val("true");
    });

    $("#picture_choose_button").click(function () {
        $("#picture").click();
    });

    function check() {
        if($("#title").val() === null || $("#theme").val() === null
            || $("#introduction").val() === null || $("#country").val() === null
            || $("#city").val() === null
            || $("#title").val() === "" || $("#theme").val() === ""
            || $("#introduction").val() === "" || $("#country").val() === ""
            || $("#city").val() === ""){
            toastr.warning("information missing");
            return false;
        }
        //console.log($("#picture").val() === "");
        if(!isModify && $("#picture").val() === ""){
            toastr.warning("picture missing");
            return false;
        }
        return true;
    }


    $("#country").change(function () {
        country_change();
    });

    function country_change() {
        console.log("country change");
        var val = $("#country").val();
        if(val === 'China'){
            city_select.html('<option value ="Beijing">Beijing</option>' +
                '<option value ="Shanghai">Shanghai</option>' +
                '<option value ="Hongkong">Hongkong</option>' +
                '<option value ="Chengdu">Chengdu</option>' +
                '<option value ="Nanjing">Nanjing</option>' +
                '<option value ="Shenzhen">Shenzhen</option>' +
                '<option value ="Kunming">Kunming</option>' +
                '<option value ="Tianjin">Tianjin</option>');
        }else if(val === 'America'){
            city_select.html('<option value ="New York">New York</option>' +
                '<option value ="LA">LA</option>' +
                '<option value ="Washington">Washington</option>' +
                '<option value ="Las Vegas">Las Vegas</option>');
        }else if(val === 'Germany'){
            city_select.html('<option value ="Berlin">Berlin</option>' +
                '<option value ="Hamburger">Hamburger</option>' +
                '<option value ="Frankfurt">Frankfurt</option>' +
                '<option value ="Bonn">Bonn</option>');
        }else if(val === 'France'){
            city_select.html('<option value ="Paris">Paris</option>' +
                '<option value ="Marseille">Marseille</option>' +
                '<option value ="Lyon">Lyon</option>' +
                '<option value ="Nice">Nice</option>');
        }else if(val === 'Australia'){
            city_select.html('<option value ="Sydney">Sydney</option>' +
                '<option value ="Melbourne">Melbourne</option>' +
                '<option value ="Canberra">Canberra</option>');
        }else if(val === 'Italy'){
            city_select.html('<option value ="Roma">Roma</option>' +
                '<option value ="Venezia">Venezia</option>' +
                '<option value ="Firenze">Firenze</option>' +
                '<option value ="Milan">Milan</option>');
        }else if(val === 'Japan'){
            city_select.html('<option value ="Tokyo">Tokyo</option>' +
                '<option value ="Yokohama">Yokohama</option>' +
                '<option value ="Osaka">Osaka</option>' +
                '<option value ="Nagoya">Nagoya</option>');
        }else if(val === 'Tom and Jerry\'s house'){
            city_select.html('<option value ="Tom\'s bed">Tom\'s bed</option>' +
                '<option value ="Jerry\'s little house">Jerry\'s little house</option>' +
                '<option value ="Refrigerator with turkey">Refrigerator with turkey</option>' +
                '<option value ="Master\'s bedroom">Master\'s bedroom</option>');
        }else{
            city_select.html('');
        }

    }

</script>