<!DOCTYPE html>
<html>
  <head>
        <title><g:message code="${controllerName}.${actionName}.title"/></title>
  </head>
  <body>



      <g:form action="save" class="form-horizontal"> 

            <g:actionbar actionName="${actionName}" domain="${event}" />


          <div class="bs-docs-example">

           <div class="control-group">
                <label class="control-label required" for="name">
                    <g:message code="event.name.label" />

                </label>
                <div class="controls">
                    <g:textField name="name" value="${event?.name}" readonly class="input input-xlarge" />
                </div>                 
            </div>

            <div class="control-group">
              <label class="control-label required" for="name">
                  <g:message code="user.username.label" />

              </label>
                <div class="controls">
                  <g:select name="user" from="${extrails.UserRole.findAllByRole(extrails.Role.findByAuthority('ROLE_OPERATOR'))*.user}" optionValue="username" 
                  noSelection="${[null:'Select One...']}" optionKey="id" value="${event?.user?.id}" />
                </div>                    
            </div>

            <div class="control-group">
                <label class="control-label required" for="name">

                    <g:message code="event.name.label" />
                </label>
                  <div class="controls">
                    <g:select name="product" from="${extrails.Product.list()}" optionValue="name" 
                    noSelection="${[null:'Select One...']}" optionKey="id" value="${event?.product?.id}" />
                  </div>
            </div>



            <div class="control-group">
                <label class="control-label required" for="name">
                    <g:message code="event.mileage.label" />

                </label>
                <div class="controls">
                    <g:field type='number' name="mileage" value="${event.mileage}" class="input input-xlarge" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label required" for="description">
                    <g:message code="default.description.label" />

                </label>
                <div class="controls">
                    <g:textField  name="description" value="${event?.description}" class="input input-xlarge" />
                </div>
            </div>

          </div>

 
        </g:form>

    <r:script>
      $(function() {
        $("#user").select2();
        $("#product").select2();

      });
    </r:script>
  </body>
</html>
