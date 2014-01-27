<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${product?.title}</title>
</head>
<body>

  <sec:ifAnyGranted roles="ROLE_CUSTOMER, ROLE_OPERATOR, ROLE_MANERGER">
    <div class="row" id="actionbar">

      <div class="col-sm-12 col-md-12">           

          <g:link  class="btn btn-primary"  action="edit" id="${productInstance?.id}"><g:message code="default.button.edit.label" /></g:link>


          <g:link  class="btn btn-danger" action="delete" id="${productInstance?.id}"><g:message code="default.button.delete.label" /></g:link>

      </div>

    </div>
  </sec:ifAnyGranted>



                      
  <g:render template="contentWithDetails" model="[product: productInstance]" />

  
  <br />

  <div class="contact-info" >
    <h2>維修記錄</h2>

    <sec:ifAnyGranted roles="ROLE_CUSTOMER, ROLE_OPERATOR, ROLE_MANERGER">

      <g:if test="${statusEnd}">
        <div id="actionbar" class="text-center">
          <g:link  class="btn btn-primary" controller="event" action="create" params="['product.id':productInstance?.id]">
            新增維修記錄
          </g:link>
        </div>
      </g:if>

    </sec:ifAnyGranted>

    <g:render template="/event/contentWithDetails" collection="${productInstance?.events}" var="event" />
  </div>


</body>
</html>
