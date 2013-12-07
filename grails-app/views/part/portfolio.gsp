<html>
  <head>
  <title><g:message code="post.edit.title" defualt="修改文章"/></title>


  </head>
  <body>


  <g:set var="nowTag" value="${params.tag}" />
  <div class="col-wrapper">

    <g:if test="${params?.event?.id}"> 

      <sec:ifAnyGranted roles="ROLE_OPERATOR">


        <div class="row">
          
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
              <span class="input-group-addon">維修總額</span>
              <input readonly value="${event?.totalPrice}"  type="text" class="form-control" />                              
            </div>
          </div>

            <div class="input-group">
              <span class="input-group-addon">維修日期</span>
              <input  type="text" value="${event?.date.format('yyyy-MM-dd')}" data-date="${event?.date.format('yyyy-MM-dd')}" data-date-format="yyyy-mm-dd" name="date" class="form-control"/>



            </div>  


        </div>

      </sec:ifAnyGranted>   


      <div class="portfolio-nav">
  <!-- SET PORTFOLIO NAV FILTERS HERE -->                     
        <ul data-option-key="filter" class="nav nav-pills nav-pills-portfolio">


          <g:if test="${event?.product?.status.name() == "UNFIN"}"> 
          <li class="active">
            <g:link action="changeStatus" id="${event?.id}" controller="event" params="[status:motoranger.ProductStatus.END.name(),controllerName:'home']">維修結束</g:link>
          </li>
          </g:if>
          

          <li class="active">
            <g:link controller="event" action='show' id="${params.event.id}">修改 ${event?.product.name} 維修記錄</g:link>
          </li>
          <g:each var="detail" in="${event.details}">
            <li><a href="#" >${detail.part.title}</a></li>
          </g:each>


        </ul>
      </div>                    

               
    </g:if>
<!-- START PORTFOLIO NAV -->                    
    <div class="portfolio-nav">
<!-- SET PORTFOLIO NAV FILTERS HERE -->                     
      <ul data-option-key="filter" class="nav nav-pills nav-pills-portfolio">
        <g:each var="tag" in="${tags}">

          <li class="${ nowTag == tag.toString() ? 'active' : '' }">
            <g:link action="portfolio" params="['event.id':params?.event?.id,tag:tag]" >${tag}</g:link>
          </li>
        </g:each>




      </ul>
    </div>
  <!-- END PORTFOLIO NAV -->

  <!-- START PORTFOLIO GRID -->                
    <div class="portfolio-grid-1 main-block">
      <ul id="portfolio" class="row thumbnails">                  
        <g:each var="part" in="${parts}">
          <li class="col-sm-3 col-md-3 large hp-wrapper element ${part.tags.join(' ')}">        
            <div id="${part.name}" class="thumbnail">
%{--                           <g:img alt="" uri="/attachment/show?name=${part.name}&file=${part.mainImage}" style='height:100px' />  --}%
  
                <div class="caption">

                  <h3><g:link controller="part" action="show" id="${part.id}">${part.title}</g:link></h3>
                  <p>${part.description}</p>

                  <g:if test="${params?.event?.id}">
                    <g:form action="save" controller="eventDetail" class="form-thumbnail" params="['part.id':part.id, 'part.name':part.name, 'head.id':params.event.id, returnUrl:createLink(action:actionName, params:['event.id':params.event.id, tag:params.tag])]"> 
                      <p>


                        <div class="input-group">
                          <span class="input-group-addon">售價</span>
                          <g:textField value="${part.price}" name="price" class="form-control" />
                        </div>

                        <div class="input-group">
                          <span class="input-group-addon">數量</span>
                          <g:textField value="1"  name="qty" class="form-control" />
                        </div>                          
                      </p>

                      <p>

                          <g:submitButton controller="eventDetail" action="create"class="btn btn-primary" name="快速新增" /> 
                          <g:link controller="eventDetail" action="create" params="['part.id':part.id, 'head.id':params.event.id, returnUrl:createLink(action:actionName, params:['event.id':params.event.id, tag:params.tag])]" class="btn btn-primary">照相新增</g:link> 
                        

                      </p>
                    </g:form>
                  </g:if>

                  <g:else>
                    <p>售價：${part.price}</p>
                    <g:link controller="part" action="show" id="${part.id}" class="btn">檢視項目</g:link>
                  </g:else>
                </div>

            </div>
          </li>
        </g:each>
      </ul>
    </div>
  </div>                
<r:script>
  $(function() {
    $("[name='date']").datepicker().on('changeDate', function(ev){

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
