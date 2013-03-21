<html>
  <head>
    <title><g:message code="part.edit.title"/></title>


  </head>
  <body>



    <g:form action="update" class="form-horizontal">        

      <g:submitButton name="update"  class="btn btn-primary btn-mini" value="${message(code: 'default.button.update.label', default: "update")}" />

      <g:link action='list' class="btn btn-mini">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
      
      <div class="bs-docs-example">
        <g:render template="setup" />
      </div>

    </g:form>


  </body>
</html>
