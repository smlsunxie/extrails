
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">

<g:set var="entityName" value="${message(code: 'product.label', default: '文章')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>


</head>
<body>

  <div class="row show-grid">
      <div class="span12">                        
          <div class="row show-grid clear-both">


						  <div id="left-sidebar" class="span3 sidebar">
						      <div class="sidebar-news-widget sidebar-block">
						          <h2>維修中</h2>
                      <ul>
                          <g:each var='event' in='${unfinEvents}' >
                            <li>
                                <g:if test="${event?.product?.mainImage}">
                                	<a class="photo">
																	  <g:img uri="attachment/show?name=${event.product.name}&file=${event.product.mainImage}"  class="img-rounded" style="width:100px;" />
																	</a>
																</g:if>
																	


                                <p>產品名稱：${event.product.title}</p>
                                <p>里程數：${event.mileage}</p>
                                <p><i class="icon-user"></i>${event.user.title}</p>
                                <p class="date"><i class="icon-calendar"></i><g:formatDate date="${event.lastUpdated}" type="date" style="MEDIUM" /></p>
																
																<sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_OPERATOR">
																	<p>
																		<g:link controller="product" action="show" id="${event?.product?.id}" class="btn btn-primary btn-mini">
																			產品資料
																		</g:link>
																		<g:link class="btn btn-primary btn-mini" controller="event" action="list" params="[product:event?.product?.id]">維修記錄</g:link>
																		<g:link class="btn btn-primary btn-mini" controller="event" action="create" params="[product:event?.product?.id]">新增維修</g:link>
																		<g:if test="${event?.product?.status.name() == "UNFIN"}"> 
																			<g:link class="btn btn-primary btn-mini" action="changeStatusEnd" id="${event?.product.id}" params="[status:extrails.ProductStatus.END.name()]">維修結束</g:link>
																		</g:if>
																	
																	</p>
																</sec:ifAnyGranted>

                            </li>
                          </g:each>

                      </ul>
						      </div>

						      <div class="sidebar-news-widget sidebar-block">
						          <h2>維修完成</h2>
                      <ul>
                          <g:each var='event' in='${endEvents}' >
                            <li>
                                <g:if test="${event?.product?.mainImage}">
                                	<a class="photo">
																	  <g:img uri="attachment/show?name=${event.product.name}&file=${event.product.mainImage}"  class="img-rounded" style="width:100px;" />
																	</a>
																</g:if>
																	


                                <p>產品名稱：${event.product.title}</p>
                                <p>里程數：${event.mileage}</p>
                                <p><i class="icon-user"></i>${event.user.title}</p>
                                <p class="date"><i class="icon-calendar"></i><g:formatDate date="${event.lastUpdated}" type="date" style="MEDIUM" /></p>
																
																<sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_OPERATOR">
																	<p>
																		<g:link controller="product" action="show" id="${event?.product?.id}" class="btn btn-primary btn-mini">
																			產品資料
																		</g:link>
																		<g:link class="btn btn-primary btn-mini" controller="event" action="list" params="[product:event?.product?.id]">維修記錄</g:link>
																		<g:link class="btn btn-primary btn-mini" controller="event" action="create" params="[product:event?.product?.id]">新增維修</g:link>
																		<g:if test="${event?.product?.status.name() == "UNFIN"}"> 
																			<g:link class="btn btn-primary btn-mini" action="changeStatusEnd" id="${event?.product.id}" params="[status:extrails.ProductStatus.END.name()]">維修結束</g:link>
																		</g:if>
																	
																	</p>
																</sec:ifAnyGranted>

                            </li>
                          </g:each>

                      </ul>
						      </div>




						  </div>


          	
              <div class="span9 main-column two-columns-left ">


								<!-- 如果沒有文章，顯示空白 -->
								<g:if test="${!products}">
									<g:render template="/component/emptyList"/>
								</g:if>

								<g:each in="${products}" var="product" status="i">
									<g:render template="record" model="[product:product]"/>
								</g:each>

								<g:render template="/component/pagination"/>


					  	</div>

			  	</div>
	  	</div>

  </div>

</body>
</html>
