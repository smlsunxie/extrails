

<div class="row show-frid">
    <div class="col-sm-12 col-md-12">
        <div id="breadcrumb">
              <ul >
                  <li class="home btn btn-mini btn-link">
                    <g:link controller="home" action="index">
                      回首頁
                    </g:link>
                  </li>
                  <li class="btn btn-mini btn-link">${controllerName}</li>
                  <li class="btn btn-mini btn-link">${actionName}</li>
              </ul>
%{--               <g:if test="${actionName=='list' && controllerName=='product'}">
                <g:form action="list" class="navbar-search"> 
  							  <input type="text" name="q" value="${params.q}" class="search-query" placeholder="Search">
  							</g:form>
              </g:if> --}%
              
              <sec:ifAnyGranted roles="ROLE_OPERATOR">

                <g:form action="checkNameIsNew" controller="product" class="navbar-search  pull-right"> 
                  <sec:ifSwitched>
                    <a href='${request.contextPath}/j_spring_security_exit_user' id="exitSwitch" class="btn btn-primary" >
                        <%--回復身分--%>
                        切換使用者
                    </a>
                  </sec:ifSwitched> 

                  <g:link  class="btn btn-primary" controller="part" action="create">
                    建立維修項目
                  </g:link>





                  <input type="text" name="name" class="search-query" placeholder="事件/機車/查詢" value="${params.q}">
                </g:form>
              </sec:ifAnyGranted>





        </div>

    </div>

</div>

