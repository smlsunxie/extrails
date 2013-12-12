
<g:if test="${user}">
	<table class="table">
	  <tbody>
		<tr>
			<td class="small"><g:message code="user.title.label" /></td>
			<td class="bold"><g:link controller="user" action="show" id="${user.id}" >${user.username}</g:link></td>

		</tr> 
		<tr>
			<td class="small"><g:message code="user.title.label" /></td>
			<td class="bold">${user.title}</td>

		</tr> 
		<tr>
			<td class="small"><g:message code="user.telphone.label" /></td>
			<td class="bold">${user.telphone}</td>
		</tr> 
		<tr>
			<td class="small"><g:message code="user.mobile.label" /></td>
			<td class="bold">${user.mobile}</td>
		</tr>      
		<tr>
			<td class="small"><g:message code="user.description.label" /></td>
			<td class="bold">${user.description}</td>
		</tr>

	  </tbody>

	</table>
</g:if>
<g:elseif test="${product}">
	<div class="text-center">
		<g:link  class="btn btn-primary" controller="user" action="create" params="['product.id':product?.id]">
			<g:message code="product.user.create.label" />
		</g:link>
	</div>
</g:elseif>