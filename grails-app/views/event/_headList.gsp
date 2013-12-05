
    <div class="row-fluid">
      <div class="col-sm-12 col-md-12 well well-small">
              
%{--         <g:link controller="eventDetail" action="list" params="[event:event.id]">${event.name}</g:link> --}%
        <sec:ifAnyGranted roles="ROLE_OPERATOR">

          <div class="row-fluid">

            <div class="col-sm-4 col-md-4">
              <g:link class="btn btn-primary btn-large "
                  action="edit" controller="event" id="${event.id}" >
                <g:message code="default.button.edit.label" />
              </g:link>

              <g:link  
                class="btn btn-primary btn-large"
                action="portfolio"
                controller="part"
                params="['event.id':event.id]"  >
                <g:message code="eventDetail.create.label" />   
              </g:link>   

              <g:if test="${event.status == motoranger.ProductStatus.UNFIN}">
               <g:link  
                    class="btn btn-primary btn-large"
                    action="changeStatus"
                    controller="event"
                    id="${event.id}" 
                    params="[status:motoranger.ProductStatus.END.name(), controllerName:controllerName]" >
                  <g:message code="ProductStatus.END" />
                </g:link>
              </g:if> 

              <g:link class="btn btn-danger btn-large pull-right"
                  action="delete" controller="event" id="${event.id}" >
                <g:message code="default.button.delete.label" />
              </g:link> 
            </div>
            

            

            <div class="col-sm-2 col-md-2 offset4">
              <div class="input-prepend input-append">
                <span class="add-on">已收</span>
                  <g:remoteField action="updateReceivedMoney" controller="event" id="${event.id}"
                    name="receivedMoney" onSuccess="onSuccessFun(data)" value="${event?.receivedMoney.toString()}" class="span9" data-for="unreceiveMoney_${event.id}"  /> 
              </div>
            </div>

            <div class="col-sm-2 col-md-2">
              <div class="input-prepend input-append">
                <span class="add-on">未收</span>
                  <input readonly value="${event?.totalPrice-event?.receivedMoney}" class="span9"  id="unreceiveMoney_${event.id}"  type="text" data-initValue="${event?.totalPrice}" /> 

              
              </div>
            </div>

          </div>            
        </sec:ifAnyGranted>

          





        <div class="row-fluid">

          <sec:ifLoggedIn>
            <div class="col-sm-2 col-md-2 well well-small">
              <g:message code="product.name.label" />
              <div class="row-fluid">
                  ${event.product.name}
              </div>
            </div>
          </sec:ifLoggedIn>

          <div class="col-sm-2 col-md-2 well well-small">
            <g:message code="user.username.label" />
            <div class="row-fluid">
                ${event.user.username}
            </div>
          </div>


          <div class="col-sm-2 col-md-2 well well-small">
            <g:message code="event.status.label" />
            <div class="row-fluid">
                <g:message code="ProductStatus.${event.status.name()}" />
            </div>
          </div>

          <div class="col-sm-2 col-md-2 well well-small">
            <g:message code="event.mileage.label" />
            <div class="row-fluid">
              ${event.mileage}
            </div>
          </div>

          <div class="col-sm-2 col-md-2 well well-small">
            <g:message code="event.date.label" />
            <div class="row-fluid">

                <g:formatDate date="${event.date}" type="date" style="SHOROT" />

            </div>
          </div>

            <sec:ifLoggedIn>
              <div class="col-sm-2 col-md-2 well well-small">
                <g:message code="event.totalPrice.label" />
                <div class="row-fluid">
                  ${event?.totalPrice}
                </div>
              </div>

            </sec:ifLoggedIn>

            <div class="row-fluid">
                <g:each in="${event.details}" var="detail" status="i" >
                  <g:render template='/eventDetail/detailList' model="[detail:detail, i:i+1]" />
                </g:each>
            </div>


        </div>

      </div>
    </div>


