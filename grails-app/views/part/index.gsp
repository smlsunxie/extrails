<g:set var="s3Service" bean="s3Service"/>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${product?.title}</title>
</head>
<body>

<g:render template="portfolio" model="['event': event, tag: tag, part: part]" />

</body>
</html>
