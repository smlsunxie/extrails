<table class="table">
  <tbody>


    <tr>
        <td class="small"><g:message code="event.mileage.label" /></td>
        <td class="bold">${event.mileage}</td>
    </tr> 

    
      <g:if test = "${actionName != 'pickPartAddDetail' && params?.currentUserStoreId == event?.store?.id }">

        <sec:ifAnyGranted roles="ROLE_OPERATOR">
          <tr>
              <td class="small">已收</td>
              <td class="bold">${event?.receivedMoney.toString()}</td>
          </tr> 
          <tr>
              <td class="small">未收</td>
              <td class="bold">${event?.totalPrice-event?.receivedMoney}</td>
          </tr> 
        </sec:ifAnyGranted>
        
      </g:if>


    <g:if test="${params?.currentUserStoreId == event?.store?.id || params?.currentUserId == event?.user?.id}">

      <sec:ifAnyGranted roles="ROLE_CUSTOMER">
        <tr>
          <td class="small"><g:message code="event.totalPrice.label" /></td>
          <td class="bold">${event?.totalPrice}</td>
        </tr>
      </sec:ifAnyGranted>

    </g:if>

    <tr>
        <td class="small"><g:message code="event.store.label" /></td>
        <td class="bold">
          <g:link controller="store" action="show" id="${event?.store.id}">${event?.store}</g:link>

        </td>
    </tr>

    
    <tr>
        <td class="small"><g:message code="default.dateCreated.label" /></td>
        <td class="bold">
          <g:formatDate date="${event.date}" type="date" style="SHOROT" />
        </td>
    </tr> 



  </tbody>
</table>