

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
                    <g:select name="productId" from="${extrails.Product.list()}" optionValue="name" 
                    noSelection="${['null':'Select One...']}" optionKey="id"
                     value="${post?.product?.id ?: session?.productId }" />
                  </div>

                </div>

               <div class="control-group advanced-region">
                  <label class="control-label" for="type">
                      <%--post.type--%>
                      <g:message code="post.type.label" />
                  </label>


                  <div class="controls">
                    <g:select name="type" from="${extrails.PostType?.values()}" keys="${extrails.PostType.values()*.name()}" required="" value="${post?.type?.name()}"  valueMessagePrefix="extrails.PostType" />
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

                <p>

                  假設我有一台 YAMAHA FZ150 要賣三萬元，100年份，三萬公里要賣，則「文章類型」選擇拍賣，標籤標上 [YAMAHA,三萬元,100年份,三萬公里]
                </p>

    <r:script>


      $(function() {
        $("#productId").select2();
      });



    </r:script>
