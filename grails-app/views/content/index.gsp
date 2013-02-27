<html>
	<head>
		<title><g:message code="default.content.create.title"/></title>


	</head>
	<body>

		<header class="jumbotron subhead" id="overview">
				<g:render template="inc_subhead" />
		</header>
    <div class="container">
        
        <div class="wmd-panel">
            <div id="wmd-button-bar-second"></div>
<textarea class="wmd-input" id="wmd-input-second">

</textarea>
        </div>
        <div id="wmd-preview-second" class="wmd-panel wmd-preview"></div>

    </div> 



<r:script>
        (function () {

            
            var converter2 = new Markdown.Converter();

            converter2.hooks.chain("preConversion", function (text) {
                return text.replace(/\b(a\w*)/gi, "*$1*");
            });

            converter2.hooks.chain("plainLinkText", function (url) {
                return "This is a link to " + url.replace(/^https?:\/\//, "");
            });
            
            var help = function () { alert("Do you need help?"); }
            
            var editor2 = new Markdown.Editor(converter2, "-second", { handler: help });
            
            editor2.run();
        })();
</r:script>

	</body>
</html>
