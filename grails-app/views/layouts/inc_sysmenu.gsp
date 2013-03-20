    <li class="${controllerName=='home' && actionName=='index' ?'active':''} single">
        <g:link controller="home">
            <g:message code="default.home.label"/>
            <i>HOME</i>
        </g:link>
    </li>
      
    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_MANERGER">

        <li class="${controllerName=='serviceEvent' && actionName=='create' ?'active':''} single">
            <g:link controller="serviceEvent" action="create">
                服務記錄
                <i>ServiceEvent</i>
            </g:link>
        </li>
    </sec:ifAnyGranted>

    <li class="${controllerName=='post' && type==extrails.PostType.SALE ?'active':''} single">
        <g:link controller="post" action="portfolio" params="[type:'SALE']">
            拍賣
            <i>SALE</i>
        </g:link>
    </li>
    <li class="${controllerName=='post' && type==extrails.PostType.NEWS ?'active':''} single">
        <g:link controller="post" action="portfolio" params="[type:'NEWS']">
            <g:message code="default.news.label"/>
            <i>NEWS</i>
        </g:link>
    </li>
    <li class="${controllerName=='post' && type==extrails.PostType.DEMO ?'active':''} single">
        <g:link controller="post" action="portfolio" params="[type:'DEMO']">
            <g:message code="default.demo.label"/>
            <i>DEMO</i>
        </g:link>
    </li>

%{--     <li class="${controllerName=='part' && actionName=='portfolio' ?'active':''} single">
        <g:link controller="part" action="portfolio">
            <g:message code="default.parts.label" default="parts"/>
            <i>PARTS</i>
        </g:link>
    </li> --}%

    <li class="${controllerName=='home' && actionName=='abouts' ?'active':''} single">
        <g:link controller="home" action="abouts">
            <g:message code="default.abouts.label"/>
            <i>ABOUTS</i>
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

