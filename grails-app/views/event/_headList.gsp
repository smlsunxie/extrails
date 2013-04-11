
    <div class="row-fluid">
      <div class="span12 well well-small">
              
%{--         <g:link controller="eventDetail" action="list" params="[event:event.id]">${event.name}</g:link> --}%
        <sec:ifAnyGranted roles="ROLE_OPERATOR">
          <g:link class="btn btn-danger btn-large pull-right"
              action="delete" controller="event" id="${event.id}" >
            <g:message code="default.button.delete.label" />
          </g:link> 
          <g:link class="btn btn-primary btn-large "
              action="edit" controller="event" id="${event.id}" >
            <g:message code="default.button.edit.label" />
          </g:link>
          <g:link  
            class="btn btn-primary btn-large"
            action="portfolio"
            controller="part"
            params="[event:event.id]"  >
          <g:message code="eventDetail.create.label" />
        </g:link>                
        </sec:ifAnyGranted>

        <g:if test="${event.status == extrails.ProductStatus.UNFIN}">

         <g:link  
              class="btn btn-primary btn-large"
              action="changeStatus"
              controller="event"
              id="${event.id}" 
              params="[status:extrails.ProductStatus.END.name(), controllerName:controllerName]" >
            <g:message code="ProductStatus.END" />
          </g:link>

        </g:if>





        <div class="row-fluid">

          <sec:ifLoggedIn>
            <div class="span2 well well-small">
              <g:message code="product.name.label" />
              <div class="row-fluid">
                  ${event.product.name}
              </div>
            </div>
          </sec:ifLoggedIn>

          <div class="span2 well well-small">
            <g:message code="user.username.label" />
            <div class="row-fluid">
                ${event.user.username}
            </div>
          </div>


          <div class="span2 well well-small">
            <g:message code="event.status.label" />
            <div class="row-fluid">
                <g:message code="ProductStatus.${event.status.name()}" />
            </div>
          </div>

          <div class="span2 well well-small">
            <g:message code="event.mileage.label" />
            <div class="row-fluid">
              ${event.mileage}
            </div>
          </div>

          <div class="span2 well well-small">
            <g:message code="event.date.label" />
            <div class="row-fluid">

                <g:formatDate date="${event.date}" type="date" style="SHOROT" />

            </div>
          </div>

            <sec:ifLoggedIn>
              <div class="span2 well well-small">
                <g:message code="event.totalPrice.label" />
                <div class="row-fluid">
                  <event:totalPrice event="${event}" />
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
