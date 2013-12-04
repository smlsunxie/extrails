           <div class="control-group">
                <label class="control-label required" for="name">
                    <g:message code="event.name.label" />

                </label>
                <div class="controls">
                    <g:textField name="name" value="${event?.name}" readonly class="input input-xlarge" />
                </div>                 
            </div>

            <div class="control-group">
              <label class="control-label required" for="user">
                  <g:message code="user.username.label" />

              </label>
                <div class="controls">
                  <g:select name="user.id" from="${event?.user ?: motoranger.UserRole.findAllByRole(motoranger.Role.findByAuthority('ROLE_OPERATOR'))*.user}" optionValue="username" 
                  noSelection="${[null:'Select One...']}" optionKey="id" value="${event?.user?.id}" />
                </div>                    
            </div>

            <div class="control-group">
                <label class="control-label required" for="name">

                    <g:message code="event.product.label" />
                </label>
                  <div class="controls">
                    <g:select name="product.id" from="${event?.product?:motoranger.Product.list()}" optionValue="name" 
                    noSelection="${[null:'Select One...']}" optionKey="id" value="${event?.product?.id}" />
                  </div>
            </div>



            <div class="control-group">
                <label class="control-label required" for="mileage">
                    <g:message code="event.mileage.label" />

                </label>
                <div class="controls">
                    <g:field type='number' name="mileage" value="${event.mileage}" class="input input-xlarge" />
                </div>
            </div>


            <div class="control-group">

                <label class="control-label required" for="date">
                    <g:message code="event.date.label" />

                </label>
                <div class="controls">
                    <g:datePicker name="date" value="${event.date}"
          noSelection="['':'-Choose-']" precision="day" years="${(new Date().getAt(Calendar.YEAR)-1)..(new Date().getAt(Calendar.YEAR))}" />
                    <span class="help-inline"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label required" for="description">
                    <g:message code="default.description.label" />

                </label>
                <div class="controls">
                    <g:textField  name="description" value="${event?.description}" class="input input-xlarge" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label required" for="description">
                    <g:message code="user.store.label" default="Store" />

                </label>
                <div class="controls">
                   <g:select id="store" name="store.id" from="${motoranger.Store.list()}" optionKey="id" value="${event?.store?.id}" class="many-to-one" noSelection="['null': '']"/>
                </div>
            </div>

