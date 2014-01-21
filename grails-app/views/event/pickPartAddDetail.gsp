<g:set var="tagQueryService" bean="tagQueryService"/>
<g:set var="nowTag" value="${params.tag}" />

<html>
<head>
<title><g:message code="event.pickPartAddDetail.label" defualt="pickPartAddDetail" args="[event]"/></title>


</head>
<body>



<sec:ifAnyGranted roles="ROLE_OPERATOR, ROLE_CUSTOMER">


  <div class="row">

    <div class="col-sm-3 col-md-3">
      <div class="btn-group" id="actionbar">
        <g:link  class="btn btn-primary" controller="part" action="create" params="['event.id': event.id]">新增並加入自定維修項目</g:link>
      </div>
    </div>
         
    <sec:ifAnyGranted roles="ROLE_OPERATOR">
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


  </div>

</sec:ifAnyGranted>

<g:render template="contentWithDetails"  model="[event: event]" />

<g:render template="/part/portfolio" model="['event': event]" />
               
  </body>
</html>
