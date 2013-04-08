
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
              <div class="span9 main-column two-columns-right ">


								<!-- 如果沒有文章，顯示空白 -->
								<g:if test="${!products}">
									<g:render template="/component/emptyList"/>
								</g:if>

								<g:each in="${products}" var="product" status="i">
									<g:render template="record" model="[product:product]"/>
								</g:each>

								<g:render template="/component/pagination"/>


					  	</div>
						  <div id="right-sidebar" class="span3 sidebar">
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
                                <p>產品編號：${event.product.name}</p>
                                <p>產品名稱：${event.product.title}</p>
                                <p>里程數：${event.mileage}</p>
                                <p><i class="icon-user"></i>${event.user.title}</p>
                                <p class="date"><i class="icon-calendar"></i><g:formatDate date="${event.lastUpdated}" type="date" style="MEDIUM" /></p>

																<p>
																	<g:link controller="event" action="create" params="[product:event?.product?.id]">新增維修</g:link>
																	<g:link  
																	    class="btn btn-primary btn-mini"
																	    action="changeStatus" controller="event" id="${event.id}" 
																	    params="[status:extrails.ProductStatus.END.name(), controllerName:controllerName]" >
																	  <g:message code="ProductStatus.END" />
																	</g:link>
																</p>

                            </li>
                          </g:each>

                      </ul>
						      </div>
						  </div>
			  	</div>
	  	</div>

  </div>

</body>
</html>
