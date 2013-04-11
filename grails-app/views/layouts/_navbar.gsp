

<div class="row show-frid">
    <div class="span12">
        <div id="breadcrumb">
              <ul >

                    <li class="home btn btn-mini btn-link">${controllerName}</li>
                    <li class="btn btn-mini btn-link">${actionName}</li>
              </ul>
              <g:if test="${actionName=='list' && controllerName=='product'}">
                <g:form action="list" class="navbar-search"> 
  							  <input type="text" name="q" value="${params.q}" class="search-query" placeholder="Search">
  							</g:form>
              </g:if>
              
              <sec:ifAnyGranted roles="ROLE_OPERATOR">

                <g:form action="checkNameIsNew" controller="product" class="navbar-search  pull-right"> 
                  <g:link  class="btn btn-primary" controller="part" action="create">
                    建立維修項目
                  </g:link>
                  <input type="text" name="name" class="search-query" placeholder="建立事件/機車">
                </g:form>
              </sec:ifAnyGranted>
        </div>

    </div>

</div>
