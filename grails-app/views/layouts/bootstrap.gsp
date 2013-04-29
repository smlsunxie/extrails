<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><g:layoutTitle default="extrails"/> - 勝祥機車行</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon" />
<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}" />
<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}" />

<r:require modules="jquery, jquery-ui, modernizr, common, font-awesome, pagedown, compass, tagit, fileuploader"/>

<g:layoutHead/>
<r:layoutResources />
<ga:trackPageview />
%{-- <g:justfont /> --}%
%{-- <google:analytics /> --}%
</head>
<body data-spy="scroll" data-target=".bs-docs-sidebar">
<!-- THE LINE AT THE VERY TOP OF THE PAGE -->
        <div class="top_line"></div>
<!-- HEADER AREA -->
        <header>
            <g:applyLayout name="inc_header" />



        </header>
                <%--快閃訊息--%>

<%--畫面可視區域：起點--%>

<div class="blur-after-modal-shown">


<div role="main" class="main-content">

    <%--GoogleChromeFrame--%>
    <g:render template="/layouts/alert_chromeframe" />

	<%--主畫面內容--%>
    <div class="container">

        



        <g:render template="/layouts/navbar" />
 
            <div class="row">
                <div class="span12" id="alert_placeholder">

                </div>
            </div>
	   <g:layoutBody/>

    </div>

</div>

<footer id="footer">
	<g:applyLayout name="inc_footer" />
</footer>
</div>

<%--畫面可視區域：終點--%>


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
