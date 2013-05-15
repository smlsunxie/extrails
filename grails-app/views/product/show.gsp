
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${product?.title}</title>
</head>
<body>
  <div class="row show-grid">

      <div class="span12">                        


                <sec:ifAllGranted roles="ROLE_OPERATOR">
                  <g:actionbar actionName="${actionName}" domain="${product}" />
                </sec:ifAllGranted>
        
                <g:render template="content" />

                <sec:ifAnyGranted roles="ROLE_OPERATOR">

                  <div class="row-fluid">
                    <div class="span12 well well-small">

                      <div class="row-fluid">

                        <div class="span3 well well-small">
                          <g:message code="user.title.label" />
                          <div class="row-fluid">
                              ${product?.user?.title}
                          </div>
                        </div>


                        <div class="span3 well well-small">
                          <g:message code="user.telphone.label" />
                          <div class="row-fluid">
                              ${product?.user?.telphone}
                          </div>
                        </div>

                        <div class="span3 well well-small">
                          <g:message code="user.mobile.label" />
                          <div class="row-fluid">
                              ${product?.user?.mobile}
                          </div>
                        </div>


                        <div class="span3 well well-small">
                          <g:message code="user.description.label" />
                          <div class="row-fluid">
                              ${product?.user?.description}
                          </div>
                        </div>



                      </div>
                    </div>
                  </div>

                  <div class="row-fluid">
                    <table class="table">
                        <thead>
                          <tr>

                            <th><g:message code="default.dateCreated.label" /></th>
                            <th><g:message code="user.title.label" /></th>
                            <th><g:message code="event.mileage.label" /></th>
                            <th><g:message code="part.label" /></th>

                          </tr>
                        </thead>
                        <tbody>
                            <g:each in="${product.events}" var="event" status="i">
                              <g:each in="${event.details}" var="detail" status="j">
                                  <tr>
                                      <g:if test="${j==0}">
                                        <td rowspan="${event.details.size()}"><g:formatDate date="${event.date}" type="date" style="SHOROT" /></td>
                                        <td rowspan="${event.details.size()}">${event.user.title}</td>
                                        <td rowspan="${event.details.size()}">${event.mileage}</td>
                                      </g:if>
                                      <td>${detail.part.title}</td>
                                  </tr>
                              </g:each>
                            </g:each>

                        </tbody>
                    </table>                    
                  </div>

                </sec:ifAnyGranted >




      </div>                                        
  </div>

</body>
</html>
