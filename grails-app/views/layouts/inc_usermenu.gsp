



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
      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_MANERGER">
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#menu2">
                顧客
                <i>customer</i>
            </a>
   
            <ul class="dropdown-menu">
                <li>
                    <g:link controller="post" action="create">
                        維護
                    </g:link>
                </li>
                <li>
                    <g:link controller="post" action="create">
                        維修
                    </g:link>
                </li>
          </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#menu2">
                店家
                <i>store</i>
            </a>
   
            <ul class="dropdown-menu">
%{--                 <li>
                    <g:link controller="post" action="create">
                        主要產品
                    </g:link>
                </li> --}%

                <li>
                    <g:link controller="part" action="create">
                        零件新增
                    </g:link>
                </li>

%{--                 <li>
                    <g:link controller="post" action="create">
                        叫貨
                    </g:link>
                </li> --}%


            </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#menu2">
                <g:message code="post.label"/>
                <i>POST</i>
            </a>
   
            <ul class="dropdown-menu">
                <li>
                    <g:link controller="post" action="create">
                        <g:message code="post.create.label"/>
                    </g:link>
                </li>
                <li>
                    <g:link controller="post" action="list">
                        <g:message code="post.list.label"/>
                    </g:link>
                </li>
          </ul>
      </li>
      </sec:ifAnyGranted>

        <%--已登入--%>
      <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#menu3">
              <g:displayUserName />
              <i>ID</i>
          </a>
 
          <ul class="dropdown-menu">
 
%{--                 <li>
                    <g:link controller="user" action="profile">
                        <i class="icon icon-user-md"></i>
                        <%--個人資料--%>
                        <g:message code="default.user.preferences.text" />
                </li> --}%

              <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_MANERGER">

                  <li>
                      <g:link controller="user">
                          <%--系統管理--%>
                          <g:message code="default.administration.text" />
                      </g:link>
                  </li>
                  <li>
                      <g:link controller="post" action="create">
                          <g:message code="default.fix.logs.label"/>
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
              <sec:ifSwitched>
                  <li>
                      <a href='${request.contextPath}/j_spring_security_exit_user'>
                          <%--回復身分--%>
                          Resume as <sec:switchedUserOriginalUsername/>
                      </a>
                  </li>
              </sec:ifSwitched>
          </ul>
      </li>
  </sec:ifLoggedIn>

