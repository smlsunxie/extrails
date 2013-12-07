<div class="row" id="actionbar">

  <div class="col-sm-12 col-md-12">


            <g:if test="${actionName=='create' ||actionName=='save' ||actionName=='edit' }" >
              

              <g:submitButton name="${nextActionName}"  class="btn btn-primary btn-large" value="${message(code: 'default.button.${nextActionName}.label', default: nextActionName)}" />
              <g:link action='list' class="btn">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
            

            </g:if >  
            <g:elseif test="${actionName=='show'}" >
            

              <g:link  class="btn btn-primary"  action="edit" id="${domain?.id}"><g:message code="default.button.edit.label" /></g:link>

              <g:if test="${controllerName=='product'}" >
                <g:link class="btn btn-primary btn-mini" controller="event" action="create" params="['product.id':product?.id]">新增維修</g:link>
                
                <g:if test="${product?.status.name() == "UNFIN"}"> 
                  <g:link class="btn btn-primary btn-mini" action="changeStatusEnd" id="${product.id}" params="[status:motoranger.ProductStatus.END.name()]">維修結束</g:link>
                </g:if>
              </g:if>

              <g:link  class="btn btn-danger" action="delete" id="${domain?.id}"><g:message code="default.button.delete.label" /></g:link>




            </g:elseif >  
            <g:elseif test="${actionName=='index'}" >


              <g:link  class="btn btn-primary">${domain?.title}</g:link>


            </g:elseif >  

  </div>


</div>

