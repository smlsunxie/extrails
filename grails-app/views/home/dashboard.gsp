<!DOCTYPE html>
<html>
	<head>
		<title><g:message code="default.home.label"/></title>

	</head>
	<body>
		<div class="container">


    <ul class="nav nav-tabs" id="myTab">
        <li class=""><a data-toggle="tab" href="#home">維修人員</a></li>
        <li class=""><a data-toggle="tab" href="#another-tab">維修產品</a></li>
        <li class="active"><a data-toggle="tab" href="#last-tab">維修清單</a></li>
    </ul>
    <div class="tab-content" id="myTabContent">
        <div id="home" class="tab-pane fade active in">

        </div>

        <div id="another-tab" class="tab-pane fade">

        </div>

        <div id="last-tab" class="tab-pane fade">
        </div>
    </div>
    <h2>回報維修歷程</h2>
    <div id="accordion2" class="accordion">
        <div class="accordion-group">
            <div class="accordion-heading">
                <a href="#collapseOne" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle collapsed">
                    狀態
                </a>
            </div>
            <div class="accordion-body collapse" id="collapseOne" style="height: 0px;">
                <div class="accordion-inner">
                  <div class="btn-toolbar" style="margin-bottom: 10px;">
                    <button class="btn">開始</button>
                    <button class="btn">記錄</button>

                    <button class="btn">暫停</button>
                    <button class="btn">完成</button>

                  </div>
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
                    
                </div>
            </div>
        </div>
        <div class="accordion-group">
            <div class="accordion-heading">
                <a href="#collapseThree" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle e">
                    歷程
                </a>
            </div>
            <div class="accordion-body in collapse" id="collapseThree" style="height: auto;">
                <div class="accordion-inner">
                    
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
	</body>
</html>
