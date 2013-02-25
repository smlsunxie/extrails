<ul class="nav">
    <li class="visible-desktop">
        <a href="#" class="document-request-fullscreen">
            <i class="icon icon-fullscreen"></i>
        </a>
    </li>
    <li class="${controllerName=='home'?'active':''}">
        <g:link controller="home">
            <i class="icon icon-home"></i>
            <g:message code="default.home.label" default="Home" />
        </g:link>
    </li>
    <%--已登入才顯示功能表--%>
    <sec:ifLoggedIn>
        <%--課程--%>
        <li class="${controllerName=='course'?'active':''}">
            <g:link controller="course">
                <i class="icon icon-book"></i>
                <g:message code="course.label" default="Course" />
            </g:link>
        </li>
        <%--學習進度--%>
        <li class="${controllerName=='schedule'?'active':''}">
            <g:link controller="schedule">
                <i class="icon icon-tasks"></i>
                <g:message code="schedule.label" default="Schedule" />
            </g:link>
        </li>
    </sec:ifLoggedIn>
</ul>
