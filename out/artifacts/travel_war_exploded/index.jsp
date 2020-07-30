<%@ page import="domain.Picture" %>
<%@ page import="java.util.List" %>
<%@ page import="repositoryImplementation.Repo" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="templates/head.jsp"%>
<title>Home</title>
<meta name="description" content="The home page of this web site. It displays the hottest pictures and the latest pictures to visitors.">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/static/css/index.css">
<%@ include file="templates/nav.jsp"%>

<%
    List picturesOrderByHeat = Repo.pictureRepository.findPicturesByTitleContainsOrderByHeat("");
    int size = picturesOrderByHeat.size() > 5 ? 5 : picturesOrderByHeat.size();
    List hottestPictures = new ArrayList();
    for(int i = 0; i < size; i++){
        hottestPictures.add(picturesOrderByHeat.get(i));
    }

    List picturesOrderByReleaseTime = Repo.pictureRepository.findPicturesByTitleContainsOrderByReleaseTime("");
    size = picturesOrderByReleaseTime.size() > 3 ? 3 : picturesOrderByReleaseTime.size();
    List latestPictures = new ArrayList();
    for(int i = 0; i < size; i++){
        latestPictures.add(picturesOrderByReleaseTime.get(i));
    }

    System.out.println(hottestPictures);
    System.out.println(latestPictures);
    request.setAttribute("hottestPictures", hottestPictures);
    request.setAttribute("latestPictures", latestPictures);
%>

<div class="container" style="width: 100%; margin-top: 80px;">
    <div class="row">
        <div class="col-md-6">
            <span style="font-size:56px;">Welcome to <strong>Travel Kid</strong>!</span><br><br><br><br><br><br><br>
            <span style="font-size:38px;">World's famous traveller community</span><br>
            <span style="font-size:38px;">You can find all kinds of information here.</span><br>
        </div>
        <div class="col-md-6">
            <div class="banner" id="b03">
                <ul>
                    <c:forEach items="${requestScope.hottestPictures}" var="pic">
                        <li>
                            <a href="getPictureDetail?id=${pic.id}"><img style="width: 600px; height: 480px;" src="${pic.url}"></a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <div class="separator_line"></div>

    <div class="row" style="margin-bottom: 30px;">
        <div class="col-md-12">
            <span style="font-size: 38px">Recent pictures:</span>
        </div>
    </div>
    <div class="row" style="margin-bottom: 60px;">
        <c:forEach items="${requestScope.latestPictures}" var="pic">
            <div class="col-md-4" style="text-align: center">
                <a href="getPictureDetail?id=${pic.id}"><img style="width: 83.3333%; height: 400px;" src="${pic.url}"></a><br>
                <div class="container" style="width: 100%; text-align: left; margin-top: 20px;">
                    <div class="row table-row">
                        <div class="col-md-1"></div>
                        <div class="col-md-4"><span class="paging_item_td">author:</span></div>
                        <div class="col-md-6"><span class="paging_content_td">${pic.author}</span></div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="row table-row">
                        <div class="col-md-1"></div>
                        <div class="col-md-4"><span class="paging_item_td">theme:</span></div>
                        <div class="col-md-6"><span class="paging_content_td">${pic.theme}</span></div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="row table-row">
                        <div class="col-md-1"></div>
                        <div class="col-md-4"><span class="paging_item_td">releaseTime:</span></div>
                        <div class="col-md-6"><span class="paging_content_td">${pic.releaseTime}</span></div>
                        <div class="col-md-1"></div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="templates/end.jsp"%>

<script src="<%=request.getContextPath()%>/static/js/unslider.min.js"></script>
<script>
    $(document).ready(function(e) {
        $('#b03').unslider({
            dots: true
        });
    });
</script>
