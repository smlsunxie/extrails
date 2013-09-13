<html>
  <head>
    <title><g:message code="${controllerName}.${actionName}.title"/></title>
  </head>
  <body>

    <g:form action="save" class="form-horizontal">  
      
      <g:actionbar actionName="${actionName}" domain="${part}" />
      <div class="bs-docs-example">
        <g:render template="form" />
      </div>
      <g:actionbar actionName="${actionName}" domain="${part}" />

    </g:form>

  </body>
</html>
