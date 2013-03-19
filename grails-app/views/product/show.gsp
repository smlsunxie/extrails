
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${product?.title}</title>
</head>
<body>




<div class="container">

  <div class="row show-grid">
      <div class="span12">
          <div id="breadcrumb">
                <ul >
                  <li class="home btn btn-mini btn-link">product</li>
                  <li class="btn btn-mini btn-link">${product.title}</li>
                  <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li><g:link  class="btn btn-primary btn-mini" controller="product" action="edit" id="${product?.id}"><g:message code="default.button.edit.label" /></g:link></li>
                    <li><g:link  class="btn btn-danger btn-mini" controller="product" action="delete" id="${product?.id}"><g:message code="default.button.delete.label" /></g:link></li>
                  </sec:ifAllGranted>
                </ul>


          </div>
      </div>

      <div class="span12">                        
          <div class="row show-grid clear-both">

              <div class="span9 main-column two-columns-right ">
        
                  <g:render template="content" />


                  <div class="post-item-panel">
                      <ul>
                          <li class="date">
                            <p><i class="icon-calendar"></i><g:formatDate date="${product?.lastUpdated}" type="datetime" style="MEDIUM" /></p>
                          </li>

                          <li>
                            <p>
                              <g:render template="/tag/links" model="['tags':product.tags]" />
                            </p>
                          </li>
                      </ul>
                  </div>



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
  <hr>
</div>
</body>
</html>
