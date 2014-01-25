
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">

<title>${event}</title>


</head>
<body>



    <div class="row" id="actionbar">

      <g:if test="${currentUserIsEventOwner[event.id]}">
        <sec:ifAnyGranted roles="ROLE_CUSTOMER, ROLE_OPERATOR, ROLE_MANERGER">
          <div class="col-sm-3 col-md-3">
            <g:link class="btn btn-primary btn-large "
              action="edit" controller="event" id="${event.id}" >
            <g:message code="default.button.edit.label" />
            </g:link>  



            <g:link class="btn btn-danger"
              action="delete" controller="event" id="${event.id}" >
              <g:message code="default.button.delete.label" />
            </g:link> 
          </div>
        </sec:ifAnyGranted>

        <sec:ifAnyGranted roles="ROLE_OPERATOR, ROLE_MANERGER">
          <div class="col-sm-3 col-md-3">
            <g:render template="/event/updateReceivedMoney" model="[event: event]" />
          </div>


          <div class="col-sm-3 col-md-3">
            <g:render template="/event/updateUnreceiveMoney" model="[event: event]" />
          </div>

          <div class="col-sm-3 col-md-3">
            <g:render template="/event/updateEventDate" model="[event: event]" />
          </div>
        </sec:ifAnyGranted>
      </g:if>


    </div>            



  <div class="contact-info" >
    <h2>維修記錄</h2>
    <g:render template="contentWithDetails"  model="[event: event]" />
  </div>

  <g:render template="/product/contentWithDetails" model="[product: event.product]" />
            
</body>
</html>
