<table class="table">
  <tbody>

    <tr>
        <td class="small"><g:message code="event.name.label" /></td>
        <td class="bold">
          <g:link controller="event" action="show" id="${eventDetail.head.id}">${eventDetail.head.name}</g:link>
        </td>
    </tr>


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



    <sec:ifAnyGranted roles="ROLE_OPERATOR">
        <tr>
            <td class="small"><g:message code="eventDetail.cost.label" /></td>
            <td class="bold">${eventDetail.cost}</td>
        </tr>
    </sec:ifAnyGranted>


    <tr>
        <td class="small"><g:message code="eventDetail.qty.label" /></td>
        <td class="bold">${eventDetail.qty}</td>
    </tr>
    <tr>
        <td class="small"><g:message code="default.description.label" /></td>
        <td class="bold">${eventDetail.description}</td>
    </tr>



  </tbody>
</table>