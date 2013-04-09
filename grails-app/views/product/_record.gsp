
		<div class="row-fluid">
			<div class="span12 well well-small">
							
				<sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_OPERATOR">
					
						維修<g:message code="ProductStatus.${product?.status.name()}" />:<g:message code="ProductBrand.${product?.brand}" />：${product.name}：${product.title}
					
					<g:link controller="product" action="show" id="${product?.id}" class="btn btn-primary btn-mini">
						產品資料
					</g:link>
					<g:link class="btn btn-primary btn-mini" controller="event" action="list" params="[product:product?.id]">維修記錄</g:link>
					<g:link class="btn btn-primary btn-mini" controller="event" action="create" params="[product:product?.id]">新增維修</g:link>
					<g:if test="${product?.status.name() == "UNFIN"}"> 
						<g:link class="btn btn-primary btn-mini" action="changeStatusEnd" id="${product.id}" params="[status:extrails.ProductStatus.END.name()]">維修結束</g:link>
					</g:if>
				</sec:ifAnyGranted>

				<sec:ifNotLoggedIn>
						<g:message code="ProductBrand.${product?.brand}" />：${product.title}
				</sec:ifNotLoggedIn>

				<div class="row-fluid">

					<div class="span3 well well-small">
						<g:message code="product.cc.label" />
						<div class="row-fluid">
								
								${product.cc}

						</div>
					</div>

					<div class="span3 well well-small">
						<g:message code="product.mileage.label" />
						<div class="row-fluid">
								${product.mileage}
						</div>
					</div>

					<div class="span3 well well-small">
						<g:message code="product.years.label" />
						<div class="row-fluid">

								<g:formatDate date="${product.years}" type="date" style="SHOROT"  />

						</div>
					</div>
						<div class="span3 well well-small">
							<g:message code="product.price.label" />
							<div class="row-fluid">
									${product.price}
							</div>
						</div>

				</div>

				%{-- 第二行 --}%
				<div class="row-fluid">


					<sec:ifAnyGranted roles="ROLE_MANERGER">                
						<div class="span3 well well-small">
							<g:message code="product.cost.label" />
							<div class="row-fluid">
									${product.cost}
							</div>
						</div>
					</sec:ifAnyGranted >



					<sec:ifAnyGranted roles="ROLE_OPERATOR">

						<div class="span3 well well-small">
							<g:message code="user.username.label" />
							<div class="row-fluid">
									 ${product?.user?.username}
							</div>
						</div>



					</sec:ifAnyGranted >


				</div>
			</div>
		</div>