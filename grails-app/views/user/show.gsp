<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${product?.title}</title>
</head>
<body>


  <div class="row" id="actionbar">

    <div class="col-sm-12 col-md-12">           

      <g:link  class="btn btn-primary"  action="edit" id="${user?.id}"><g:message code="default.button.edit.label" /></g:link>

      <sec:ifAnyGranted roles="ROLE_ADMIN">  
        <g:link  class="btn btn-primary" controller="store" action="create" params="['user.id': user.id]">新增店家</g:link>
      </sec:ifAnyGranted>

      <sec:ifAnyGranted roles="ROLE_OPERATOR, ROLE_MANERGER, ROLE_CUSTOMER">  
        <g:link  class="btn btn-primary" controller="product" action="create" params="['user.id': user.id]">新增產品</g:link>
      </sec:ifAnyGranted>

      <sec:ifAnyGranted roles="ROLE_CUSTOMER">          
        <g:link  class="btn btn-primary" controller="part" action="create" params="['user.id': user.id]">新增零件</g:link>
      </sec:ifAnyGranted>

      <g:link  class="btn btn-danger" action="delete" id="${user?.id}"><g:message code="default.button.delete.label" /></g:link>

    </div>

  </div>




  <div class="row show-grid features-block mini-blocks">
    <div class="contact-info col-sm-8 col-md-8">
      <h2>車主資料</h2>
      <g:render template="/user/content" model="[user: user]" />
    </div>

    <g:each in="${products}" var="product" status="i" >



      <div class="contact-info col-sm-4 col-md-4 block2">
        <div class="mini-wrapper">

          <g:render template="/product/content" model="[product: product]" />

        </div>
      </div>


    </g:each>
  </div>





</body>
</html>