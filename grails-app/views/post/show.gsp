
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${post?.title}</title>
</head>
<body>

  <div class="row show-grid">
      <div class="span12">                        
          <div class="row show-grid clear-both">
              <div class="span9 main-column two-columns-right ">

                  <sec:ifAllGranted roles="ROLE_MANERGER">
                    <g:actionbar actionName="${actionName}" domain="${post}" />
                  </sec:ifAllGranted> 

                  <g:if test="${productShow}">
                    <g:render template="/product/content"  model="['product':productShow.product,'files':productShow.files]" />
                  </g:if>

                  <div class="markdown-source">${post?.content?.encodeAsHTML()}</div>

                  <disqus:comments bean="${post}" />
                  
                  <div class="post-item-panel">
                      <ul>
                          <li class="date">
                            <p><i class="icon-calendar"></i><g:formatDate date="${post?.lastUpdated}" type="datetime" style="MEDIUM" /></p>
                          </li>
                          <li>
                            <p><i class="icon-user"></i>by ${post.creator}</p>
                          </li>
                          <li>
                            <p>
                              <g:render template="/tag/links" model="['tags':post.tags]" />
                            </p>
                          </li>
                      </ul>
                  </div>



              </div>
              <div id="right-sidebar" class="span3 sidebar">
                  <div class="sidebar-news-widget sidebar-block">
                      <h2>最近的文章</h2>
                      <ul>
                          <g:each var='recentPost' in='${recentPosts}' >
                            <li>
                                <a class="photo" href="#">

                                  <g:if test="${post.mainImage}">
                                    <g:img uri="attachment/show?name=${post.name}&file=${post.mainImage}" class="img-rounded" style="width:100px;" />
                                  </g:if>
                                  <g:elseif test="${post?.product?.mainImage}">
                                    <g:img uri="attachment/show?name=${post.product.name}&file=${post.product.mainImage}" class="img-rounded" style="width:100px;" />
                                  </g:elseif>

                                </a>
                                <p>
                                <a href="">${recentPost.title}</a>
                                </p>
                                <p class="date"><i class="icon-calendar"></i><g:formatDate date="${recentPost?.lastUpdated}" type="date" style="MEDIUM" /></p>
                            </li>
                          </g:each>

                      </ul>
                  </div>


              </div>

          </div>
      </div>
                                        
  </div>
  <hr>
        
</body>
</html>
