<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${product?.title}</title>
</head>
<body>

  <sec:ifAllGranted roles="ROLE_OPERATOR">
    <div class="row" id="actionbar">

      <div class="col-sm-12 col-md-12">           

          <g:link  class="btn btn-primary"  action="edit" id="${product?.id}"><g:message code="default.button.edit.label" /></g:link>

          <g:link  class="btn btn-primary" controller="event" action="create" params="['product.id': product.id]">新增維修記錄</g:link>

          <g:link  class="btn btn-danger" action="delete" id="${product?.id}"><g:message code="default.button.delete.label" /></g:link>

      </div>

    </div>
  </sec:ifAllGranted>

                      
  <g:render template="contentWithDetails" model="[product: product]" />

  

  <div class="contact-info" >
    <h2>維修記錄</h2>
    <g:render template="/event/contentWithDetails" collection="${product.events}" var="event" />
  </div>


</body>
</html>
