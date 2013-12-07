

<div class="row show-frid">
    <div class="col-sm-12 col-md-12">
        <div id="breadcrumb">
              <ul >
                  <li class="home">${controllerName}</li>
                  <li>${actionName}</li>
              </ul>
              
              <sec:ifAnyGranted roles="ROLE_OPERATOR">

                <g:form action="checkNameIsNew" controller="product" class="form-inline pull-right"> 
                  <input type="text" name="name" class="form-control" placeholder="事件/機車/查詢" value="${params.q}">
                </g:form>
              </sec:ifAnyGranted>





        </div>

    </div>

</div>

