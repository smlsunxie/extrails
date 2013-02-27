<html>
  <head>
    <title><g:message code="default.post.create.title"/></title>


  </head>
  <body>

    <header class="jumbotron subhead" id="overview">
        <g:render template="inc_subhead" />
    </header>


    <div class="container">
        

        <g:form action="save" class="form-horizontal">
          <div class="control-group">
              <div class="controls">
                  <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                  <g:link class="btn">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
              </div>
          </div>
          <div class="bs-docs-example">
            <ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#setup" data-toggle="tab">設置</a></li>
              <li class=""><a href="#content" data-toggle="tab">編輯</a></li>
              <li class=""><a href="#preview" data-toggle="tab">預覽</a></li>
            </ul>
            <div id="myTabContent" class="tab-content">
              
              <div class="tab-pane fade in active" id="setup">
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
                        <g:textField name="name" value="${post?.name}" class="input input-xlarge" />
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

%{--                <div class="control-group advanced-region">
                  <label class="control-label" for="authors">
                      <%--作者--%>
                      <g:message code="content.authors.label" />
                  </label>
                  <div class="controls">
                      <g:textField name="authors" value="${content?.authors}" class="input input-medium" />
                  </div>
                </div> --}%

              </div>

              <div class="tab-pane fade" id="content">

                    <div class="wmd-panel wmd-editor">
                        <div id="wmd-button-bar"></div>
                        <g:textArea name="content" cols="40" rows="20" value="${post?.content}" class="wmd-input enable-tabkey" id="wmd-input" />
                    </div>


              </div>

              <div class="tab-pane fade" id="preview">
                <div id="wmd-preview" class="wmd-panel wmd-preview"></div>
              </div>

            </div>
          </div>
        </g:form>

    </div> 

  </body>
</html>
