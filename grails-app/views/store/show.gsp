
<%@ page import="extrails.Store" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'store.label', default: 'Store')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-store" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list store">
			
				<g:if test="${storeInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="store.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${storeInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.mobile}">
				<li class="fieldcontain">
					<span id="mobile-label" class="property-label"><g:message code="store.mobile.label" default="Mobile" /></span>
					
						<span class="property-value" aria-labelledby="mobile-label"><g:fieldValue bean="${storeInstance}" field="mobile"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.address}">
				<li class="fieldcontain">
					<span id="address-label" class="property-label"><g:message code="store.address.label" default="Address" /></span>
					
						<span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${storeInstance}" field="address"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.telphone}">
				<li class="fieldcontain">
					<span id="telphone-label" class="property-label"><g:message code="store.telphone.label" default="Telphone" /></span>
					
						<span class="property-value" aria-labelledby="telphone-label"><g:fieldValue bean="${storeInstance}" field="telphone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="store.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${storeInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${storeInstance?.users}">
				<li class="fieldcontain">
					<span id="users-label" class="property-label"><g:message code="store.users.label" default="Users" /></span>
					
						<g:each in="${storeInstance.users}" var="u">
						<span class="property-value" aria-labelledby="users-label"><g:link controller="user" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${storeInstance?.id}" />
					<g:link class="btn btn-primary" action="edit" id="${storeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
