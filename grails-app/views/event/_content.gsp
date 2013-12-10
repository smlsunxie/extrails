<table class="table">
  <tbody>
    <tr>
        <td class="small"><g:message code="event.name.label" /></td>
        <td class="bold">
          <g:link controller="event" action="show" id="${event.id}">${event.name}</g:link>
        </td>
    </tr>


    <tr>
        <td class="small"><g:message code="event.mileage.label" /></td>
        <td class="bold">${event.mileage}</td>
    </tr> 



    <tr>
        <td class="small"><g:message code="event.store.label" /></td>
        <td class="bold">${event.store}</td>
    </tr>



    <g:if test = "${actionName != 'pickPartAddDetail'}">
      <tr>
          <td class="small"><g:message code="user.title.label" /></td>
          <td class="bold">${event?.user}</td>
      </tr> 
      <tr>
          <td class="small"><g:message code="event.status.label" /></td>
          <td class="bold"><g:message code="ProductStatus.${event.status.name()}" /></td>
      </tr>
      <tr>
          <td class="small">已收</td>
          <td class="bold">${event?.receivedMoney.toString()}</td>
      </tr> 
      <tr>
          <td class="small">未收</td>
          <td class="bold">${event?.totalPrice-event?.receivedMoney}</td>
      </tr> 
    </g:if>

    
    <tr>
      <td class="small"><g:message code="event.totalPrice.label" /></td>
      <td class="bold">${event?.totalPrice}</td>
    </tr>
    <tr>
        <td class="small"><g:message code="default.dateCreated.label" /></td>
        <td class="bold">
          <g:formatDate date="${event.date}" type="date" style="SHOROT" />
        </td>
    </tr> 



  </tbody>
</table>