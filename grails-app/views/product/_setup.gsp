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




               <div class="control-group advanced-region">
                  <label class="control-label" for="tags">
                      <%--tags--%>
                      <g:message code="product.tags.label" />
                  </label>


                  <div class="controls">
                    <ul name="tags" id='tag-field'>
                      <g:each in="${product.tags}">
                        <li>${it}</li>
                      </g:each>
                    </ul>
                  </div>

                </div>

                <div class="control-group">

                    <label class="control-label required" for="description">
                        <%--簡短敘述--%>
                        <g:message code="product.description.label" />

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
                    <g:select name="owner" from="${extrails.ProductOwner?.values()}" keys="${extrails.ProductOwner.values()*.name()}" required="" value="${product?.owner?.name()}"  valueMessagePrefix="extrails.ProductOwner" />
                  </div>

                </div>


                <div class="control-group">

                    <label class="control-label required" for="years">
                        <g:message code="product.years.label" />

                    </label>
                    <div class="controls">
                        <g:datePicker name="years" value="${product.years}"
              noSelection="['':'-Choose-']" precision="year" />
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

                        <g:message code="product.imageUpload.label" />

                    </label>
                    <div class="controls">
                    <uploader:uploader  id="fileupload" url="${[controller:'attachment', action:'save']}" params='[name:product.name]' >
                      <uploader:onComplete>
                        displayList();
                      </uploader:onComplete>
                    </uploader:uploader>
                    </div>
                    
                    <hr/>




                    <div  class="row-fluid">
                      <div id="images" class="span12">
                      </div>
                    </div>
                  <div class="control-group">
                    <div  class="row-fluid">
                      <div id="images">
                      </div>
                    </div>
                  </div>


<r:script>
  var displayList=function(){
    <g:remoteFunction controller='attachment' action="list" params="[name:product.name, mainImage: product?.mainImage]" update="images" />
  }

  $(function() {
    displayList();
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