<html>
  <head>
    <title><g:message code="${controllerName}.${actionName}.title"/></title>

  </head>
  <body>

    <g:hasErrors bean="${product}">
      <ul class="errors" role="alert">
        <g:eachError bean="${product}" var="error">
          <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
        </g:eachError>
      </ul>
    </g:hasErrors>

    <g:form action="update" class="form-horizontal">        
      
      <g:actionbar actionName="${actionName}" domain="${product}" />
      
      <div class="bs-docs-example">
        <g:render template="form" />
      </div>
      
      <g:actionbar actionName="${actionName}" domain="${product}" />
    </g:form>


  </body>
</html>
