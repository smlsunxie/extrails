<%@ page import="extrails.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${userInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${userInstance?.password}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'store', 'error')} ">
	<label for="store">
		<g:message code="user.store.label" default="Store" />
		
	</label>
	<g:select id="store" name="store.id" from="${storeList}" optionKey="id" value="${userInstance?.store?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>


%{-- <sec:ifAnyGranted roles="ROLE_ADMIN">
	<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'storeOwner', 'error')} ">
		<label for="storeOwner">
			<g:message code="user.storeOwner.label" default="Store Owner" />
			
		</label>
		<g:checkBox name="storeOwner" value="${userInstance?.storeOwner}" />
	</div>
</sec:ifAnyGranted> --}%

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountExpired', 'error')} ">
	<label for="accountExpired">
		<g:message code="user.accountExpired.label" default="Account Expired" />
		
	</label>
	<g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountLocked', 'error')} ">
	<label for="accountLocked">
		<g:message code="user.accountLocked.label" default="Account Locked" />
		
	</label>
	<g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'address', 'error')} ">
	<label for="address">
		<g:message code="user.address.label" default="Address" />
		
	</label>
	<g:textField name="address" value="${userInstance?.address}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="user.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${userInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} ">
	<label for="email">
		<g:message code="user.email.label" default="Email" />
		
	</label>
	<g:textField name="email" value="${userInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
		
	</label>
	<g:checkBox name="enabled" value="${userInstance?.enabled}" />
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'mobile', 'error')} ">
	<label for="mobile">
		<g:message code="user.mobile.label" default="Mobile" />
		
	</label>
	<g:textField name="mobile" value="${userInstance?.mobile}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')} ">
	<label for="passwordExpired">
		<g:message code="user.passwordExpired.label" default="Password Expired" />
		
	</label>
	<g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'telphone', 'error')} ">
	<label for="telphone">
		<g:message code="user.telphone.label" default="Telphone" />
		
	</label>
	<g:textField name="telphone" value="${userInstance?.telphone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="user.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${userInstance?.title}"/>
</div>




<sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_ADMIN">
	<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'title', 'error')} ">
		<label for="title">
			<g:message code="role.authority.label" default="authority" />
			
		</label>

	    <table class="table">

	        <tbody>
	            <g:each in="${roles}" var="role" status="i">

	                <tr>

	                    <td><g:checkBox name="userRoles" value="${role.authority}" checked="${userRoles?.role?.contains(role)}" /></td>
	                    <td>${role.authority}</td>

	                  </tr>

	            </g:each>

	        </tbody>
	    </table>                    
	</div>
</sec:ifAnyGranted>




