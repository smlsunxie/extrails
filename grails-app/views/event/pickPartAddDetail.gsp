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
      <g:render template="statusChangeBtn" />
    </div>
    


    <div class="col-sm-3 col-md-3">
      <g:render template="/event/updateReceivedMoney" model="[event: event]" />
    </div>


    <div class="col-sm-3 col-md-3">
      <g:render template="/event/updateUnreceiveMoney" model="[event: event]" />
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
