<!DOCTYPE html>
<html>

  <head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'store.label', default: 'store')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
  </head>

  <body>
    <g:render template="/component/formEdit" model="[domainName: 'store', domainId: storeInstance.id]"/>
  </body>

</html>
