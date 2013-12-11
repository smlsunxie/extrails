<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><g:layoutTitle default="motoranger"/> - 勝祥機車行</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon" />
<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}" />
<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}" />

<r:require modules="jquery, jquery-ui, modernizr, common, font-awesome, pagedown, compass, tagit, fileuploader, bootstrap-ext"/>

<g:layoutHead/>
<r:layoutResources />
<ga:trackPageview />
%{-- <g:justfont /> --}%
%{-- <google:analytics /> --}%
</head>
<body>

  <div id="load" style="position:fixed; top:0; left:0; right:0; bottom:0; background:#fff; z-index:999999;"><span></span></div>
  
  <div class="container"></div>
  
  <div id="over">
    <div id="out_container">
      <div class="top_line"></div>
      
      <header>
        <g:applyLayout name="inc_header" />
      </header>


      <div class="main-content">
        <%--GoogleChromeFrame--%>
        <g:render template="/layouts/alert_chromeframe" />

      	<%--主畫面內容--%>
        <div class="container">
          <g:render template="/layouts/navbar" />

          <div class="row">
            <div class="col-sm-12 col-md-12" id="alert_placeholder"></div>
          </div>

          <g:layoutBody/>

        </div>
      </div>


      <footer id="footer">
        <g:set var="springSecurityService" bean="springSecurityService"/>

        <g:if test="${store}">
          <g:applyLayout name="inc_footer_store" />
        </g:if>
        <g:else>
          <g:applyLayout name="inc_footer" />
        </g:else>
      	

        <div class="footer-bottom">
          <div class="container">
            <div class="row show-grid">
              <div class="col-sm-12 col-md-12">
                <p>Template by bizstrap power by <a href="http://ccws.co">ccws</a></p>

              </div>
            </div>
          </div>
        </div>
      </footer>

    </div>
  </div>



  <r:script>

    bootstrap_alert = function() {}
    bootstrap_alert.warning = function(message) {
                $('#alert_placeholder').html('<div class="alert"><a class="close" data-dismiss="alert">×</a><span>'+message+'</span></div>')
            }

    if('${flash.message}'!=='') bootstrap_alert.warning('${flash.message}');


    var onSuccessFun=function(data){
  		
      var unreciveMoneyElm=$("#unreceiveMoney_"+data.event.id);
      var receivedMoney=data.event.receivedMoney;
      var initValue=unreciveMoneyElm.attr("data-initValue");
      var unreciveMoney=initValue-receivedMoney;

      if(data.success){
       

        if(unreciveMoney<0)unreciveMoney=0;

        unreciveMoneyElm.val(unreciveMoney);

        bootstrap_alert.warning("已收金額已更新為："+data.event.receivedMoney)
      }else {

        var receivedMoneyElm=$("[id='"+data.event.id+"'][name='receivedMoney']");
        receivedMoneyElm.val(data.event.receivedMoney)

        bootstrap_alert.warning(data.msg)
        unreciveMoneyElm.val(unreciveMoney);
      }
    }

  </r:script>

  <r:layoutResources />



</body>
</html>
