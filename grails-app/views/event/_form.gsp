
<g:hasErrors bean="${event}">
  <ul class="errors" role="alert">
    <g:eachError bean="${event}" var="error">
      <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
    </g:eachError>
  </ul>
</g:hasErrors>

<g:hiddenField name="id" value="${event?.id}" />

<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="event.name.label" />
  </label>
  <div class="col-sm-10">
    <g:textField name="name" value="${event?.name}" readonly class="form-control" />
  </div>

</div>

<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="user.username.label" />
  </label>
  <div class="col-sm-10">
    <g:select class="form-control" name="user.id" from="${event?.user ?: motoranger.UserRole.findAllByRole(motoranger.Role.findByAuthority('ROLE_OPERATOR'))*.user}" optionValue="username" noSelection="${[null:'Select One...']}" optionKey="id" value="${event?.user?.id}" />
  </div>

</div>

<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="event.product.label" />
  </label>
  <div class="col-sm-10">
    <g:select class="form-control" name="product.id" from="${event?.product?:motoranger.Product.list()}" optionValue="name" noSelection="${[null:'Select One...']}" optionKey="id" value="${event?.product?.id}" />
  </div>

</div>


<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="event.mileage.label" />
  </label>
  <div class="col-sm-10">
    <g:textField type='number' name="mileage" value="${event.mileage}" class="form-control" />
  </div>

</div>

<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="event.date.label" />
  </label>
  <div class="col-sm-10">
    <g:datePicker name="date" value="${event.date}"
      noSelection="['':'-Choose-']" precision="day" years="${(new Date().getAt(Calendar.YEAR)-1)..(new Date().getAt(Calendar.YEAR))}" />
  </div>

</div>

<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="default.description.label" />
  </label>
  <div class="col-sm-10">
    <g:textField name="description" value="${event?.description}" class="form-control" />
  </div>

</div>


<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="user.store.label" default="Store" />
  </label>
  <div class="col-sm-10">
      <g:select class="form-control" id="store" name="store.id" from="${motoranger.Store.list()}" optionKey="id" value="${event?.store?.id}" noSelection="['null': '']"/>
  </div>

</div>



