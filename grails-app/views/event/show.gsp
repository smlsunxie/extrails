
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
        <div class="input-group">
          <span class="input-group-addon">已收</span>
          <g:remoteField action="updateReceivedMoney" controller="event" id="${event.id}"
          name="receivedMoney" onSuccess="onSuccessFun(data)" value="${event?.receivedMoney.toString()}" class="form-control" data-for="unreceiveMoney_${event.id}"  /> 
        </div>
      </div>


      <div class="col-sm-4 col-md-4">
        <div class="input-group">
          <span class="input-group-addon">未收</span>
          <input readonly value="${event?.totalPrice-event?.receivedMoney}" class="form-control" id="unreceiveMoney_${event.id}"  type="text" data-initValue="${event?.totalPrice}" /> 
        </div>
      </div>


    </div>            
  </sec:ifAnyGranted>


  <div class="contact-info" >
    <h2>維修記錄</h2>
    <g:render template="contentWithDetails"  model="[event: event]" />
  </div>

  <div class="row">
    <div class="contact-info col-sm-6 col-md-6">
      <h2>維修機車資料</h2>
      <g:render template="/product/content" model="[product: event.product]" />
    </div>
    <div class="contact-info col-sm-6 col-md-6">
      <h2>維修人員資料</h2>
      <g:render template="/user/content" model="[user: event.user]" />
    </div>
  </div>
            
</body>
</html>
