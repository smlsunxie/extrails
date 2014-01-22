    <table class="table" id="no-more-tables">
      <thead>
        <tr>
          <th><g:message code="eventDetail.name.label" /></th>
          <th><g:message code="part.label" /></th>
          <th><g:message code="part.price.label" /></th>
          <th>&nbsp;</th>

        </tr>
      </thead>

      <g:each in="${event.details}" var="detail" status="j">
        <tbody>        
          
            <tr>
              <td data-title='<g:message code="eventDetail.name.label" />'>
                <g:link controller="eventDetail" action="show" id="${detail?.id}">${detail?.id}</g:link>
              </td>
              <td data-title='<g:message code="part.label" />'>
                <g:link controller="part" action="show" id="${detail?.part.id}">${detail?.part?.title}&nbsp;</g:link>
              </td>
                

              <td data-title='<g:message code="part.price.label" />'>

                <g:if test="${params?.currentUserStoreId == event?.store?.id || params?.currentUserId == event?.user?.id}">
                  <sec:ifAllGranted roles="ROLE_CUSTOMER">  
                    ${detail?.price}*${detail?.qty}=${detail?.price*detail?.qty}
                  </sec:ifAllGranted>
                </g:if>
                &nbsp;

              </td>


              
                <td>
                  <g:if test="${params?.currentUserStoreId == event?.store?.id || params?.currentUserId == event?.user?.id}">
                    <sec:ifAllGranted roles="ROLE_CUSTOMER">  
                      <g:link  class="btn btn-primary btn-xs" controller="eventDetail" action="edit" id="${detail?.id}"><g:message code="default.button.edit.label" /></g:link>
                      <g:link  class="btn btn-danger btn-xs" controller="eventDetail" action="delete" id="${detail?.id}"><g:message code="default.button.delete.label" /></g:link>
                    </sec:ifAllGranted>
                  </g:if>
                  &nbsp;
                </td>
              
 
            </tr>
        </tbody>
      </g:each>


    </table> 