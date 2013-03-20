<!DOCTYPE html>
<html>
	<head>
		<title><g:message code="default.home.label"/></title>

	</head>
	<body>
		<div class="container">

                  <g:form action="save" class="form-horizontal"> 

                      <div class="row show-frid">
                          <div class="span12">
                              <div id="breadcrumb">
                                    <ul >
                                      <li class="home btn btn-mini btn-link">ServiceEvent</li>
                                      <li ><g:submitButton name="create"  class="btn btn-primary btn-mini" value="${message(code: 'default.button.create.label', default: 'Create')}" /></li>
                                      <li><g:link action='list' class="btn btn-mini">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link></li>
                                        
                                    </ul>
                              </div>
                          </div>
                      </div>



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
                            <g:message code="user.username.label" />

                        </label>
                          <div class="controls">
                            <g:select name="user" from="${users}" optionValue="username" 
                            noSelection="${['null':'Select One...']}" optionKey="id" value="${serviceEvent?.user?.id}" />
                          </div>                    
                    </div>

                    <div class="control-group">
                        <label class="control-label required" for="name">

                            <g:message code="product.name.label" />
                        </label>
                          <div class="controls">
                            <g:select name="product" from="${products}" optionValue="name" 
                            noSelection="${['null':'Select One...']}" optionKey="id" value="${product?.id}" />
                          </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label required" for="name">
                            <%--內容標題--%>
                            <g:message code="part.name.label" />
                            <%--必填--%>
                        </label>
                          <div class="controls">
                            <g:select name="part" from="${parts}" optionValue="name" 
                            noSelection="${['null':'Select One...']}" optionKey="id" value="${serviceEvent?.part?.id}" />
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

                    <div class="control-group">

                      <label class="control-label required" for="description">

                          <g:message code="default.imageUpload.label" />

                      </label>


                      <g:render template="/attachment/uploadBtn" model="[name:serviceEvent?.name,mainImage:'']" />

                    </div>

          </div>

 
                  </g:form>
      




        </div>

    <r:script>


      $(function() {
        $("#user").select2();
        $("#product").select2();
        $("#part").select2();

        $('li:not(:has(>ul))', 'ul#menu').live('click', function () {             
            alert($(this).text());
        });



      });



    </r:script>
	</body>
</html>
