<html>
  <head>
    <title><g:message code="${controllerName}.${actionName}.title"/></title>

  </head>
  <body>

    <g:form action="save" class="form-horizontal">        


      <g:actionbar actionName="${actionName}" domain="${post}" />

      <div class="bs-docs-example">
        <g:render template="tabs" />
      </div>

    </g:form>

  </body>
</html>
