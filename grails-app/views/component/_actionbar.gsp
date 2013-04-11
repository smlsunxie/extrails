
<g:if test="${actionName=='create' ||actionName=='save' ||actionName=='edit' }" >
	<g:submitButton name="${nextActionName}"  class="btn btn-primary btn-large" value="${message(code: 'default.button.${nextActionName}.label', default: nextActionName)}" />

	<g:link action='list' class="btn btn-large">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
</g:if >  
<g:elseif test="${actionName=='show'}" >
	
  <g:link  class="btn btn-primary btn-large"  action="edit" id="${domain?.id}"><g:message code="default.button.edit.label" /></g:link>
  <g:link  class="btn btn-danger btn-large pull-right" action="delete" id="${domain?.id}"><g:message code="default.button.delete.label" /></g:link>

</g:elseif >  