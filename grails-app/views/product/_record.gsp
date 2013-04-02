
		<div class="row-fluid">
			<div class="span12 well well-small">
							
				<g:link controller="product" action="show" id="${product?.id}">
									${product?.brand}：${product.name}：${product.title}
							</g:link>

				<div class="row-fluid">

					<div class="span3 well well-small">
						<g:message code="event.label" />
						<div class="row-fluid">
								
								<g:link controller="event" action="list" params="[product:product?.id]">維修記錄</g:link>
								<g:link controller="event" action="create" params="[product:product?.id]">新增維修</g:link>
						</div>
					</div>

					<div class="span3 well well-small">
						<g:message code="product.dateCreated.label" />
						<div class="row-fluid">
								<g:formatDate date="${product.lastUpdated}" type="date" style="SHOROT" />
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

								<g:formatDate date="${product.years}" type="date" style="SHOROT" />

						</div>
					</div>

				</div>

				%{-- 第二行 --}%
				<div class="row-fluid">

					<div class="span3 well well-small">
						<g:message code="product.cc.label" />
						<div class="row-fluid">
								
								${product.cc}

						</div>
					</div>

					<div class="span3 well well-small">
						<g:message code="user.username.label" />
						<div class="row-fluid">
								 ${product?.user?.username}
						</div>
					</div>

					<g:if test="${actionName=='show'}">
					<div class="span3 well well-small">
							<g:message code="product.price.label" />
							<div class="row-fluid">
									${product.price}
							</div>
						</div>



						<sec:ifAnyGranted roles="ROLE_MANERGER">                
							<div class="span3 well well-small">
								<g:message code="product.cost.label" />
								<div class="row-fluid">
										${product.cost}
								</div>
							</div>
						</sec:ifAnyGranted >
					</g:if>
				</div>
			</div>
		</div>