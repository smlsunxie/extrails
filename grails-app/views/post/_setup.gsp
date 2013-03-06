

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

                <div class="control-group">

                    <label class="control-label required" for="title">
                        <%--內容標題--%>
                        <g:message code="post.title.label" />
                        <%--必填--%>
                        <span class="required-mark">*</span>
                    </label>
                    <div class="controls">
                        <g:textField name="title" value="${post?.title}" class="input input-xlarge" />
                    </div>
                </div>

               <div class="control-group advanced-region">
                  <label class="control-label" for="tags">
                      <%--tags--%>
                      <g:message code="post.tags.label" />
                  </label>


                  <div class="controls">
                    <ul name="tags" id='tag-field'>
                      <g:each in="${post.tags}">
                        <li>${it}</li>
                      </g:each>
                    </ul>
                  </div>

                </div>
                <p>
                  屬於「新聞」請打上標籤：news
                </p>
                <p>
                  屬於「維修實況」請打上標籤：demo
                </p>
                <p>
                  屬於「拍賣」請打上標籤：sale
                </p>
                <p>
                  假設我有一台 YAMAHA FZ150 要賣三萬元，100年份，三萬公里要賣，則可以標上 [sale,YAMAHA,三萬元,100年份,三萬公里]，如此就可透過標籤索引相關的商品
                </p>


