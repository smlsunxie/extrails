                <p></p>

                <div class="control-group">
                    <label class="control-label required" for="username">
                        <g:message code="user.username.label" />
                    </label>
                    <div class="controls">
                        <g:textField name="username" value="${user?.username}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label required" for="userTitle">
                        <g:message code="user.title.label" />
                    </label>
                    <div class="controls">
                        <g:textField name="userTitle" value="${user?.title}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label required" for="userTelphone">
                        <g:message code="user.telphone.label" />
                    </label>
                    <div class="controls">
                        <g:field  type="number" name="userTelphone" value="${user?.telphone}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label required" for="userMobile">
                        <g:message code="user.mobile.label" />
                    </label>
                    <div class="controls">
                        <g:field  type="number" name="userMobile" value="${user?.mobile}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label required" for="userDescription">
                        <g:message code="user.description.label" />
                    </label>
                    <div class="controls">
                        <g:textField name="userDescription" value="${user?.description}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>
                </div>


