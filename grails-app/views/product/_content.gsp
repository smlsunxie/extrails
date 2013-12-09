    <table class="table">
      <tbody>
        <tr>
            <td class="small"><g:message code="product.title.label" /></td>
            <td class="bold"><g:link action="show" controller="product" id="${product.id}">${product.title}</g:link></td>
        </tr> 
        <tr>
            <td class="small"><g:message code="product.cc.label" /></td>
            <td class="bold">${product.cc}</td>
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
            <td class="bold">${product?.events.totalPrice.sum()-product?.events.receivedMoney.sum()}</td>
        </tr>
        <tr>
            <td class="small"><g:message code="product.description.label" /></td>
            <td class="bold">${product.description}</td>
        </tr>

      </tbody>

    </table>




    


