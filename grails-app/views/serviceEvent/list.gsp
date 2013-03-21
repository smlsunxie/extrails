
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">

<g:set var="entityName" value="${message(code: 'part.label', default: '文章')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>


</head>
<body>



    <div class="row">
        <div class="span12">
            <table class="table">
                <thead>
                    <tr>
                        <th width="40">#</th>
                        <th><g:message code="serviceEvent.name.label" /></th>
                        <th width="100"><g:message code="default.dateCreated.label" /></th>
                    </tr>
                </thead>
                <tbody>
                		<!-- 如果沒有文章，顯示空白 -->
                    <g:if test="${!serviceEvents}">
                        <tr>
                            <td colspan="4"><div style="text-align:center"><g:message code="default.empty.description" /></div></td>
                        </tr>
                    </g:if>
                    <g:each in="${serviceEvents}" var="serviceEvent" status="i">
                        <tr>
                            <td>${i+1}</td>
                            <td><g:link controller="serviceEventDetail" action="list" params="[serviceEvent:serviceEvent.id]">${serviceEvent.name}</g:link></td>
                            <td><g:formatDate date="${serviceEvent.lastUpdated}" type="date" style="SHOROT" /></td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
