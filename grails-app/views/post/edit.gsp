<html>
  <head>
    <title><g:message code="post.edit.title" defualt="修改文章"/></title>


  </head>
  <body>

    <g:form action="update" id="${post?.id}" params="[version:post?.version]" class="form-horizontal">


      <g:submitButton name="update"  class="btn btn-primary btn-mini" value="${message(code: 'default.button.update.label', default: "update")}" />

      <g:link action='list' class="btn btn-mini">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>

      <div class="bs-docs-example">
        <g:render template="tabs" />
      </div>

    </g:form>
  </body>
</html>
