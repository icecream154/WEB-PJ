<div class="container" style="width: 75%;">
    <div class="row">
        <div class="col-md-12">
            <nav class="navbar navbar-default" role="navigation">
                <div class="container-fluid">
                    <div style="margin-right: 15px;" class="navbar-header">
                        <img src="<%=request.getContextPath()%>/images/Tk.png" alt="" style="height: 45px;">
                        <a style="font-size: 34px;" class="navbar-brand" href="#"></a>
                    </div>
                    <div>
                        <!--向左对齐-->
                        <ul class="nav navbar-nav navbar-left">
                            <li style="margin-right: 30px;" class="nav_a"><a style="font-size: 34px" href="#">Travel Kid</a></li>
                            <li class="nav_a"><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
                            <li class="nav_a"><a href="<%=request.getContextPath()%>/pages/search.jsp">Search</a></li>
                        </ul>
                        <!--向右对齐-->
                        <c:if test="${sessionScope.loginUsername != null}">
                            <ul class="nav navbar-nav navbar-right">
                                <li class="dropdown">
                                    <a id="nav_username" href="#" class="dropdown-toggle" data-toggle="dropdown">
                                        ${sessionScope.loginUsername} <b class="caret"></b>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a class="nav_a_in_li" href="<%=request.getContextPath()%>/getUserAccount?username=${sessionScope.loginUsername}">my account</a></li>
                                        <li><a class="nav_a_in_li" href="<%=request.getContextPath()%>/displayCollections?currentIndex=1&username=${sessionScope.loginUsername}">my collections</a></li>
                                        <li><a class="nav_a_in_li" href="<%=request.getContextPath()%>/pages/userAccess/picture.jsp?currentIndex=1">my pictures</a></li>
                                        <li><a class="nav_a_in_li" href="<%=request.getContextPath()%>/pages/userAccess/upload.jsp">upload picture</a></li>
                                        <li class="divider"></li>
                                        <li><a class="nav_a_in_li" href="#" onclick="logout()">log out</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </c:if>
                        <c:if test="${sessionScope.loginUsername == null}">
                            <ul class="nav navbar-nav navbar-right">
                                <li class="nav_a"><a id="log_in_a" href="<%=request.getContextPath()%>/pages/account/login.jsp">Login</a></li>
                                <li class="nav_a"><a href="<%=request.getContextPath()%>/pages/account/register.jsp">Register</a></li>
                            </ul>
                        </c:if>
                    </div>
                </div>
            </nav>