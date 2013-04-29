
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


                  <g:each in="${product.events}" var="event" status="i">
                    <g:render template='/event/headList' model="[event:event]" />
                  </g:each>
                </sec:ifAnyGranted >




      </div>                                        
  </div>

</body>
</html>
