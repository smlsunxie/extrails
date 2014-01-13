<g:hasErrors bean="${user}">
  <ul class="errors" role="alert">
    <g:eachError bean="${user}" var="error">
      <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
    </g:eachError>
  </ul>
</g:hasErrors>

<g:hiddenField name="id" value="${user?.id}" />

<g:hiddenField name="product.id" value="${params?.product?.id}" />


<div class="form-group ${hasErrors(bean: userInstance, field: 'username', 'has-error')}">
  
  <label for="username" class="col-sm-2 control-label">
    <g:message code="user.username.label" default="Username" />
    <span class="required-indicator">*</span>
  </label>
  <div class="col-sm-10">
    <g:textField name="username" required="" value="${userInstance?.username}" class="form-control"/>
  </div>

</div>


<div class="form-group ${hasErrors(bean: userInstance, field: 'password', 'has-error')}">
  
  <label for="password" class="col-sm-2 control-label">
    <g:message code="user.password.label" default="Password" />
    <span class="required-indicator">*</span>
  </label>
  <div class="col-sm-10">
    <g:passwordField name="password"  required="" value="${userInstance?.password}" class="form-control" />
  </div>

</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'title', 'has-error')}">
  
  <label for="title" class="col-sm-2 control-label">
    <g:message code="user.title.label" default="Title" />
  </label>
  <div class="col-sm-10">
    <g:textField name="title" value="${userInstance?.title}" class="form-control"/>
  </div>

</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'address', 'has-error')}">
  
  <label for="address" class="col-sm-2 control-label">
    <g:message code="user.address.label" default="Address" />
  </label>
  <div class="col-sm-10">
    <g:textField name="address" value="${userInstance?.address}" class="form-control" />
  </div>

</div>



<div class="form-group ${hasErrors(bean: userInstance, field: 'email', 'has-error')}">
  
  <label for="email" class="col-sm-2 control-label">
    <g:message code="user.email.label" default="Email" />
  </label>
  <div class="col-sm-10">
    <g:textField name="email" value="${userInstance?.email}" class="form-control"/>
  </div>

</div>


<div class="form-group ${hasErrors(bean: userInstance, field: 'mobile', 'has-error')}">
  
  <label for="mobile" class="col-sm-2 control-label">
    <g:message code="user.mobile.label" default="Mobile" />
  </label>
  <div class="col-sm-10">
    <g:textField name="mobile" value="${userInstance?.mobile}" class="form-control"/>
  </div>

</div>


<div class="form-group ${hasErrors(bean: userInstance, field: 'telphone', 'has-error')}">
  
  <label for="telphone" class="col-sm-2 control-label">
    <g:message code="user.telphone.label" default="Telphone" />
  </label>
  <div class="col-sm-10">
    <g:textField name="telphone" value="${userInstance?.telphone}" class="form-control"/>
  </div>

</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'description', 'has-error')}">
  
  <label for="description" class="col-sm-2 control-label">
    <g:message code="user.description.label" default="Description" />
  </label>
  <div class="col-sm-10">
    <g:textField name="description" value="${userInstance?.description}" class="form-control"/>
  </div>

</div>


<sec:ifAnyGranted roles="ROLE_ADMIN">

  <g:render template="userRoleTable"  model="[hidden: '']" />

</sec:ifAnyGranted>

<sec:ifNotGranted roles="ROLE_ADMIN">

  <g:render template="userRoleTable"  model="[hidden: 'hidden']" />

</sec:ifNotGranted>


