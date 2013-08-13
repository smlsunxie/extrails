<%@ page import="extrails.Brand" %>



<div class="fieldcontain ${hasErrors(bean: brandInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="brand.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${brandInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: brandInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="brand.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${brandInstance?.title}"/>
</div>

