<html>
  <head>
	<title><g:message code="post.edit.title" defualt="修改文章"/></title>


  </head>
  <body>


	<g:set var="nowTag" value="${params.tag}" />
	<div class="col-wrapper">

		<g:if test="${params.event}"> 

			<sec:ifAnyGranted roles="ROLE_OPERATOR">


				<div class="row">
					
					<div class="span3">
						<div class="input-prepend input-append">
						  <span class="add-on">已收金額</span>
						  <g:remoteField action="updateReceivedMoney" controller="event" id="${event.id}"
							  name="receivedMoney" onSuccess="onSuccessFun(data)" value="${event?.receivedMoney.toString()}"  data-for="unreceiveMoney_${event.id}" class="span2" />
						</div>	                        

					</div>
					<div class="span3">
						<div class="input-prepend input-append">
						  <span class="add-on">未收金額</span>
						  <input readonly value="${event?.totalPrice-event?.receivedMoney}"  type="text" id="unreceiveMoney_${event.id}"  data-initValue="${event?.totalPrice}"  class="span2" />                       				
						</div>
						
					</div>			
					<div class="span3">
						<div class="input-prepend input-append">
						  <span class="add-on">維修總額</span>
						  <input readonly value="${event?.totalPrice}"  type="text" class="span2" />                       				
						</div>
					</div>

						<div class="input-prepend input-append">
						  <span class="add-on">維修日期</span>
						  <input  type="text" value="${event?.date.format('yyyy-MM-dd')}" data-date="${event?.date.format('yyyy-MM-dd')}" data-date-format="yyyy-mm-dd" class="span2" name="date"
						  onchange="alert(1)"/>



						</div>	


				</div>

			</sec:ifAnyGranted>   


			<div class="portfolio-nav">
	<!-- SET PORTFOLIO NAV FILTERS HERE -->                     
				<ul id="filters" data-option-key="filter" class="nav nav-pills nav-pills-portfolio">


				  <g:if test="${event?.product?.status.name() == "UNFIN"}"> 
					<li class="active">
						<g:link action="changeStatus" id="${event?.id}" controller="event" params="[status:extrails.ProductStatus.END.name(),controllerName:'home']">維修結束</g:link>
					</li>
				  </g:if>
					

					<li class="active">
						<g:link controller="eventDetail" action='list' params="[event:params.event]">修改 ${event?.product.name} 維修記錄</g:link>
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
			<ul id="filters" data-option-key="filter" class="nav nav-pills nav-pills-portfolio">
				<g:each var="tag" in="${tags}">

					<li class="${ nowTag == tag.toString() ? 'active' : '' }">
						<g:link action="portfolio" params="[event:params.event,tag:tag]" >${tag}</g:link>
					</li>
				</g:each>




			</ul>
		</div>
	<!-- END PORTFOLIO NAV -->

	<!-- START PORTFOLIO GRID -->                
		<div class="portfolio-grid-1 main-block">
			<ul id="portfolio" class="row thumbnails">                  
				<g:each var="part" in="${parts}">
					<li class="span3 large hp-wrapper element ${part.tags.join(' ')}">        
						<div class="thumbnail">
%{--                           <g:img alt="" uri="/attachment/show?name=${part.name}&file=${part.mainImage}" style='height:100px' />  --}%
						  <div class="caption">
							<h3><g:link controller="part" action="show" id="${part.id}">${part.title}</g:link></h3>
							<p>${part.description}</p>
							<p>售價：${part.price}</p>


								<p>
									<g:if test="${params.event}">
										<g:link controller="eventDetail" action="create"
										 params="[part:part.id, head:params?.event]" class="btn btn-primary">新增維修</g:link> 
									</g:if>
										<g:link controller="part" action="show" id="${part.id}" class="btn">檢視項目</g:link>
								</p>



						  </div>
						</div>
					</li>
				</g:each>
			</ul>
		</div>
	</div>                
<r:script>
	$("[name='date']").datepicker().on('changeDate', function(ev){

			${remoteFunction(action: 'updateDate',
				controller:'event',
				id:event?.id,
				onSuccess:'onDateSuccessFun(data)',
				params: '\'date=\' + ev.date.valueOf()')}

  });
	
	var onDateSuccessFun=function(data){
    if(data.success){
      bootstrap_alert.warning("維修日期已改為："+data.date)
    }else {
			bootstrap_alert.warning(data.msg)
    }
	}

</r:script>
  </body>
</html>
