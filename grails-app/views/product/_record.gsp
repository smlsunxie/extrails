
		<div class="row-fluid">
			<div class="span12 well well-small">
							
				<sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_OPERATOR">
					
						維修<g:message code="ProductStatus.${product?.status.name()}" />：${product?.brand}：${product.name}：${product?.title}
					
 					<g:link controller="product" action="show" id="${product?.id}" class="btn btn-primary btn-mini">
						產品資料
					</g:link>
					<g:link class="btn btn-primary btn-mini" controller="event" action="list" params="['product.id':product?.id]">維修記錄</g:link>
					<g:link class="btn btn-primary btn-mini" controller="event" action="create" params="['product.id':product?.id]">新增維修</g:link>
					<g:if test="${product?.status.name() == "UNFIN"}"> 
						<g:link class="btn btn-primary btn-mini" action="changeStatusEnd" id="${product.id}" params="[status:motoranger.ProductStatus.END.name()]">維修結束</g:link>
					</g:if>
				</sec:ifAnyGranted>

				<sec:ifNotLoggedIn>
						${product?.brand.title}：AA${product?.title}
				</sec:ifNotLoggedIn>

				<div class="row-fluid">

					<div class="span2 well well-small">
						<g:message code="product.cc.label" />
						<div class="row-fluid">
								${product.cc}
						</div>
					</div>

					<div class="span2 well well-small">
						<g:message code="product.mileage.label" />
						<div class="row-fluid">
								${product.mileage}
						</div>
					</div>

					<div class="span2 well well-small">
						<g:message code="product.years.label" />
						<div class="row-fluid">
							<g:formatDate date="${product.years}" type="date" style="SHOROT"  />
						</div>
					</div>
						
					<div class="span2 well well-small">
						<g:message code="product.price.label" />
						<div class="row-fluid">
							${product.price}
						</div>
					</div>

					<sec:ifAnyGranted roles="ROLE_MANERGER">                
						<div class="span2 well well-small">
							<g:message code="product.cost.label" />
							<div class="row-fluid">
								${product.cost}
							</div>
						</div>
					</sec:ifAnyGranted >


					<div class="span2 well well-small">
						<g:message code="default.description.label" />
						<div class="row-fluid">
								 ${product?.description}
						</div>
					</div>

				</div>



				<div class="row-fluid">
					<sec:ifAnyGranted roles="ROLE_OPERATOR">

						<g:if test="${product?.events}">
							<div class="span2 well well-small">
								<g:message code="product.totalUnreceiveMoney.label" />
								<div class="row-fluid">
										 ${product?.events.totalPrice.sum()-product?.events.receivedMoney.sum()}
								</div>
							</div>
						</g:if>



            <div class="span2 well well-small">
              <g:message code="user.title.label" />
              <div class="row-fluid">
                  ${product?.user}
              </div>
            </div>


            <div class="span2 well well-small">
              <g:message code="user.telphone.label" />
              <div class="row-fluid">
                  ${product?.user?.telphone}
              </div>
            </div>

            <div class="span2 well well-small">
              <g:message code="user.mobile.label" />
              <div class="row-fluid">
                  ${product?.user?.mobile}
              </div>
            </div>


            <div class="span2 well well-small">
              <g:message code="user.description.label" />
              <div class="row-fluid">
                  ${product?.user?.description}
              </div>
            </div>

          </sec:ifAnyGranted>


				</div>
			</div>
		</div>
    


