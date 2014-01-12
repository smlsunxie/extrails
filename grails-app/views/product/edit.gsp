<html>
  <head>
    <title><g:message code="${controllerName}.${actionName}.title"/></title>

  </head>
  <body>

    <g:form action="update" class="form-horizontal">        
      
      <g:submitButton name="update"  class="btn btn-primary btn-large" value="${message(code: 'default.button.update.label', default: 'update')}" />

      <g:link action='show' id="${product.id}" class="btn">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
      
      <div class="bs-docs-example">
        <g:render template="form" />
      </div>
      

      <g:submitButton name="update"  class="btn btn-primary btn-large" value="${message(code: 'default.button.update.label', default: 'update')}" />
      
      <g:link action='show' id="${product.id}" class="btn">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>

    </g:form>


  </body>
</html>
