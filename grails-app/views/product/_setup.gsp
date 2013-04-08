                <div class="control-group">
                    <label class="control-label required" for="name">

                        <g:message code="product.name.label" />
                        <%--必填--%>
                        <span class="required-mark">*</span>
                    </label>
                    <div class="controls">
                        <g:textField name="name" readonly value="${product?.name}" class="input input-xlarge" />
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label required" for="title">

                        <g:message code="product.title.label" />
                        <%--必填--%>
                        <span class="required-mark">*</span>
                    </label>
                    <div class="controls">
                        <g:textField name="title" value="${product?.title}" class="input input-xlarge" />
                    </div>
                </div>




%{--                <div class="control-group advanced-region">
                  <label class="control-label" for="tags">
                      <%--tags--%>
                      <g:message code="default.tags.label" />
                  </label>


                  <div class="controls">
                    <ul name="tags" id='tag-field'>
                      <g:each in="${product?.tags}">
                        <li>${it}</li>
                      </g:each>
                    </ul>
                  </div>

                </div> --}%

                <div class="control-group">

                    <label class="control-label required" for="description">
                        <%--簡短敘述--%>
                        <g:message code="default.description.label" />

                    </label>
                    <div class="controls">
                        <g:textField name="description" value="${product?.description}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>
                </div>


                <div class="control-group">

                    <label class="control-label required" for="mileage">
                        <g:message code="product.mileage.label" />

                    </label>
                    <div class="controls">
                        <g:field name="mileage" type="number" value="${product?.mileage}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>
                </div>

               <div class="control-group advanced-region">
                  <label class="control-label" for="owner">
                      <%--post.type--%>
                      <g:message code="product.owner.label" />
                  </label>


                  <div class="controls">
                    <g:select name="owner" from="${extrails.ProductOwner?.values()}" keys="${extrails.ProductOwner.values()*.name()}" required="" value="${product?.owner?.name()}"  valueMessagePrefix="ProductOwner" />
                  </div>

                </div>

                <div class="control-group">
                  <label class="control-label required" for="name">
                      <g:message code="user.username.label" />

                  </label>
                    <div class="controls">
                      <g:select name="user" from="${extrails.User.list()}" optionValue="username" 
                      noSelection="${[null:'Select One...']}" optionKey="id" value="${product?.user?.id}" />
                    </div>                    
                </div>

               <div class="control-group advanced-region">
                  <label class="control-label" for="owner">
                      <%--post.type--%>
                      <g:message code="product.brand.label" />
                  </label>


                  <div class="controls">
                    <g:select name="brand" from="${extrails.ProductBrand?.values()}" keys="${extrails.ProductBrand.values()*.name()}" required="" value="${product?.brand?.name()}"  valueMessagePrefix="ProductBrand" />
                  </div>

                </div>

                <div class="control-group">

                    <label class="control-label required" for="years">
                        <g:message code="product.years.label" />

                    </label>
                    <div class="controls">
                        <g:datePicker name="years" value="${product.years}"
              noSelection="['':'-Choose-']" precision="month" years="${1980..(new Date().getAt(Calendar.YEAR))}" />
                        <span class="help-inline"></span>
                    </div>
                </div>

                <div class="control-group">

                    <label class="control-label required" for="description">

                        <g:message code="product.cc.label" />

                    </label>
                    <div class="controls">
                        <g:field  type="number" name="cc" value="${product?.cc}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>

                </div>


                <div class="control-group">

                    <label class="control-label required" for="description">

                        <g:message code="product.cost.label" />

                    </label>
                    <div class="controls">
                        <g:field  type="number" name="cost" value="${product?.cost}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>

                </div>

                <div class="control-group">

                    <label class="control-label required" for="description">

                        <g:message code="product.price.label" />

                    </label>
                    <div class="controls">
                        <g:field  type="number" name="price" value="${product?.price}" class="input input-xlarge" />
                        <span class="help-inline"></span>
                    </div>

                </div>


                <div class="control-group">

                  <label class="control-label required" for="description">

                      <g:message code="default.imageUpload.label" />

                  </label>


                  <g:render template="/attachment/uploadBtn" model="[name:product.name,mainImage: product?.mainImage]" />

                </div>


<r:script>


  $(function() {
    $("ul[name='tags']").tagit({select:true, tagSource: "${g.createLink(controller:'tag',action: 'listAsJson')}"});

    var ownerChange=function(selectVal){
      var years=$("#years_year");
      var cost=$("#cost");
      var price=$("#price");
      if(selectVal==='CUSTOMER'){
        price.val(0);
        cost.val(0);
        [years,cost,price].forEach(function(entry){
          entry.attr("readonly",true);
        });

      }else {
        [years,cost,price].forEach(function(entry){
          entry.attr("readonly",false);
        });
      }
    }

    $("#owner").on("change",function(){


      $('option:selected', this).each(function(){
        ownerChange(this.value)
      });
    });

    ownerChange("${product.owner}");

  });

</r:script>