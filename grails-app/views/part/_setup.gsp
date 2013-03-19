                <div class="control-group">
                    <label class="control-label required" for="name">

                        <g:message code="part.name.label" />
                        <%--必填--%>
                        <span class="required-mark">*</span>
                    </label>
                    <div class="controls">
                        <g:textField name="name" readonly value="${part?.name}" class="input input-xlarge" />
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label required" for="title">

                        <g:message code="part.title.label" />
                        <%--必填--%>
                        <span class="required-mark">*</span>
                    </label>
                    <div class="controls">
                        <g:textField name="title" value="${part?.title}" class="input input-xlarge" />
                    </div>
                </div>




               <div class="control-group advanced-region">
                  <label class="control-label" for="tags">
                      <%--tags--%>
                      <g:message code="default.tags.label" />
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
                        <g:message code="default.description.label" />

                    </label>
                    <div class="controls">
                        <g:textField name="description" value="${part?.description}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>
                </div>
                <div class="control-group">

                    <label class="control-label required" for="description">

                        <g:message code="default.cost.label" />

                    </label>
                    <div class="controls">
                        <g:field  type="number" name="cost" value="${part?.cost}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>

                </div>

                <div class="control-group">

                    <label class="control-label required" for="description">

                        <g:message code="default.price.label" />

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

                        <g:message code="default.imageUpload.label" />

                    </label>
                    <div class="controls">
                    <uploader:uploader  id="fileupload" url="${[controller:'attachment', action:'save']}" params='[name:part.name]' >
                      <uploader:onComplete>
                        displayList();
                      </uploader:onComplete>
                    </uploader:uploader>
                    </div>
                    
                    <hr/>




                    <div  class="row-fluid">
                      <div id="images" class="span12">
                      </div>
                    </div>
                  <div class="control-group">
                    <div  class="row-fluid">
                      <div id="images">
                      </div>
                    </div>
                  </div>


    <r:script>
      var displayList=function(){
        <g:remoteFunction controller='attachment' action="list" params="[name:part.name, mainImage: part?.mainImage]" update="images" />
      }

      $(function() {
        displayList();
        $("ul[name='tags']").tagit({select:true, tagSource: "${g.createLink(controller:'tag',action: 'listAsJson')}"});

      });

      var showConfirm=function(){
        return confirm("${message(code: 'default.button.delete.confirm.message')}");
      }




    </r:script>