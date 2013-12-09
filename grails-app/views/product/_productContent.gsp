
<div class="row">

  <div class="contact-info col-sm-4 col-md-4">
    <h2>外觀</h2>
    <g:render template="/component/slider" model="[files:files,name:product.name]"/>
  </div>
  <div class="contact-info col-sm-4 col-md-4">
    <h2>基本資料</h2>
    <table class="table">
      <tbody>
        <tr>
            <td class="small"><g:message code="product.title.label" /></td>
            <td class="bold">${product.title}</td>
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
            <td class="small"><g:message code="product.description.label" /></td>
            <td class="bold">${product.description}</td>
        </tr>
      </tbody>

    </table>
  </div>
  <sec:ifAnyGranted roles="ROLE_OPERATOR">
      <div class="contact-info col-sm-4 col-md-4">
        <h2>車主資料</h2>
        <table class="table">
          <tbody>
            <tr>
                <td class="small"><g:message code="user.title.label" /></td>
                <td class="bold"><g:link controller="user" action="show">${product.user.title}</g:link></td>

            </tr> 
            <tr>
                <td class="small"><g:message code="user.telphone.label" /></td>
                <td class="bold">${product.user.telphone}</td>
            </tr> 
            <tr>
                <td class="small"><g:message code="user.mobile.label" /></td>
                <td class="bold">${product.user.mobile}</td>
            </tr>      
            <tr>
                <td class="small"><g:message code="user.description.label" /></td>
                <td class="bold">${product.user.description}</td>
            </tr>
            <tr>
                <td class="small"><g:message code="product.totalUnreceiveMoney.label" /></td>
                <td class="bold">${product?.events.totalPrice.sum()-product?.events.receivedMoney.sum()}</td>
            </tr>

          </tbody>

        </table>
      </div>
  </sec:ifAnyGranted>

</div>





    


