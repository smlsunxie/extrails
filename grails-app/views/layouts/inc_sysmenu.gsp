    <li class="${controllerName=='home' && actionName=='index' ?'active':''} single">
        <g:link controller="home">
            <g:message code="default.home.label"/>
            <i>HOME</i>
        </g:link>
    </li>

    <li class="${controllerName=='post' && actionName=='list' ?'active':''} single">
        <g:link controller="post" action="list" >
            <g:message code="default.post.label"/>
            <i>POST</i>
        </g:link>
    </li>

    <li class="${controllerName=='home' && actionName=='news' ?'active':''} single">
        <g:link controller="post" action="list">
            <g:message code="default.news.label"/>
            <i>NEWS</i>
        </g:link>
    </li>
    <li class="${controllerName=='post' && actionName=='list' ?'active':''} single">
        <g:link controller="post" action="list">
            <g:message code="default.demo.label"/>
            <i>demo</i>
        </g:link>
    </li>
    <li class="${controllerName=='home' && actionName=='abouts' ?'active':''} single">
        <g:link controller="post" action="list">
            拍賣
            <i>sale</i>
        </g:link>
    </li>
    <li class="${controllerName=='home' && actionName=='aboutus' ?'active':''} single">
        <g:link controller="post" action="list">
            <g:message code="default.abouts.label"/>
            <i>abouts</i>
        </g:link>
    </li>



%{--     <li class="visible-desktop">
        <a href="#" class="document-request-fullscreen">
            <i class="icon icon-fullscreen"></i>
        </a>
    </li> --}%



%{--     <li class="${controllerName=='content'?'active':''}">
        <g:link controller="content">
            <i class="icon"></i>
            <g:message code="default.content.label" default="content" />
        </g:link>
        
    </li> --}%

    <%--已登入才顯示功能表--%>
    <sec:ifLoggedIn>
%{--         <%--課程--%>
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
        </li> --}%
    </sec:ifLoggedIn>

