<html>
  <head>
    <title><g:message code="part.edit.title"/></title>


  </head>
  <body>


    <div class="container">

        <g:form action="update" class="form-horizontal">        
           <div class="row show-frid">
              <div class="span12">
                  <div id="breadcrumb">
                        <ul >
                          <li class="home btn btn-mini btn-link">posts</li>
                          <li ><g:submitButton name="update"  class="btn btn-primary btn-mini" value="${message(code: 'default.button.update.label', default: '更新')}" /></li>
                          <li><g:link action='list' class="btn btn-mini">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link></li>
                            
                        </ul>
                  </div>
              </div>
          </div>




          <div class="bs-docs-example">
            <g:render template="setup" />
          </div>

        </g:form>

    </div> 

  </body>
</html>
