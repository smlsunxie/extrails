
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">

<g:set var="entityName" value="${message(code: 'part.label', default: '文章')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>


</head>
<body>

  <g:if test="${!events}">
      <g:render template="/component/emptyList"/>
  </g:if>

  <g:each in="${events}" var="event" status="i">
    <g:render template='headList' model="[event:event]" />
  </g:each>

	<g:render template="/component/pagination"/>

</body>
</html>
