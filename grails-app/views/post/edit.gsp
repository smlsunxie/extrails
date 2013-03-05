<html>
  <head>
    <title><g:message code="post.edit.title" defualt="修改文章"/></title>


  </head>
  <body>

    <header class="jumbotron subhead" id="overview">
        <g:render template="inc_subhead" />
    </header>


    <div class="container-fluid">
      <g:form action="update/${post?.id}/${post?.version}" class="form-horizontal">
        
        <div class="control-group">
          <div class="controls">
            <g:submitButton name="update" class="btn btn-primary" value="${message(code: 'default.button.update.label', default: '更新')}" />
            <g:link class="btn">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
          </div>
        </div>

        <div class="bs-docs-example">
          <g:render template="tabs" />
        </div>

      </g:form>
    </div> 





  </body>
</html>
