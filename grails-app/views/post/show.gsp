
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${post?.title}</title>
</head>
<body>




<div class="container">
          <sec:ifAllGranted roles="ROLE_ADMIN">
          <div class="control-group">
              <div class="controls">

                  <!--controls-->
                  <g:if test="${!post?.id}">
                      <g:link  class="btn btn-primary" controller="post" action="create" params="[name: post?.name]"><g:message code="default.button.create.label" /></g:link>
                  </g:if>
                  <g:else>
                      <g:link  class="btn btn-primary" controller="post" action="edit" id="${post?.id}"><g:message code="default.button.edit.label" /></g:link>
                  </g:else>

              </div>
          </div>
          </sec:ifAllGranted>

    <div class="row-fluid">
        <div class="span12 clearlook-wrapper">




          
          <div class="markdown-source">${post?.content?.encodeAsHTML()}</div>
          
          <hr />
          
          <small><g:message code="post.lastUpdated.label" default="Last Updated" />: <g:formatDate date="${post?.lastUpdated}" type="datetime" style="MEDIUM" /></small>
          

        </div>
    </div>
</div>
</body>
</html>
