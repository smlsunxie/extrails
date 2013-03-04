<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><g:layoutTitle default="extrails"/> - extrails</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon" />
<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}" />
<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}" />
<style type="text/css">body {padding-top: 60px;/*padding-bottom: 40px;*/}</style>

<r:require modules="jquery, jquery-ui, modernizr, common, bootstrap-ext, font-awesome, pagedown, compass, tagit, fileuploader"/>

<g:layoutHead/>
<r:layoutResources />
<g:justfont />
<google:analytics />
</head>
<body data-spy="scroll" data-target=".bs-docs-sidebar">

<%--畫面可視區域：起點--%>

<div class="blur-after-modal-shown">

<header class="navbar navbar-inverse navbar-fixed-top hide">
	<g:applyLayout name="inc_header" />
</header>

<div role="main">
    <div class="container-fluid">	
        <%--GoogleChromeFrame--%>
        <g:render template="/layouts/alert_chromeframe" />

        
        <%--快閃訊息--%>
        <g:if test="${flash.message}">
            <div class="alert" role="status">
                <button type="button" class="close" data-dismiss="alert">×</button>
                ${flash.message}
            </div>
        </g:if>
    </div>

	<%--主畫面內容--%>
	<g:layoutBody/>
</div>

<footer class="footer">
	<g:applyLayout name="inc_footer" />
</footer>
</div>

<%--畫面可視區域：終點--%>



<r:script>
$('header.navbar').show();

$(function() {
    $("ul[name='tags']").tagit({select:true, tagSource: "${g.createLink(action: 'tags')}"});
});


</r:script>
<r:layoutResources />
</body>
</html>
