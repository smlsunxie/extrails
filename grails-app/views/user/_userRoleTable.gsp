<div class="form-group">
  
  <label for="inputEmail3" class="col-sm-2 control-label">
    <g:message code="user.store.label" default="Store" />
  </label>
  <div class="col-sm-10">
    <g:select readonly='${readonly}' id="store" name="store.id" from="${storeList}" optionKey="id" value="${userInstance?.store?.id}" class="many-to-one" noSelection="['null': '']" class="form-control" />
  </div>

</div>

<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <div class="checkbox">
      <label>
        <g:checkBox readonly='${readonly}' name="passwordExpired" value="${userInstance?.passwordExpired}" />
        <g:message code="user.passwordExpired.label" default="Password Expired" />
      </label>
    </div>
  </div>
</div>




<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <div class="checkbox">
      <label>
        <g:checkBox readonly='${readonly}' name="accountExpired" value="${userInstance?.accountExpired}"  /> 
        <g:message code="user.accountExpired.label" default="Account Expired" />
      </label>
    </div>
  </div>
</div>

<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <div class="checkbox">
      <label>
        <g:checkBox readonly='${readonly}' name="accountLocked" value="${userInstance?.accountLocked}" /> 
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

            <td><g:checkBox readonly='${readonly}' name="userRoles" value="${role.authority}" checked="${userRoles?.role?.contains(role)}" /></td>
            <td>${role.authority}</td>

            </tr>

        </g:each>

      </tbody>
    </table> 
  </div>

</div>
