
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${product?.title}</title>
</head>
<body>
  <div class="row show-grid">

      <div class="span12">                        
          <div class="row show-grid clear-both">

              <div class="span9 main-column two-columns-right ">

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
                </sec:ifAnyGranted >



              </div>
              <div id="right-sidebar" class="span3 sidebar">
                  <div class="sidebar-news-widget sidebar-block">
                      <h2>Recent products Widget</h2>
                      <ul>
                          <g:each var='recentproduct' in='${recentproducts}' >
                            <li>
                                <a class="photo" href="#">
                                    <g:img alt="" uri="attachment/show?name=${recentproduct.name}&file=${recentproduct.mainImage}" />
                                </a>
                                <p>
                                <a href="">${recentproduct.title}</a>
                                </p>
                                <p class="date"><i class="icon-calendar"></i><g:formatDate date="${recentproduct?.lastUpdated}" type="date" style="MEDIUM" /></p>
                            </li>
                          </g:each>

                      </ul>
                  </div>


              </div>

          </div>
      </div>                                        
  </div>

</body>
</html>
