              <g:hiddenField name="returnUrl" value="${params.returnUrl}" />
              <div class="control-group">
                  <label class="control-label required" for="name">
                      <g:message code="default.name.label" />

                  </label>
                  <div class="controls">
                      <g:textField  name="name" readonly value="${eventDetail?.name}" class="input input-xlarge" />
                  </div>
              </div>

              <div class="control-group">
                  <label class="control-label required" for="description">
                      <g:message code="eventDetail.head.label" />

                  </label>
                  <div class="controls">
                    <g:select name="head.id" from="${eventDetail?.head ?: extrails.Event.list()}" 
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
                      <g:select name="part.id" from="${eventDetail?.part ?: extrails.Part.list()}" optionValue="name" 
                      noSelection="${[null:'Select One...']}" optionKey="id" value="${eventDetail?.part?.id}" />
                    </div>
              </div>
              <div class="control-group">

                  <label class="control-label required" for="description">

                      <g:message code="eventDetail.price.label" />

                  </label>
                  <div class="controls">
                      <g:field  type="number" name="price" value="${eventDetail?.price}" class="input input-xlarge" />
                      <span class="help-inline"></span>
                  </div>

              </div>

              <div class="control-group">

                  <label class="control-label required" for="description">

                      <g:message code="eventDetail.qty.label" />

                  </label>
                  <div class="controls">
                      <g:field  type="number" name="qty" value="${eventDetail?.qty}" class="input input-xlarge" />
                      <span class="help-inline"></span>
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




              <div class="control-group">

                <label class="control-label required" for="description">

                    <g:message code="default.imageUpload.label" />

                </label>


                <g:render template="/attachment/uploadBtn" model="[name:eventDetail?.name,mainImage:eventDetail?.mainImage]" />

              </div>