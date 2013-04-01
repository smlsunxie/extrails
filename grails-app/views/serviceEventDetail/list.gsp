
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">

<g:set var="entityName" value="${message(code: 'part.label', default: '文章')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>


</head>
<body>


	<div class="row">

		<div class="span12">
			<table class="table">
				<thead>
					<tr>
						<th><g:message code="serviceEvent.name.label" /></th>
						<th><g:message code="serviceEvent.status.label" /></th>
						<th><g:message code="serviceEvent.mileage.label" /></th>
						<th><g:message code="default.dateCreated.label" /></th>
						<th><g:message code="default.action.label" /></th>
					</tr>
				</thead>
				<tbody>

					<g:render template='/serviceEvent/headList' model="[serviceEvent:serviceEvent]" />

					<g:if test="${serviceEvent?.details}">
						<tr>
							<td colspan="5">
								<table class="table-bordered" width="100%">

									<thead>
										<tr>
											<th><g:message code="default.dateCreated.label" /></th>
											<th><g:message code="part.title.label" /></th>
											
											<th><g:message code="default.description.label" /></th>
											<th><g:message code="default.mainImage.label" /></th>
											<th><g:message code="part.price.label" /></th>
											<th><g:message code="part.cost.label" /></th>
										</tr>
									</thead>									
									<tbody>
										<g:each in="${serviceEvent?.details}" var="detail">
											<tr>
												<td><g:formatDate date="${detail.lastUpdated}" type="date" style="SHOROT" /></td>
												<td>${detail?.part?.title}</td>

												<td>${detail?.description}</td>
												<td><g:if test="${detail.mainImage!=''}"><g:link action="show" controller="attachment" params="[name:detail.name ,file:detail.mainImage]"><g:img style="height:50px" alt="" uri="attachment/show?name=${detail.name}&file=${detail.mainImage}" /></g:link></g:if></td>
												<td>${detail?.part?.price}</td>
												<td>${detail?.part?.cost}</td>

											</tr>
										</g:each>
									</tbody>
									<tfoot>

									</tfoot>
								</table>
							</td>
						</tr>
					</g:if> 

				</tbody>
			</table>
		</div>
	</div>

</body>
</html>
