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
      <g:render template="statusChangeBtn" />
    </div>
    
    <div class="col-sm-3 col-md-3">
      <div class="input-group">
        <span class="input-group-addon">已收金額</span>
        <g:remoteField action="updateReceivedMoney" controller="event" id="${event.id}"
          name="receivedMoney" onSuccess="onSuccessFun(data)" value="${event?.receivedMoney.toString()}"  data-for="unreceiveMoney_${event.id}" class="form-control" />
      </div>                          

    </div>

    <div class="col-sm-3 col-md-3">
      <div class="input-group">
        <span class="input-group-addon">未收金額</span>
        <input readonly value="${event?.totalPrice-event?.receivedMoney}"  type="text" id="unreceiveMoney_${event.id}"  data-initValue="${event?.totalPrice}" class="form-control" />                               
      </div>
      
    </div>

    <div class="col-sm-3 col-md-3">
      <div class="input-group">
        <span class="input-group-addon">維修日期</span>
        <input  type="text" value="${event?.date.format('yyyy-MM-dd')}" data-date="${event?.date.format('yyyy-MM-dd')}" data-date-format="yyyy-mm-dd" name="date" class="form-control"/>
      </div>  
    </div>

  </div>

</sec:ifAnyGranted>

<g:render template="contentWithDetails"  model="[event: event]" />

<g:render template="/part/portfolio" model="['event': event, tag:tag, part: part]" />
               
<r:script>
  $(function() {
    $("[name='date']").datepicker({
        format: "yyyy-mm-dd",
        language: "zh-TW"
    }).on('changeDate', function(ev){

      $.ajax({
        type:'POST',
        data:'date=' + ev.date.valueOf(), 
        url:'/event/updateDate/${event?.id}',
        success:function(data,textStatus){
          onDateSuccessFun(data);
        },
        error:function(XMLHttpRequest,textStatus,errorThrown){

        }
      });

    });




    var onDateSuccessFun=function(data){
      if(data.success){
        bootstrap_alert.warning("維修日期已改為："+data.date)
      }else {
        bootstrap_alert.warning(data.msg)
      }
    }
  });

</r:script>
  </body>
</html>
