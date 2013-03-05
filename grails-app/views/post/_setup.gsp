                <div class="control-group">

                </div>

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



