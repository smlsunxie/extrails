<g:set var="s3Service" bean="s3Service"/>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${product?.title}</title>
</head>
<body>

    <div class="btn-group" id="actionbar">
           

      <sec:ifAnyGranted roles="ROLE_CUSTOMER">          
        <g:link  class="btn btn-primary" controller="part" action="create">新增維修項目</g:link>
      </sec:ifAnyGranted>


    </div>
	<g:render template="portfolio" model="[tag: tag]" />

</body>
</html>
