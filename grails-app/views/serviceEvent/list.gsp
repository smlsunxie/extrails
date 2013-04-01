
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
                        <th><g:message code="serviceEvent.name.label" /></th>
                        <th><g:message code="serviceEvent.status.label" /></th>
                        <th><g:message code="serviceEvent.mileage.label" /></th>
                        <th><g:message code="default.dateCreated.label" /></th>
                        <th><g:message code="default.action.label" /></th>
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
                      <g:render template='headList' model="[serviceEvent:serviceEvent]" />



                    </g:each>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
