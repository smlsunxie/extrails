
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">

<g:set var="entityName" value="${message(code: 'post.label', default: '文章')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>


</head>
<body>

  <div class="contact-info" >
    <h2>今日維修完成</h2>


    <g:render template="/event/contentWithDetails" collection="${results}" var="event" />
  </div>



</body>
</html>
