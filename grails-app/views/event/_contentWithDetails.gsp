<div class="row">
  <div class="contact-info col-sm-3 col-md-3">  
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

        <tr>
            <td class="small"><g:message code="event.totalPrice.label" /></td>
            <td class="bold">${event?.totalPrice}</td>
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
          <tr>
              <td class="small"><g:message code="default.dateCreated.label" /></td>
              <td class="bold">
                <g:formatDate date="${event.date}" type="date" style="SHOROT" />
              </td>
          </tr> 
        </g:if>


      </tbody>
    </table>
  </div>

  <div class="contact-info col-sm-9 col-md-9">  
    <table class="table" id="no-more-tables">
      <thead>
        <tr>
          <th><g:message code="eventDetail.label" /></th>
          <th><g:message code="part.label" /></th>
          <th><g:message code="part.price.label" /></th>

        </tr>
      </thead>

      <g:each in="${event.details}" var="detail" status="j">
        <tbody>        
          
            <tr>
              <td data-title='<g:message code="eventDetail.name.label" />'>
                <g:link controller="eventDetail" action="show" id="${detail?.id}">${detail?.name}</g:link>
              </td>
              <td data-title='<g:message code="part.label" />'>
                <g:link controller="part" action="show" id="${detail?.part.id}">${detail?.part?.title}</g:link>
              </td>
              <td data-title='<g:message code="part.price.label" />'>${detail?.part?.price}*${detail?.qty}=${detail?.part?.price*detail?.qty}</td>
            </tr>
          
          
        </tbody>
      </g:each>


    </table> 
  </div>
</div>