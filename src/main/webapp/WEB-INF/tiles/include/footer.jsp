<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: bangae1
  Date: 2016-06-21
  Time: 오후 2:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<body>


<!--     start Offcanvas Menu   -->

<div id="offcanvas" class="uk-offcanvas">
    <div class="uk-offcanvas-bar">
        <div class="uk-panel">
            <form class="uk-search" style="display:none;">
                <input class="uk-search-field" type="search" placeholder="Search..."/>
            </form>
            <sec:authorize access="isAnonymous()">
            <div class="uk-button-group">
                <%--<a class="uk-button uk-button-link uk-button-large uk-text-muted" href="signup.html">Sign up</a>--%>
                <a class="uk-button uk-button-success uk-button-large uk-margin-left" href="${pageContext.request.contextPath}/login"><i class="uk-icon-lock uk-margin-small-right"></i> Log in</a>
            </div>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
                <div class="uk-button-group">
                    <span data-toggle="dropdown" class="uk-button uk-button-link uk-button-large dropdown-toggle"><sec:authentication property="principal.name"/> </span>
                </div>
            </sec:authorize>
        </div>
        <ul class="uk-nav uk-nav-offcanvas uk-nav-parent-icon" data-uk-nav="data-uk-nav">
            <li id="all" class="uk-active">
                <a href="#">전체</a>
            </li>
            <li id="featured">
                <a href="#">추천</a>
            </li>
            <li>
                <a href="#">영화</a>
            </li>
            <li>
                <a href="index.html">드라마</a>
            </li>

            <li class="uk-parent" id="genre">
                <a href="#">장르</a>
                <ul class="uk-nav-sub">
                    <li><a href="#">액션</a></li>
                    <li><a href="#">판타지</a></li>
                    <li><a href="#">애니메이션</a> </li>
                    <li><a href="#">SF</a> </li>
                    <li><a href="#">어드벤쳐</a> </li>
                    <li><a href="#">코믹</a> </li>
                    <li><a href="#">스릴러</a> </li>
                    <li><a href="#">로맨스</a> </li>
                    <li><a href="#">다큐</a> </li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<!--     ./ Offcanvas Menu   -->
<!--     Include JS   -->

</body>
</html>
