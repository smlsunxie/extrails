
        <table class="table">
          <thead>
            <tr>
              <th width="10%"><g:message code="attachment.mainImage.label" /></th>
              <th width="20%"><g:message code="attachment.file.name" /></th>
              <th ><g:message code="attachment.file.link" /></th>
              <th ></th>
            </tr>
          </thead>
          <tbody>

            <g:each in="${files}" var="file" status="i">
              


              <tr>
                  <td>

                    <g:radio name="mainImage" value="${file.name}" checked="${mainImage==file.name||(mainImage=='' && i==0) ?'true':''}" /></td>
                  <td><g:link action="show" params="[file: file.name, name:name]" target="_blank">${file.name}</g:link></td>

                  <td><g:if test="${['.jpg','.jpeg','.JPG','.JPEG','.gif','.GIF','.png','.PNG'].any{file.name.endsWith(it)}}">
                      <pre>![${file.name}](${createLink(action:'show', params: [file: file.name, name:name])})</pre></td>
                  </g:if>
                  <td><g:remoteLink onSuccess="displayList()" action="delete" params="[name:name, file:file.path]" update="success" class="btn">${message(code: 'default.button.delete.label', default: '刪除')}</g:remoteLink></td>
              </tr>

            </g:each>
          </tbody>


