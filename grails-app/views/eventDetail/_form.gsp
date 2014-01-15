<g:hasErrors bean="${eventDetail}">
  <ul class="errors" role="alert">
    <g:eachError bean="${eventDetail}" var="error">
      <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
    </g:eachError>
  </ul>
</g:hasErrors>

<g:hiddenField name="id" value="${eventDetail?.id}" />

<div hidden class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="eventDetail.name.label" />
  </label>
  <div class="col-sm-10">
    <g:textField name="name" readonly value="${eventDetail?.name}" class="form-control" />
  </div>

</div>


<div hidden class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="event.name.label" />
  </label>
  <div class="col-sm-10">
    <g:select class="form-control" name="head.id" from="${eventDetail?.head ?: motoranger.Event.list()}" noSelection="${[null:'Select One...']}" optionKey="id" value="${eventDetail?.head?.id}" />
  </div>

</div>


<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="part.name.label" />
  </label>
  <div class="col-sm-10">
    <g:select disabled class="form-control" name="part.id" from="${eventDetail?.part ?: motoranger.Part.list()}" noSelection="${[null:'Select One...']}" optionKey="id" value="${eventDetail?.part?.id}" />
  </div>

</div>


<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="eventDetail.price.label" />
  </label>
  <div class="col-sm-10">
    <g:field  type="number" name="price" value="${eventDetail?.price}" class="form-control" />
  </div>

</div>

<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="eventDetail.cost.label" />
  </label>
  <div class="col-sm-10">
    <g:field  type="number" name="cost" value="${eventDetail?.cost}" class="form-control" />
  </div>

</div>


<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="eventDetail.qty.label" />
  </label>
  <div class="col-sm-10">
    <g:field  type="number" name="qty" value="${eventDetail?.qty}" class="form-control" />
  </div>

</div>

<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="default.description.label" />
  </label>
  <div class="col-sm-10">
    <g:textField  name="description" value="${eventDetail?.description}" class="form-control" />
  </div>

</div>


<div class="form-group">
  
  <label for="" class="col-sm-2 control-label">
   <g:message code="default.imageUpload.label" />
  </label>
  <div class="col-sm-10">
    <g:render template="/attachment/uploadBtn" model="[name:eventDetail?.name,mainImage:eventDetail?.mainImage]" />
  </div>

</div>