<!DOCTYPE html>
<html>
	<head>
    <title><g:message code="${controllerName}.${actionName}.title"/></title>
	</head>
	<body>

      <g:form action="save" class="form-horizontal"> 
          <g:actionbar actionName="${actionName}" domain="${eventDetail}" />



          <div class="bs-docs-example">

              <div class="control-group">
                  <label class="control-label required" for="name">
                      <g:message code="default.name.label" />

                  </label>
                  <div class="controls">
                      <g:textField  name="name" value="${eventDetail?.name}" class="input input-xlarge" />
                  </div>
              </div>

              <div class="control-group">
                  <label class="control-label required" for="description">
                      <g:message code="eventDetail.head.label" />

                  </label>
                  <div class="controls">
                    <g:select name="head" from="${extrails.Event.list()}" 
                    noSelection="${[null:'Select One...']}" optionKey="id" value="${eventDetail?.head?.id}" />
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
                      noSelection="${[null:'Select One...']}" optionKey="id" value="${eventDetail?.part?.id}" />
                    </div>
              </div>


              <div class="control-group">
                  <label class="control-label required" for="description">
                      <g:message code="default.description.label" />

                  </label>
                  <div class="controls">
                      <g:textField  name="description" value="${eventDetail?.description}" class="input input-xlarge" />
                  </div>
              </div>


%{--              <div class="control-group advanced-region">
                <label class="control-label" for="type">
                    <%--post.type--%>
                    <g:message code="event.type.label" />
                </label>


                <div class="controls">
                  <g:select name="type" from="${extrails.EventStatus?.values()}" keys="${extrails.EventStatus.values()*.name()}" required="" value="${eventDetail?.head?.status?.name()}"  valueMessagePrefix="extrails.EventStatus" />
                </div>

              </div> --}%


              <div class="control-group">

                <label class="control-label required" for="description">

                    <g:message code="default.imageUpload.label" />

                </label>


                <g:render template="/attachment/uploadBtn" model="[name:eventDetail?.name,mainImage:eventDetail?.mainImage]" />

              </div>



          </div>

 
        </g:form>


    <r:script>


      $(function() {

        $("#part").select2();
      });



    </r:script>
	</body>
</html>
