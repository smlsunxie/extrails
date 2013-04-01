<!DOCTYPE html>
<html>
	<head>
    <title><g:message code="${controllerName}.${actionName}.title"/></title>
	</head>
	<body>

      <g:form action="save" class="form-horizontal"> 
          <g:btnbar actionName="${actionName}" domain="${serviceEventDetail}" />



          <div class="bs-docs-example">

              <div class="control-group">
                  <label class="control-label required" for="name">
                      <g:message code="default.name.label" />

                  </label>
                  <div class="controls">
                      <g:textField  name="name" value="${serviceEventDetail?.name}" class="input input-xlarge" />
                  </div>
              </div>

              <div class="control-group">
                  <label class="control-label required" for="description">
                      <g:message code="serviceEventDetail.head.label" />

                  </label>
                  <div class="controls">
                    <g:select name="head" from="${extrails.ServiceEvent.list()}" 
                    noSelection="${[null:'Select One...']}" optionKey="id" value="${serviceEventDetail?.head?.id}" />
                  </div>
              </div>





              <div class="control-group">
                  <label class="control-label required" for="name">
                      <%--內容標題--%>
                      <g:message code="part.name.label" />
                      <%--必填--%>
                  </label>
                    <div class="controls">
                      <g:select name="part" from="${extrails.Part.list()}" optionValue="name" 
                      noSelection="${[null:'Select One...']}" optionKey="id" value="${serviceEventDetail?.part?.id}" />
                    </div>
              </div>


              <div class="control-group">
                  <label class="control-label required" for="description">
                      <g:message code="default.description.label" />

                  </label>
                  <div class="controls">
                      <g:textField  name="description" value="${serviceEventDetail?.description}" class="input input-xlarge" />
                  </div>
              </div>


%{--              <div class="control-group advanced-region">
                <label class="control-label" for="type">
                    <%--post.type--%>
                    <g:message code="serviceEvent.type.label" />
                </label>


                <div class="controls">
                  <g:select name="type" from="${extrails.EventStatus?.values()}" keys="${extrails.EventStatus.values()*.name()}" required="" value="${serviceEventDetail?.head?.status?.name()}"  valueMessagePrefix="extrails.EventStatus" />
                </div>

              </div> --}%


              <div class="control-group">

                <label class="control-label required" for="description">

                    <g:message code="default.imageUpload.label" />

                </label>


                <g:render template="/attachment/uploadBtn" model="[name:serviceEventDetail?.name,mainImage:serviceEventDetail?.mainImage]" />

              </div>



          </div>

 
        </g:form>


    <r:script>


      $(function() {
        $("#user").select2();
        $("#part").select2();
      });



    </r:script>
	</body>
</html>
