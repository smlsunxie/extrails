	<div class="row-fluid">
	  <div class="span10 well well-small">
	  	第 ${i} 項

			<sec:ifAnyGranted roles="ROLE_OPERATOR">
        <g:link
            class="btn btn-danger btn-mini"
            action="delete"
            controller="eventDetail"
            id="${detail.id}"  >
          <g:message code="default.button.delete.label" />
        </g:link>	
        <g:link
            class="btn btn-primary btn-mini"
            action="edit"
            controller="eventDetail"
            id="${detail.id}"  >
          <g:message code="default.button.edit.label" />
        </g:link>		           	           
	    </sec:ifAnyGranted>


	    <div class="row-fluid">
	      <div class="span2 well well-small">
	        <g:message code="default.dateCreated.label" />
	        <div class="row-fluid">
	            <g:formatDate date="${detail.lastUpdated}" type="date" style="SHOROT" />
	        </div>
	      </div>

	      <div class="span2 well well-small">
	        <g:message code="part.title.label" />
	        <div class="row-fluid">
	          ${detail?.part?.title}
	        </div>
	      </div>

	      <div class="span2 well well-small">
	        <g:message code="eventDetail.price.label" />
	        <div class="row-fluid">
						${detail?.price}
	        </div>
	      </div>

				<sec:ifAnyGranted roles="ROLE_MANERGER">
		      <div class="span2 well well-small">
						<g:message code="part.cost.label" />
		        <div class="row-fluid">
							${detail?.part?.cost}
		        </div>
		      </div>
				</sec:ifAnyGranted>
	    </div>

	  </div>

			<g:if test="${detail?.mainImage}">
      <div class="span2">
        <div class="row-fluid">
          <g:link action="show" controller="attachment" params="[name:detail.name ,file:detail.mainImage]"><g:img  alt="" uri="attachment/show?name=${detail.name}&file=${detail.mainImage}" /></g:link>
					
        </div>
      </div>
			</g:if>
	</div>