
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
                        <th width="100"><g:message code="default.dateCreated.label" /></th>
                    </tr>
                </thead>
                <tbody>

                    <tr>

                        <td><g:link controller="serviceEvent" action="show" id="${part?.id}">${serviceEvent.name}</g:link></td>
                        <td><g:formatDate date="${serviceEvent.lastUpdated}" type="date" style="SHOROT" /></td>
                    </tr>

                    <g:if test="${serviceEvent?.details}">
                        <tr>
                            <td colspan="3">
                                <table class="table-bordered" width="100%">
                                    <tbody>
                                        <g:each in="${serviceEvent?.details}" var="detail">
                                            <tr>
                                                <td>${detail.name}</td>
                                                <td><g:formatDate date="${detail.lastUpdated}" type="date" style="SHOROT" /></td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th><g:message code="serviceEvent.name.label" /></th>
                                            <th><g:message code="default.dateCreated.label" /></th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </td>
                        </tr>
                    </g:if> 

                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
