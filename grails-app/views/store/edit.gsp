<%@ page import="motoranger.Store" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
  </head>
  <body>

    
    <div id="edit-store" class="content scaffold-edit" role="main">
      <h1><g:message code="default.edit.label" args="[entityName]" /></h1>


      <g:hasErrors bean="${storeInstance}">
      <ul class="errors" role="alert">
        <g:eachError bean="${storeInstance}" var="error">
        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
        </g:eachError>
      </ul>
      </g:hasErrors>


      <g:form method="post" action="update" >

        <g:actionbar actionName="${actionName}" domain="${storeInstance}" />
      

      


        <g:hiddenField name="id" value="${storeInstance?.id}" />
        <g:hiddenField name="version" value="${storeInstance?.version}" />
        <fieldset class="form">
          <g:render template="form"/>
        </fieldset>




        <g:actionbar actionName="${actionName}" domain="${storeInstance}" />
      </g:form>


    </div>
  </body>
</html>
