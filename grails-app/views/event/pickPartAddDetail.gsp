<g:set var="tagQueryService" bean="tagQueryService"/>
<g:set var="nowTag" value="${params.tag}" />

<html>
<head>
<title><g:message code="post.edit.title" defualt="修改文章"/></title>


</head>
<body>


<sec:ifAnyGranted roles="ROLE_OPERATOR">


  <div class="row">
    <div class="col-sm-3 col-md-3">
      <g:link  class="btn btn-primary"  action="show" id="${event?.id}">新增完成</g:link>
    </div>
    


    <div class="col-sm-3 col-md-3">
      <g:render template="/event/updateReceivedMoney" model="[event: event]" />
    </div>


    <div class="col-sm-3 col-md-3">
      <g:render template="/event/updateUnreceiveMoney" model="[event: event]" />
    </div>



    <div class="col-sm-3 col-md-3">
      <g:render template="/event/updateEventDate" model="[event: event]" /> 
    </div>

  </div>

</sec:ifAnyGranted>

<g:render template="contentWithDetails"  model="[event: event]" />

<g:render template="/part/portfolio" model="['event': event, tag:tag, part: part]" />
               
  </body>
</html>
