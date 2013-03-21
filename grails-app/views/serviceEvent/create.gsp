<!DOCTYPE html>
<html>
	<head>
		<title><g:message code="default.home.label"/></title>

	</head>
	<body>



      <g:form action="save" class="form-horizontal"> 

        <g:submitButton name="save"  class="btn btn-primary btn-mini" value="${message(code: 'default.button.save.label', default: "save")}" />

        <g:link action='list' class="btn btn-mini">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>

          <div class="bs-docs-example">

           <div class="control-group">
                <label class="control-label required" for="name">
                    <g:message code="serviceEvent.name.label" />

                </label>
                <div class="controls">
                    <g:textField name="name" value="${serviceEvent?.name}" readonly class="input input-xlarge" />
                </div>                 
            </div>



            <div class="control-group">
                <label class="control-label required" for="name">

                    <g:message code="product.name.label" />
                </label>
                  <div class="controls">
                    <g:select name="product" from="${extrails.Product.list()}" optionValue="name" 
                    noSelection="${[null:'Select One...']}" optionKey="id" value="${serviceEvent?.product?.id}" />
                  </div>
            </div>



            <div class="control-group">
                <label class="control-label required" for="name">
                    <g:message code="product.mileage.label" />

                </label>
                <div class="controls">
                    <g:field type='number' name="mileage" value="0" class="input input-xlarge" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label required" for="description">
                    <g:message code="default.description.label" />

                </label>
                <div class="controls">
                    <g:textField  name="description" value="${serviceEvent?.description}" class="input input-xlarge" />
                </div>
            </div>

          </div>

 
        </g:form>

    <r:script>
      $(function() {
        $("#product").select2();

      });
    </r:script>
	</body>
</html>
