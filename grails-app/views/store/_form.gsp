<%@ page import="extrails.Store" %>



<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="store.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${storeInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'mobile', 'error')} ">
	<label for="mobile">
		<g:message code="store.mobile.label" default="Mobile" />
		
	</label>
	<g:textField name="mobile" value="${storeInstance?.mobile}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'address', 'error')} ">
	<label for="address">
		<g:message code="store.address.label" default="Address" />
		
	</label>
	<g:textField name="address" value="${storeInstance?.address}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'telphone', 'error')} ">
	<label for="telphone">
		<g:message code="store.telphone.label" default="Telphone" />
		
	</label>
	<g:textField name="telphone" value="${storeInstance?.telphone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="store.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${storeInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: storeInstance, field: 'users', 'error')} ">
	<label for="users">
		<g:message code="store.users.label" default="Users" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${storeInstance?.users?}" var="u">
    <li><g:link controller="user" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="user" action="create" params="['store.id': storeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'user.label', default: 'User')])}</g:link>
</li>
</ul>

</div>

