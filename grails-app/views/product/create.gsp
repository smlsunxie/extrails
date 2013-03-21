<html>
  <head>
    <title><g:message code="default.part.create.title"/></title>


  </head>
  <body>



      <g:form action="save" class="form-horizontal">        
        <g:submitButton name="save"  class="btn btn-primary btn-mini" value="${message(code: 'default.button.save.label', default: "save")}" />

        <g:link action='list' class="btn btn-mini">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>


          <div class="bs-docs-example">
            <g:render template="setup" />
          </div>

        </g:form>


  </body>
</html>
