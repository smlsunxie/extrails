<!DOCTYPE html>
<html>
	<head>
		<title><g:message code="default.home.label"/></title>

	</head>
	<body>
		<div class="container">


    <ul class="nav nav-tabs" id="myTab">
        <li class="active"><a data-toggle="tab" href="#clerks-tab">維修人員</a></li>
        <li class=""><a data-toggle="tab" href="#products-tab">維修產品</a></li>
        <li class=""><a data-toggle="tab" href="#events-tab">維修清單</a></li>
    </ul>
    <div class="tab-content" id="myTabContent">
        <div id="clerks-tab" class="tab-pane fade in active">

          <div class="row-fluid">
            <ul class="thumbnails">
              <g:each var="clerk" data-username="${clerk.username}" in="${clerks}">
                <li class="span3">
                  <a id="clerk" class="thumbnail">
                    <img alt="" src="http://placehold.it/260x180" />

                    <div class="portfolio-grid-1 hp-wrapper bottom-block">
                      <h2>${clerk.username}</h2>
                    </div>

                  </a>
                </li>
              </g:each>
            </ul>
          </div>
        </div>

        <div id="products-tab" class="tab-pane fade">

        </div>

        <div id="events-tab" class="tab-pane fade">
        </div>
    </div>
    <h2>回報維修歷程</h2>
    <div id="accordion2" class="accordion">


        <div class="accordion-group">
            <div class="accordion-heading">
                <a href="#collapseOne" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle e">
                    狀態
                </a>
            </div>
            <div class="accordion-body in collapse" id="collapseOne" style="height: auto;">
                <div class="accordion-inner">

                  <g:form action="save" class="form-horizontal"> 
                    <div class="control-group">
                        <label class="control-label required" for="name">
                            <%--內容標題--%>
                            <g:message code="user.username.label" />
                            <%--必填--%>
                            <span class="required-mark">*</span>
                        </label>
                        <div class="controls">
                            <g:textField name="username" readonly value="${clerk?.username}" class="input input-xlarge" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label required" for="name">
                            <%--內容標題--%>
                            <g:message code="product.name.label" />
                            <%--必填--%>
                            <span class="required-mark">*</span>
                        </label>
                        <div class="controls">
                            <g:textField name="productName" readonly value="${product?.name}" class="input input-xlarge" />
                        </div>
                    </div>
                    <div class="control-group">

                      <label class="control-label required" for="description">

                          <g:message code="default.imageUpload.label" />

                      </label>


                      <g:render template="/attachment/uploadBtn" model="[name:'a',mainImage:'']" />

                    </div>
                    <div class="btn-toolbar" style="margin-bottom: 10px;">
                      <button class="btn">開始</button>
                      <button class="btn">記錄</button>

                      <button class="btn">暫停</button>
                      <button class="btn">完成</button>

                    </div>
                  </g:form>                   
                </div>
            </div>
        </div>

        <div class="accordion-group">
            <div class="accordion-heading">
                <a href="#collapseTwo" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle collapsed">
                    零件
                </a>
            </div>
            <div class="accordion-body collapse" id="collapseTwo" style="height: 0px;">
                <div class="accordion-inner">
                    test
                </div>
            </div>
        </div>
        <div class="accordion-group">
            <div class="accordion-heading">
                <a href="#collapseThree" id="collapserThree" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle collapsed">
                    歷程
                </a>
            </div>
            <div class="accordion-body collapse" id="collapseThree" style="height: 0px;">
                <div class="accordion-inner">
                    test
                </div>
            </div>
        </div>
    </div>


    <div class="toggle-box">
        <div class="tbox-heading">
            <a href="#" class="collapsed">
                歷史記錄
            </a>
        </div>
            <div class="tbox-inner">
                
            </div>
    </div>

                               




    </div>

    <r:script>


      $(function() {
        %{-- $("#collapserThree").click(); --}%

      });


    </r:script>
	</body>
</html>
