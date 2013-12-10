
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">

<g:set var="entityName" value="${message(code: 'part.label', default: '文章')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>


</head>
<body>

  <sec:ifAnyGranted roles="ROLE_OPERATOR">

    <div class="row" id="actionbar">

      <div class="col-sm-4 col-md-4">

        <g:link class="btn btn-primary btn-large "
          action="edit" controller="event" id="${event.id}" >
        <g:message code="default.button.edit.label" />
        </g:link>

        <g:link class="btn btn-primary" controller="event" action="pickPartAddDetail" id="${event.id}"  >
          <g:message code="eventDetail.create.label" />   
        </g:link>   


        <g:render template="statusChangeBtn" />


        <g:link class="btn btn-danger"
          action="delete" controller="event" id="${event.id}" >
          <g:message code="default.button.delete.label" />
        </g:link> 
      </div>

      <div class="col-sm-4 col-md-4">
        <g:render template="/event/updateReceivedMoney" model="[event: event]" />
      </div>


      <div class="col-sm-4 col-md-4">
        <g:render template="/event/updateUnreceiveMoney" model="[event: event]" />
      </div>


    </div>            
  </sec:ifAnyGranted>


  <div class="contact-info" >
    <h2>維修記錄</h2>
    <g:render template="contentWithDetails"  model="[event: event]" />
  </div>

  <g:render template="/product/contentWithDetails" model="[product: event.product]" />
            
</body>
</html>
