<table class="table">
  <tbody>
    <tr>
        <td class="small"><g:message code="eventDetail.name.label" /></td>
        <td class="bold">
          <g:link controller="eventDetail" action="show" id="${eventDetail.id}">${eventDetail.name}</g:link>
        </td>
    </tr>


    <tr>
        <td class="small"><g:message code="eventDetail.price.label" /></td>
        <td class="bold">${eventDetail.price}</td>
    </tr> 

    <tr>
        <td class="small"><g:message code="eventDetail.cost.label" /></td>
        <td class="bold">${eventDetail.cost}</td>
    </tr>

    <tr>
        <td class="small"><g:message code="eventDetail.qty.label" /></td>
        <td class="bold">${eventDetail.qty}</td>
    </tr>
    <tr>
        <td class="small"><g:message code="eventDetail.description.label" /></td>
        <td class="bold">${eventDetail.description}</td>
    </tr>



  </tbody>
</table>