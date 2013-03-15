<html>
  <head>
    <title><g:message code="default.part.create.title"/></title>


  </head>
  <body>


    <div class="container">

        <g:form action="save" class="form-horizontal">        
          <div class="row show-frid">
              <div class="span12">
                  <div id="breadcrumb">
                        <ul >
                          <li class="home btn btn-mini btn-link">post</li>
                          <li ><g:submitButton name="create"  class="btn btn-primary btn-mini" value="${message(code: 'default.button.create.label', default: 'Create')}" /></li>
                          <li><g:link action='list' class="btn btn-mini">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link></li>
                            
                        </ul>
                  </div>
              </div>
          </div>



          <div class="bs-docs-example">


                <div class="control-group">
                    <label class="control-label required" for="name">

                        <g:message code="part.title.label" />
                        <%--必填--%>
                        <span class="required-mark">*</span>
                    </label>
                    <div class="controls">
                        <g:textField name="title" readonly value="${part?.title}" class="input input-xlarge" />
                    </div>
                </div>




               <div class="control-group advanced-region">
                  <label class="control-label" for="tags">
                      <%--tags--%>
                      <g:message code="part.tags.label" />
                  </label>


                  <div class="controls">
                    <ul name="tags" id='tag-field'>
                      <g:each in="${part.tags}">
                        <li>${it}</li>
                      </g:each>
                    </ul>
                  </div>

                </div>

                <div class="control-group">

                    <label class="control-label required" for="description">
                        <%--簡短敘述--%>
                        <g:message code="part.description.label" />

                    </label>
                    <div class="controls">
                        <g:textField name="description" value="${part?.description}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>
                </div>
                <div class="control-group">

                    <label class="control-label required" for="description">

                        <g:message code="part.cost.label" />

                    </label>
                    <div class="controls">
                        <g:field  type="number" name="cost" value="${part?.cost}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>

                </div>

                <div class="control-group">

                    <label class="control-label required" for="description">

                        <g:message code="part.price.label" />

                    </label>
                    <div class="controls">
                        <g:field  type="number" name="price" value="${part?.price}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>

                </div>

                <div class="control-group">

                    <label class="control-label required" for="description">

                        <g:message code="part.stockCount.label" />

                    </label>
                    <div class="controls">
                        <g:field  type="number" name="price" value="${part?.stockCount}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>

                </div>
                <div class="control-group">

                    <label class="control-label required" for="description">

                        <g:message code="part.mainImage.label" />

                    </label>
                    <div class="controls">
                    <uploader:uploader  id="fileupload" url="${[ action:'attachmentSave']}" params='[name:part.name]' >
                      <uploader:onComplete>
                        displayList();
                      </uploader:onComplete>
                    </uploader:uploader>
                    </div>

                </div>

          </div>

        </g:form>

    </div> 
    <r:script>


      $(function() {

        $("ul[name='tags']").tagit({select:true, tagSource: "${g.createLink(controller:'tag',action: 'listAsJson')}"});

      });


    </r:script>
  </body>
</html>
