        <g:if test="${event.status == motoranger.ProductStatus.UNFIN}">
          <g:link  
            class="btn btn-primary" action="update" controller="event" id="${event.id}" params="[status:motoranger.ProductStatus.END.name(), controllerName:controllerName]" >
            <g:message code="ProductStatus.END" />
          </g:link>
        </g:if>
        <g:elseif test="${event.status == motoranger.ProductStatus.END}">
          <g:link  
            class="btn btn-primary" action="update" controller="event" id="${event.id}" params="[status:motoranger.ProductStatus.UNFIN.name()]" >
            <g:message code="ProductStatus.UNFIN" />
          </g:link>
        </g:elseif>