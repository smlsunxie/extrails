<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="product.name.label" /><span class="required-mark">*</span>
  </label>
  <div class="col-sm-10">
    <g:textField name="name" value="${product?.name}" class="form-control" />
  </div>

</div>


<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="product.title.label" /><span class="required-mark">*</span>
  </label>
  <div class="col-sm-10">
    <g:textField name="title" value="${product?.title}" class="form-control" />
  </div>

</div>



<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="default.description.label" />
  </label>
  <div class="col-sm-10">
    <g:textField name="description" value="${product?.description}" class="form-control" />
  </div>

</div>


<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="product.mileage.label" />
  </label>
  <div class="col-sm-10">
    <g:textField name="mileage" type="number" value="${product?.mileage}" class="form-control" />
  </div>

</div>


<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="product.brand.label" />
  </label>
  <div class="col-sm-10">
    <g:select class="form-control" name="brand.id" from="${motoranger.Brand.list()}" 
          noSelection="${['null':'請選擇...']}" optionKey="id" value="${product?.brand?.id}" />
  </div>

</div>



<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="product.user.label" />
  </label>
  <div class="col-sm-10">
    <g:select id="user" name="user.id" from="${motoranger.User.findById(params?.user?.id)}" optionKey="id" value="${params?.user?.id}" class="many-to-one" noSelection="['null': '']" class="form-control" />
  </div>

</div>

<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="product.years.label" />
  </label>
  <div class="col-sm-10">
    <g:datePicker name="years" value="${product.years}"
        noSelection="['':'-Choose-']" precision="month" years="${1980..(new Date().getAt(Calendar.YEAR))}" />
  </div>

</div>


<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="product.cc.label" />  
  </label>
  <div class="col-sm-10">
    <g:field class="form-control" type="number" name="cc" value="${product?.cc}"/>
  </div>

</div>


<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="product.cost.label" />
  </label>
  <div class="col-sm-10">
    <g:field class="form-control" type="number" name="cost" value="${product?.cost}" />
  </div>

</div>


<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="product.price.label" />
  </label>
  <div class="col-sm-10">
    <g:field class="form-control" type="number" name="price" value="${product?.price}" />
  </div>

</div>

<p></p>



<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="default.imageUpload.label" />
  </label>
  <div class="col-sm-10">
    <g:render template="/attachment/uploadBtn" model="[name:product.name,mainImage: product?.mainImage]" />
  </div>

</div>
