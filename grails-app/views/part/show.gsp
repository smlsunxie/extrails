<g:set var="s3Service" bean="s3Service"/>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${part?.title}</title>
</head>
<body>
  <sec:ifAllGranted roles="ROLE_CUSTOMER">
    <div class="row" id="actionbar">

      <div class="col-sm-12 col-md-12">           

          <g:link  class="btn btn-primary"  action="edit" id="${part?.id}"><g:message code="default.button.edit.label" /></g:link>

          <g:link  class="btn btn-danger" action="delete" id="${part?.id}"><g:message code="default.button.delete.label" /></g:link>

      </div>

    </div>
  </sec:ifAllGranted>
  <div class="row">

    <div class="contact-info col-sm-4 col-md-4">
      <h2>外觀</h2>
      <g:render template="/component/slider" model='[files: s3Service.getObjectList("${grailsApplication.config.grails.aws.root}/${part.name}"), name: part.name]'/>
    </div>
    <div class="contact-info col-sm-8 col-md-8">
      <h2>維修項目</h2>
      <g:render template="content" model="[part: part]" />
    </div>

  </div>
</body>
</html>
