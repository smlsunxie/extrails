            <ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#setup" data-toggle="tab">設置</a></li>
              <li class=""><a href="#imagesTab" data-toggle="tab">圖片</a></li>
              <li class=""><a href="#content" data-toggle="tab">編輯</a></li>
              <li class=""><a href="#preview" data-toggle="tab">預覽</a></li>

            </ul>
            <div id="myTabContent" class="tab-content">
              
              <div class="tab-pane fade in active" id="setup">


                <div class="control-group">
                    <label class="control-label required" for="name">
                        <%--內容標題--%>
                        <g:message code="post.name.label" />
                        <%--必填--%>
                        <span class="required-mark">*</span>
                    </label>
                    <div class="controls">
                        <g:textField name="name" readonly value="${post?.name}" class="input input-xlarge" />
                    </div>
                </div>

                <div class="control-group info">

                    <label class="control-label required" for="title">
                        <%--內容標題--%>
                        <g:message code="post.title.label" />
                        <%--必填--%>
                        <span class="required-mark">*</span>
                    </label>
                    <div class="controls">
                        <g:textField name="title" value="${post?.title}" class="input input-xlarge" />
                        <span class="help-inline">務必輸入欄位</span>
                    </div>
                </div>

               <div class="control-group advanced-region">
                  <label class="control-label" for="product">
                      <%--post.type--%>
                      <g:message code="post.product.label" />
                  </label>


                  <div class="controls">
                    <g:select name="product.id" from="${motoranger.Product.list()}" 
                    noSelection="${['null':'Select One...']}" optionKey="id"
                     value="${post?.product?.id}" />
                  </div>

                </div>

               <div class="control-group advanced-region">
                  <label class="control-label" for="type">
                      <%--post.type--%>
                      <g:message code="post.type.label" />
                  </label>


                  <div class="controls">
                    <g:select name="type" from="${motoranger.PostType?.values()}" keys="${motoranger.PostType.values()*.name()}" required="" value="${post?.type?.name()}"  valueMessagePrefix="PostType" />
                  </div>

                </div>

               <div class="control-group advanced-region">
                  <label class="control-label" for="tags">
                      <%--tags--%>
                      <g:message code="default.tags.label" />
                  </label>


                  <div class="controls">
                    <ul name="tags" id='tag-field'>
                      <g:each in="${post.tags}">
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
                        <g:textField name="description" value="${post?.description}" class="input input-xlarge" />
                        <span class="help-inline">對文章內容的簡短敘述，將顯示在瀏覽所有文章頁面</span>
                    </div>
                </div>
                

              </div>

              %{-- 編輯區域 tab --}%
              <div class="tab-pane fade" id="content">

                <div class="row">

                  <div class="col-sm-4 col-md-4">
                    <g:render template="md_help" />

                  </div>
                  <div class="span8">
                    <div class="wmd-panel wmd-editor">
                        <div id="wmd-button-bar"></div>
                        <g:textArea name="content" cols="40" rows="20" value="${post?.content}" class="wmd-input enable-tabkey" id="wmd-input" />
                    </div>                    
                  </div>

                </div>






              </div>

              %{-- preview tab --}%
              <div class="tab-pane fade" id="preview">
                <div id="wmd-preview" class="wmd-panel wmd-preview"></div>


              </div>

              %{-- 圖片 tab --}%
              <div class="tab-pane fade" id="imagesTab">

                <div class="row">

                    <g:render template="/attachment/uploadBtn" model="[name:post.name ,mainImage: post?.mainImage]" />  
                </div>

              </div>

            </div>

    <r:script>


      $(function() {
        $("ul[name='tags']").tagit({select:true, tagSource: "${g.createLink(controller:'tag',action: 'listAsJson')}"});

      });


    </r:script>
