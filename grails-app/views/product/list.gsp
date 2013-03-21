
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">

<g:set var="entityName" value="${message(code: 'product.label', default: '文章')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>


</head>
<body>
    <div class="row">
        <div class="span12">
            <table class="table">
                <thead>
                    <tr>
                        <th width="40">#</th>
                        <th><g:message code="product.title.label" /></th>
                        <th><g:message code="serviceEvent.label" /></th>
                        <th><g:message code="product.dateCreated.label" /></th>

                    </tr>
                </thead>
                <tbody>
                		<!-- 如果沒有文章，顯示空白 -->
                    <g:if test="${!products}">
                        <tr>
                            <td colspan="4"><div style="text-align:center"><g:message code="default.empty.description" /></div></td>
                        </tr>
                    </g:if>
                    <g:each in="${products}" var="product" status="i">
                        <tr>
                            <td>${i+1}</td>
                            <td><g:link controller="product" action="show" id="${product?.id}">${product.title}</g:link></td>
                            <td><g:link controller="serviceEvent" action="list" params="[productId:product?.id]">查看維修記錄</g:link></td>
                            <td><g:formatDate date="${product.lastUpdated}" type="date" style="SHOROT" /></td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
