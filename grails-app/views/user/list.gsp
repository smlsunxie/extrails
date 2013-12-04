
<%@ page import="motoranger.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		
		<div id="list-user" class="container" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <div class="row-fluid">
				<table  class="table">
					<thead>
						<tr>
						
							<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" />
						
%{-- 							<g:sortableColumn property="password" title="${message(code: 'user.password.label', default: 'Password')}" />
 --}%						
							<th><g:message code="user.store.label" default="Store" /></th>
						
							<g:sortableColumn property="accountExpired" title="${message(code: 'user.accountExpired.label', default: 'Account Expired')}" />
						
							<g:sortableColumn property="accountLocked" title="${message(code: 'user.accountLocked.label', default: 'Account Locked')}" />
						
							<g:sortableColumn property="address" title="${message(code: 'user.address.label', default: 'Address')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${userInstanceList}" status="i" var="userInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
						
							<td>${fieldValue(bean: userInstance, field: "password")}</td>
						
							<td>${fieldValue(bean: userInstance, field: "store")}</td>
						
							<td><g:formatBoolean boolean="${userInstance.accountExpired}" /></td>
						
							<td><g:formatBoolean boolean="${userInstance.accountLocked}" /></td>
						
							<td>${fieldValue(bean: userInstance, field: "address")}</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${userInstanceTotal}" />
				</div>
			</div>
		</div>
	</body>
</html>
