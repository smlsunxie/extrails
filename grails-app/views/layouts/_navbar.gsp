

<div class="row show-frid">
    <div class="col-sm-12 col-md-12">
        <div id="breadcrumb">
              <ul >
                  <li class="home">${controllerName}</li>
                  <li>${actionName}</li>

                  <li id="alert_placeholder"></li>
              </ul>
              
              <sec:ifAnyGranted roles="ROLE_OPERATOR">

                <g:form action="query" controller="search" class="form-inline pull-right"> 
                  <input type="text" name="q" class="form-control" placeholder="機車或使用者" value="${params.q}">
                </g:form>
              </sec:ifAnyGranted>





        </div>

    </div>

</div>

