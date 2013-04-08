

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
        </div>

    </div>
</div>
