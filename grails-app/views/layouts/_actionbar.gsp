
<g:if test="${actionName=='create' ||actionName=='edit' }" >
	<g:submitButton name="${nextActionName}"  class="btn btn-primary btn-mini" value="${message(code: 'default.button.${nextActionName}.label', default: nextActionName)}" />

	<g:link action='list' class="btn btn-mini">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
</g:if >  
<g:elseif test="${actionName=='show'}" >
	
  <g:link  class="btn btn-primary btn-mini"  action="edit" id="${domain?.id}"><g:message code="default.button.edit.label" /></g:link>
  <g:link  class="btn btn-danger btn-mini" action="delete" id="${domain?.id}"><g:message code="default.button.delete.label" /></g:link>

</g:elseif >  