<html>
  <head>
    <title><g:message code="${controllerName}.${actionName}.title"/></title>

  </head>
  <body>



    <g:form action="save" class="form-horizontal">        
      <g:btnbar actionName="${actionName}" domain="${product}" />


      <div class="bs-docs-example">
        <g:render template="setup" />
      </div>

      </g:form>


  </body>
</html>
