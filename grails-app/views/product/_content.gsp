  <table class="table">
    <tbody>
    <tr>
      <td class="small"><g:message code="product.name.label" /></td>

      <td class="bold"><g:link action="show" controller="product" id="${productInstance.id}">
        ${productInstance.name}
      </g:link></td>

    </tr>

    <tr>
      <td class="small"><g:message code="product.title.label" /></td>
      <td class="bold">${productInstance.title}</td>
    </tr>

    <tr>
      <td class="small"><g:message code="user.title.label" /></td>
      <td class="bold"><g:link action="show" controller="user" id="${productInstance?.user?.id}">${productInstance?.user?.title}</g:link></td>
    </tr>

    <tr>
      <td class="small"><g:message code="product.cc.label" /></td>
      <td class="bold">${productInstance.cc}</td>
    </tr>      
    <tr>
      <td class="small"><g:message code="product.mileage.label" /></td>
      <td class="bold">${productInstance.mileage}</td>
    </tr>
    <tr>
      <td class="small"><g:message code="product.years.label" /></td>
      <td class="bold">${productInstance.years}</td>
    </tr>

    <tr>
      <td class="small"><g:message code="product.price.label" /></td>
      <td class="bold">${productInstance.price}</td>
    </tr>
    <tr>
      <td class="small"><g:message code="product.cost.label" /></td>
      <td class="bold">${(productInstance.cost == -1 ?'****':productInstance.cost)}</td>
    </tr>

    <tr>
      <td class="small"><g:message code="product.totalUnreceiveMoney.label" /></td>
      <td class="bold">${productInstance?.events ? productInstance?.events?.totalPrice?.sum()-productInstance?.events?.receivedMoney?.sum():"0"}</td>
    </tr>


    <tr>
      <td class="small"><g:message code="default.description.label" /></td>
      <td class="bold">${productInstance.description}</td>
    </tr>

    </tbody>

  </table>




  


