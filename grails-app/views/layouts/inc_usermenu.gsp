



    <sec:ifNotLoggedIn>
        <%--未登入--%>

        <li class="${controllerName=='login' && actionName=='auth' ?'active':''} single">
            <g:link controller="login" action="auth">
               <g:message code="default.login.text" />
                <i>LOGIN</i>
            </g:link>
        </li>

    </sec:ifNotLoggedIn>
    <sec:ifLoggedIn>
      <sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_OPERATOR">
%{--         <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#menu2">
                事件
                <i>Event</i>
            </a>
   
            <ul class="dropdown-menu">

                <li >
                    <g:link controller="event" action="create">
                        建立新的事件
                    </g:link>
                </li>
                <li >
                    <g:link controller="eventDetail" action="create">
                        新增事件記錄
                    </g:link>
                </li>
                <li >
                    <g:link controller="event" action="list" params="[offset:0,max:10]">
                        事件清單
                    </g:link>
                </li>
            </ul>
        </li> --}%
        <li class="${controllerName=='home' && actionName=='question' ?'active':''} single">
            <g:link controller="home" action="question">
               有問題
               <i>QUESTION</i>
            </g:link>
        </li>
        <li class="${controllerName=='part' && actionName=='portfolio' ? 'active':''} single">
            <g:link controller="part" action="portfolio">
                檢視維修項目
                <i>PART</i>
            </g:link>
        </li>


%{--         <li class="${controllerName=='product' && actionName=='create' ? 'active':''} single">
            <a id='productCreateLink' >
                建立事件/機車
                <i>EVENT/PRODUCT</i>
            </a>
        </li> --}%


%{--         <li class="${controllerName=='product' && actionName=='list' ? 'active':''} single">
            <g:link controller="product" action="list">
                機車查詢
                <i>PRODUCT</i>
            </g:link>
        </li> --}%

        <li class="${controllerName=='post' && actionName=='create' ? 'active':''} single">
            <g:link controller="post" action="create">
                建立文章
                <i>POST</i>
            </g:link>
        </li>



%{--         <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#menu2">
                資料建立
                <i>DATA</i>
            </a>
   
            <ul class="dropdown-menu">

                <li>
                    <g:link controller="part" action="list" params="[offset:0,max:10]">
                        維修項目清單
                    </g:link>
                </li>
                <li>
                    <a id='productCreateLink' >
                        建立機車
                    </a>
                </li>


                <li>
                    <g:link controller="post" action="create">
                        叫貨
                    </g:link>
                </li>


            </ul>
        </li> --}%
%{--         <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#menu2">
                <g:message code="summary.label"/>
                <i>SUMMARY</i>
            </a>
   
            <ul class="dropdown-menu">
                <li>
                    <g:link controller="summary" action="unreceiveMoney">
                        <g:message code="summary.unreceiveMoney.label"/>
                    </g:link>
                </li>
                <li>
                    <g:link controller="summary" action="day">
                        <g:message code="summary.day.label"/>
                    </g:link>
                </li>
                <li>
                    <g:link controller="summary" action="week">
                        <g:message code="summary.week.label"/>
                    </g:link>
                </li>
                <li>
                    <g:link controller="summary" action="month">
                        <g:message code="summary.month.label"/>
                    </g:link>
                </li>


            </ul>
        </li> --}%
      </sec:ifAnyGranted>

        <%--已登入--%>
      <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#menu3">
              <g:displayUserName />
              <i>ID</i>
          </a>
 
          <ul class="dropdown-menu">
                <li>
                    <g:link controller="part" action="list" params="[offset:0,max:10]">
                        維修項目清單
                    </g:link>
                </li>

                <li >
                    <g:link controller="event" action="create">
                        建立新的事件
                    </g:link>
                </li>

                <li>
                    <g:link controller="part" action="create">
                        建立維修項目
                    </g:link>
                </li>
                <li >
                    <g:link controller="event" action="list" params="[offset:0,max:10]">
                        事件清單
                    </g:link>
                </li>
                <li>
                    <g:link controller="post" action="list">
                        <g:message code="post.list.label"/>
                    </g:link>
                </li>
                <li >
                    <g:link controller="product" action="list" params="[offset:0,max:10]">
                        產品清單
                    </g:link>
                </li>

%{--                 <li>
                    <g:link controller="user" action="profile">
                        <i class="icon icon-user-md"></i>
                        <%--個人資料--%>
                        <g:message code="default.user.preferences.text" />
                </li> --}%

              <sec:ifAnyGranted roles="ROLE_ADMIN">

                  <li>
                      <g:link controller="user">
                          <%--系統管理--%>
                          <g:message code="default.administration.text" />
                      </g:link>
                  </li>
              </sec:ifAnyGranted>


              <sec:ifNotSwitched>
                  <li>
                      <g:link uri="/j_spring_security_logout">
                          <%--登出--%>
                          <g:message code="default.logout.text" />
                      </g:link>
                  </li>
              </sec:ifNotSwitched>

          </ul>
      </li>
  </sec:ifLoggedIn>
