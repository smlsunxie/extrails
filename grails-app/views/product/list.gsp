
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">

<g:set var="entityName" value="${message(code: 'product.label', default: '文章')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>


</head>
<body>

	
	<!-- 如果沒有文章，顯示空白 -->
	<g:if test="${!products}">
		<div class="row-fluid">
				<div class="span12">
					<div style="text-align:center"><g:message code="default.empty.description" /></div>
				</div>
		</div>
	</g:if>

	<g:each in="${products}" var="product" status="i">
		<g:render template="record" model="[product:product]"/>
	</g:each>

	<g:render template="/component/pagination"/>

</body>
</html>
