        <g:if test="${event.status == motoranger.ProductStatus.UNFIN}">
          <g:link  
            class="btn btn-success" action="update" controller="event" id="${event.id}" params="[status:motoranger.ProductStatus.END.name()]" >
            <g:message code="ProductStatus.END" />
          </g:link>
        </g:if>
        <g:elseif test="${event.status == motoranger.ProductStatus.END}">
          <g:link  
            class="btn btn-danger" action="update" controller="event" id="${event.id}" params="[status:motoranger.ProductStatus.UNFIN.name()]" >
            <g:message code="ProductStatus.UNFIN" />
          </g:link>
        </g:elseif>