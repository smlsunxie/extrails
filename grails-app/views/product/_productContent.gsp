
<div class="row">

  <div class="contact-info col-sm-6 col-md-6">
    <h2>外觀</h2>
    <g:render template="/component/slider" model="[files:files,name:product.name]"/>
  </div>
  <div class="contact-info col-sm-6 col-md-6">
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
</div>

  %{--     <sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_OPERATOR">
        
        <g:link controller="product" action="show" id="${product?.id}" class="btn btn-primary btn-mini">產品資料</g:link>

        <g:link class="btn btn-primary btn-mini" controller="event" action="list" params="['product.id':product?.id]">維修記錄</g:link>
        
        <g:link class="btn btn-primary btn-mini" controller="event" action="create" params="['product.id':product?.id]">新增維修</g:link>
        
        <g:if test="${product?.status.name() == "UNFIN"}"> 
          <g:link class="btn btn-primary btn-mini" action="changeStatusEnd" id="${product.id}" params="[status:motoranger.ProductStatus.END.name()]">維修結束</g:link>
        </g:if>

      </sec:ifAnyGranted> --}%

<sec:ifAnyGranted roles="ROLE_OPERATOR">
  <div class="row">

    <div class="contact-info col-sm-12 col-md-12">
      <h2>車主資料</h2>
      <table class="table" id="no-more-tables">
        <thead>
          <tr>
            <th><g:message code="user.title.label" /></th>
            
            
            <th><g:message code="user.telphone.label" /></th>
            <th><g:message code="user.mobile.label" /></th>
            <th><g:message code="user.description.label" /></th>
            <th><g:message code="product.totalUnreceiveMoney.label" /></th>


          </tr>
        </thead>    
          
        <tbody>
          <tr>
              <td class="bold" data-title='<g:message code="user.title.label" />'>
                <g:link controller="user" action="show">${product.user.title}</g:link></td>
              

              <td class="bold" data-title='<g:message code="user.telphone.label" />'>${product.user.telphone}&nbsp;</td>
              <td class="bold" data-title='<g:message code="user.mobile.label" />'>${product.user.mobile}&nbsp;</td>
              <td class="bold" data-title='<g:message code="user.description.label" />'>${product.user.description}&nbsp;</td>
              <td class="bold" data-title='<g:message code="product.totalUnreceiveMoney.label" />'>${product?.events.totalPrice.sum()-product?.events.receivedMoney.sum()}</td>
          </tr> 

        </tbody>

      </table>
    </div>
  </div>
</sec:ifAnyGranted>


    


