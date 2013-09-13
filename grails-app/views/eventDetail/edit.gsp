<html>

  <head>
    <title><g:message code="${controllerName}.${actionName}.title"/></title>
  </head>

  <body>
    <g:form action="update" class="form-horizontal">     

      <g:actionbar actionName="${actionName}" domain="${eventDetail}" />
      <div class="bs-docs-example">
        <g:render template="form" />
      </div>
      <g:actionbar actionName="${actionName}" domain="${eventDetail}" />

    </g:form>
  </body>

</html>
