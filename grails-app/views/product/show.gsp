
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${product?.title}</title>
</head>
<body>
  <div class="row show-grid">

      <div class="span12">                        


        <sec:ifAllGranted roles="ROLE_OPERATOR">
          <g:actionbar actionName="${actionName}" domain="${product}" />
        </sec:ifAllGranted>

        <g:render template="content" />

      </div>                                        
  </div>

</body>
</html>
