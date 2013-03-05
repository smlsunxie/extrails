<html>
  <head>
    <title><g:message code="default.post.create.title"/></title>


  </head>
  <body>

    <header class="jumbotron subhead" id="overview">
        <g:render template="inc_subhead" />
    </header>


    <div class="container-fluid">
        

        <g:form action="save" class="form-horizontal">
          
          <div class="control-group">
              <div class="controls">
                  <g:submitButton name="create"  class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                  <g:link action='list' class="btn">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
              </div>
          </div>

          <div class="bs-docs-example">
            <g:render template="tabs" />
          </div>

        </g:form>

    </div> 

  </body>
</html>
