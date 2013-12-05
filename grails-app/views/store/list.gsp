
<%@ page import="motoranger.Store" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		
		<div id="list-store" class="container" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <div class="row">
				<table  class="table">
					<thead>
						<tr>
						
							<g:sortableColumn property="name" title="${message(code: 'store.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="mobile" title="${message(code: 'store.mobile.label', default: 'Mobile')}" />
						
							<g:sortableColumn property="address" title="${message(code: 'store.address.label', default: 'Address')}" />
						
							<g:sortableColumn property="telphone" title="${message(code: 'store.telphone.label', default: 'Telphone')}" />
						
							<g:sortableColumn property="title" title="${message(code: 'store.title.label', default: 'Title')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${storeInstanceList}" status="i" var="storeInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${storeInstance.id}">${fieldValue(bean: storeInstance, field: "name")}</g:link></td>
						
							<td>${fieldValue(bean: storeInstance, field: "mobile")}</td>
						
							<td>${fieldValue(bean: storeInstance, field: "address")}</td>
						
							<td>${fieldValue(bean: storeInstance, field: "telphone")}</td>
						
							<td>${fieldValue(bean: storeInstance, field: "title")}</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${storeInstanceTotal}" />
				</div>
			</div>
		</div>
	</body>
</html>
