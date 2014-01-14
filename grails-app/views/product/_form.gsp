<g:hiddenField name = "id" value="${product.id}" />

<g:hasErrors bean="${product}">
  <ul class="errors" role="alert">
    <g:eachError bean="${product}" var="error">
      <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
    </g:eachError>
  </ul>
</g:hasErrors>

<div class="form-group ${hasErrors(bean: product, field: 'name', 'has-error')}">
  
  <label for="name" class="col-sm-2 control-label">
    <g:message code="product.name.label" /><span class="required-mark">*</span>
  </label>
  <div class="col-sm-10">
    <g:textField name="name" value="${product?.name}" class="form-control" />
  </div>

</div>


<div class="form-group ${hasErrors(bean: product, field: 'title', 'has-error')}">
  
  <label for="title" class="col-sm-2 control-label">
    <g:message code="product.title.label" /><span class="required-mark">*</span>
  </label>
  <div class="col-sm-10">
    <g:textField name="title" value="${product?.title}" class="form-control" />
  </div>

</div>



<div class="form-group ${hasErrors(bean: product, field: 'description', 'has-error')}">
  
  <label for="description" class="col-sm-2 control-label">
    <g:message code="default.description.label" />
  </label>
  <div class="col-sm-10">
    <g:textField name="description" value="${product?.description}" class="form-control" />
  </div>

</div>


<div class="form-group ${hasErrors(bean: product, field: 'mileage', 'has-error')}">
  
  <label for="mileage" class="col-sm-2 control-label">
    <g:message code="product.mileage.label" />
  </label>
  <div class="col-sm-10">
    <g:textField name="mileage" type="number" value="${product?.mileage}" class="form-control" />
  </div>

</div>


<div class="form-group ${hasErrors(bean: product, field: 'brand', 'has-error')}">
  
  <label for="brand.id" class="col-sm-2 control-label">
    <g:message code="product.brand.label" />
  </label>
  <div class="col-sm-10">
    <g:select class="form-control" name="brand.id" from="${motoranger.Brand.list()}" 
          noSelection="${['null':'請選擇...']}" optionKey="id" value="${product?.brand?.id}" />
  </div>

</div>



<div hidden class="form-group ${hasErrors(bean: product, field: 'user', 'has-error')}">
  
  <label for="user.id" class="col-sm-2 control-label">
    <g:message code="product.user.label" />
  </label>
  <div class="col-sm-10">
    <g:select id="user" name="user.id" from="${motoranger.User.findById(product?.user?.id)}" optionKey="id" value="${product?.user?.id}" class="many-to-one" noSelection="['null': '']" class="form-control" />
  </div>

</div>

<div class="form-group ${hasErrors(bean: product, field: 'years', 'has-error')}">
  
  <label for="years" class="col-sm-2 control-label">
    <g:message code="product.years.label" />
  </label>
  <div class="col-sm-10">
    <g:datePicker name="years" value="${product.years}"
        noSelection="['':'-Choose-']" precision="month" years="${1980..(new Date().getAt(Calendar.YEAR))}" />
  </div>

</div>


<div class="form-group ${hasErrors(bean: product, field: 'cc', 'has-error')}">
  
  <label for="cc" class="col-sm-2 control-label">
    <g:message code="product.cc.label" />  
  </label>
  <div class="col-sm-10">
    <g:field class="form-control" type="number" name="cc" value="${product?.cc}"/>
  </div>

</div>



<sec:ifAnyGranted roles="ROLE_OPERATOR">

  <div class="form-group ${hasErrors(bean: product, field: 'cost', 'has-error')}">
    
    <label for="cost" class="col-sm-2 control-label">
      <g:message code="product.cost.label" />
    </label>
    <div class="col-sm-10">
      <g:field class="form-control" type="number" name="cost" value="${product?.cost}" />
    </div>

  </div>


  <div class="form-group ${hasErrors(bean: product, field: 'price', 'has-error')}">
    
    <label for="price" class="col-sm-2 control-label">
      <g:message code="product.price.label" />
    </label>
    <div class="col-sm-10">
      <g:field class="form-control" type="number" name="price" value="${product?.price}" />
    </div>

  </div>


</sec:ifAnyGranted>

<p></p>
<div class="form-group">
  
  <label class="col-sm-2 control-label">
    <g:message code="default.imageUpload.label" />
  </label>
  <div class="col-sm-10">
    <g:render template="/attachment/uploadBtn" model="[name:product.name,mainImage: product?.mainImage]" />
  </div>

</div>

