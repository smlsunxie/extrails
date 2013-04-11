<!DOCTYPE html>
<html>
  <head>
        <title><g:message code="${controllerName}.${actionName}.title"/></title>
  </head>
  <body>



      <g:form action="save" class="form-horizontal"> 

          <g:actionbar actionName="${actionName}" domain="${event}" />


          <div class="bs-docs-example">
            <g:render template="setup" />
          </div>

 
        </g:form>

%{--     <r:script>
      $(function() {
        $("#user").select2();
        $("#product").select2();

      });
    </r:script> --}%
  </body>
</html>
