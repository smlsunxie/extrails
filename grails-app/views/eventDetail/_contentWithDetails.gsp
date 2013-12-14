    <table class="table" id="no-more-tables">
      <thead>
        <tr>
          <th><g:message code="eventDetail.name.label" /></th>
          <th><g:message code="part.label" /></th>
          <th><g:message code="part.price.label" /></th>
          <th><g:message code="default.description.label" /></th>
          <th></th>

        </tr>
      </thead>

      <g:each in="${event.details}" var="detail" status="j">
        <tbody>        
          
            <tr>
              <td data-title='<g:message code="eventDetail.name.label" />'>
                <g:link controller="eventDetail" action="show" id="${detail?.id}">${detail?.name}</g:link>
              </td>
              <td data-title='<g:message code="part.label" />'>
                <g:link controller="part" action="show" id="${detail?.part.id}">${detail?.part?.title}&nbsp;</g:link>
              </td>
                

              <td data-title='<g:message code="part.price.label" />'>
                <sec:ifAllGranted roles="ROLE_MANERGER">  
                  ${detail?.part?.price}*${detail?.qty}=${detail?.part?.price*detail?.qty}
                </sec:ifAllGranted>&nbsp;

              </td>
              <td data-title='<g:message code="default.description.label" />'>${detail?.description}&nbsp;</td>

              <sec:ifAllGranted roles="ROLE_OPERATOR">  
                <td>
                  <g:link  class="btn btn-danger btn-xs" controller="eventDetail" action="delete" id="${detail?.id}"><g:message code="default.button.delete.label" /></g:link>
                </td>
              </sec:ifAllGranted>&nbsp;
 
            </tr>
        </tbody>
      </g:each>


    </table> 