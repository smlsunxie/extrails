  <table class="table">
    <tbody>
    <tr>
      <td class="small"><g:message code="product.name.label" /></td>

      <td class="bold"><g:link action="show" controller="product" id="${product.id}">
        ${product.name}
      </g:link></td>

    </tr>

    <tr>
      <td class="small"><g:message code="product.title.label" /></td>
      <td class="bold">${product.title}</td>
    </tr>

    <tr>
      <td class="small"><g:message code="user.title.label" /></td>
      <td class="bold"><g:link action="show" controller="user" id="${product?.user?.id}">${product?.user?.title}</g:link></td>
    </tr>

    <tr>
      <td class="small"><g:message code="product.cc.label" /></td>
      <td class="bold">${product.cc}</td>
    </tr>      
    <tr>
      <td class="small"><g:message code="product.mileage.label" /></td>
      <td class="bold">${product.mileage}</td>
    </tr>
    <tr>
      <td class="small"><g:message code="product.years.label" /></td>
      <td class="bold">${product.years}</td>
    </tr>

    <tr>
      <td class="small"><g:message code="product.price.label" /></td>
      <td class="bold">${product.price}</td>
    </tr>
    <tr>
      <td class="small"><g:message code="product.cost.label" /></td>
      <td class="bold">${product.cost}</td>
    </tr>

    <tr>
      <td class="small"><g:message code="product.totalUnreceiveMoney.label" /></td>
      <td class="bold">${product?.events ? product?.events?.totalPrice?.sum()-product?.events?.receivedMoney?.sum():"0"}</td>
    </tr>


    <tr>
      <td class="small"><g:message code="default.description.label" /></td>
      <td class="bold">${product.description}</td>
    </tr>

    </tbody>

  </table>




  


