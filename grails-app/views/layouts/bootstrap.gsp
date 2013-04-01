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

<r:require modules="jquery, jquery-ui, modernizr, common, font-awesome, pagedown, compass, tagit, fileuploader"/>

<g:layoutHead/>
<r:layoutResources />
%{-- <g:justfont /> --}%
<google:analytics />
</head>
<body data-spy="scroll" data-target=".bs-docs-sidebar">
<!-- THE LINE AT THE VERY TOP OF THE PAGE -->
        <div class="top_line"></div>
<!-- HEADER AREA -->
        <header>
            <g:applyLayout name="inc_header" />

            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">
                    <button data-dismiss="alert" class="close" type="button">×</button>
                    <h2>${flash.message}<h2>
                </div>
            </g:if>

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
	<g:layoutBody/>
    </div>

</div>

<footer id="footer">
	<g:applyLayout name="inc_footer" />
</footer>
</div>

<%--畫面可視區域：終點--%>




<r:layoutResources />
</body>
</html>
