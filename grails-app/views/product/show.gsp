<g:set var="s3Service" bean="s3Service"/>
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

                      
  <div class="row">

    <div class="contact-info col-sm-4 col-md-4">
      <h2>外觀</h2>
      <g:render template="/component/slider" model='[files: s3Service.getObjectList("${grailsApplication.config.grails.aws.root}/${product.name}"), name: product.name]'/>
    </div>
    <div class="contact-info col-sm-4 col-md-4">
      <h2>基本資料</h2>
      <g:render template="content" model="[product: product]" />
    </div>
    <div class="contact-info col-sm-4 col-md-4">
      <h2>車主資料</h2>
      <g:render template="/user/content" model="[user: product.user]" />
    </div>
  </div>

  

  <div class="contact-info" >
    <h2>維修記錄</h2>
    <g:each in="${product.events}" var="event">
      <g:render template="/event/contentDetails" model="[event: event]" />
    </g:each>
  </div>


</body>
</html>
