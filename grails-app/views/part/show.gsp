
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${part?.title}</title>
</head>
<body>

  <div class="row show-grid">
      <div class="span12">                        
          <div class="row show-grid clear-both">

              <div class="span9 main-column two-columns-right ">
                  <sec:ifAllGranted roles="ROLE_ADMIN">
                    <g:btnbar actionName="${actionName}" domain="${part}" />
                  </sec:ifAllGranted>        
                  <h1>${part.title}</h1>

                  <div class="flexslider slider1">
                    <ul class="slides">
                      <g:each in="${files}" var="file" status="i">
            
                        <li class="slide4">
                            <img alt="" src="/attachment/show?name=${part.name}&file=${file.name}" />
                            <div class="carousel-caption">
                                <h2><a href="#">${file.name}</a></h2>
                                <p></p>
                            </div>
                        </li>

                      </g:each>  
                    </ul>
                  </div>  
                  
                  <h4>${part.description}</h4>  
                  
                  <hr>

                  <table class="table">

                      <tbody>
                            <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_MANERGER">
                               <tr>
                                    <td><g:message code="default.cost.label" /></td>
                                    <td>${part.cost}</td>
                                </tr>   
                              </sec:ifAnyGranted>     
                             <tr>
                                  <td><g:message code="default.price.label" /></td>
                                  <td>${part.price}</td>
                              </tr> 

                      </tbody>
                  </table>






                  
                  <div class="post-item-panel">
                      <ul>
                          <li class="date">
                            <p><i class="icon-calendar"></i><g:formatDate date="${part?.lastUpdated}" type="datetime" style="MEDIUM" /></p>
                          </li>
                          <li>
                            <p><i class="icon-user"></i>by ${part?.creator?.username}</p>
                          </li>
                          <li>
                            <p>
                              <g:render template="/tag/links" model="['tags':part.tags]" />
                            </p>
                          </li>
                      </ul>
                  </div>



              </div>
              <div id="right-sidebar" class="span3 sidebar">
                  <div class="sidebar-news-widget sidebar-block">
                      <h2>Recent parts Widget</h2>
                      <ul>
                          <g:each var='recentpart' in='${recentparts}' >
                            <li>
                                <a class="photo" href="#">
                                    <g:img alt="" uri="attachment/show?name=${recentpart.name}&file=${recentpart.mainImage}" />
                                </a>
                                <p>
                                <a href="">${recentpart.title}</a>
                                </p>
                                <p class="date"><i class="icon-calendar"></i><g:formatDate date="${recentpart?.lastUpdated}" type="date" style="MEDIUM" /></p>
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
