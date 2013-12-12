<%@ page import="motoranger.User" %>


<g:hiddenField name="product.id"  value="${params?.product?.id}" />


<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="user.username.label" default="Username" />
    <span class="required-indicator">*</span>
  </label>
  <div class="col-sm-10">
    <g:textField name="username" required="" value="${userInstance?.username}" class="form-control"/>
  </div>

</div>



<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="user.password.label" default="Password" />
    <span class="required-indicator">*</span>
  </label>
  <div class="col-sm-10">
    <g:textField name="password" required="" value="${userInstance?.password}" class="form-control" />
  </div>

</div>










<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="user.address.label" default="Address" />
  </label>
  <div class="col-sm-10">
    <g:textField name="address" value="${userInstance?.address}" class="form-control" />
  </div>

</div>

<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="user.description.label" default="Description" />
  </label>
  <div class="col-sm-10">
    <g:textField name="description" value="${userInstance?.description}" class="form-control"/>
  </div>

</div>

<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="user.email.label" default="Email" />
  </label>
  <div class="col-sm-10">
    <g:textField name="email" value="${userInstance?.email}" class="form-control"/>
  </div>

</div>





<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="user.mobile.label" default="Mobile" />
  </label>
  <div class="col-sm-10">
    <g:textField name="mobile" value="${userInstance?.mobile}" class="form-control"/>
  </div>

</div>




<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="user.telphone.label" default="Telphone" />
  </label>
  <div class="col-sm-10">
    <g:textField name="telphone" value="${userInstance?.telphone}" class="form-control"/>
  </div>

</div>

<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="user.title.label" default="Title" />
  </label>
  <div class="col-sm-10">
    <g:textField name="title" value="${userInstance?.title}" class="form-control"/>
  </div>

</div>


<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <div class="checkbox">
      <label>
        <g:checkBox name="enabled" value="${userInstance?.enabled}" /> 
        <g:message code="user.enabled.label" default="Enabled" />
      </label>
    </div>
  </div>
</div>


<sec:ifAnyGranted roles="ROLE_MANERGER,ROLE_ADMIN">

<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="user.store.label" default="Store" />
  </label>
  <div class="col-sm-10">
    <g:select id="store" name="store.id" from="${storeList}" optionKey="id" value="${userInstance?.store?.id}" class="many-to-one" noSelection="['null': '']" class="form-control" />
  </div>

</div>

<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <div class="checkbox">
      <label>
        <g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
        <g:message code="user.passwordExpired.label" default="Password Expired" />
      </label>
    </div>
  </div>
</div>




<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <div class="checkbox">
      <label>
        <g:checkBox name="accountExpired" value="${userInstance?.accountExpired}"  /> 
        <g:message code="user.accountExpired.label" default="Account Expired" />
      </label>
    </div>
  </div>
</div>

<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <div class="checkbox">
      <label>
        <g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" /> 
        <g:message code="user.accountLocked.label" default="Account Locked" />
      </label>
    </div>
  </div>
</div>


<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="role.authority.label" default="authority" />
  </label>
  <div class="col-sm-10">
    <table class="table">

      <tbody>
        <g:each in="${roles}" var="role" status="i">

          <tr>

            <td><g:checkBox name="userRoles" value="${role.authority}" checked="${userRoles?.role?.contains(role)}" /></td>
            <td>${role.authority}</td>

            </tr>

        </g:each>

      </tbody>
    </table> 
  </div>

</div>


</sec:ifAnyGranted>




