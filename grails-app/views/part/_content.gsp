<table class="table">
  <tbody>
    <tr>
        <td class="small"><g:message code="part.name.label" /></td>
        <td class="bold">
          <g:link controller="part" action="show" id="${part.id}">${part.name}</g:link>
        </td>
    </tr>


    <tr>
        <td class="small"><g:message code="part.price.label" /></td>
        <td class="bold">${part.price}</td>
    </tr> 



    <tr>
        <td class="small"><g:message code="part.cost.label" /></td>
        <td class="bold">${part.cost}</td>
    </tr>

    <tr>
        <td class="small"><g:message code="part.description.label" /></td>
        <td class="bold">${part.description}</td>
    </tr>



  </tbody>
</table>