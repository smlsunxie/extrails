<html>
  <head>
    <title><g:message code="${controllerName}.${actionName}.title"/></title>

  </head>
  <body>

    <g:form action="update" id="${post?.id}" params="[version:post?.version]" class="form-horizontal">


      <g:btnbar actionName="${actionName}" domain="${post}" />

      <div class="bs-docs-example">
        <g:render template="tabs" />
      </div>

    </g:form>
  </body>
</html>
