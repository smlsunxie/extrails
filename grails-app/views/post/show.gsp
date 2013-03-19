
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="bootstrap">
<title>${post?.title}</title>
</head>
<body>




<div class="container">

  <div class="row show-grid">
      <div class="span12">
          <div id="breadcrumb">
              <ul >
                <li class="home btn btn-mini btn-link">post</li>
                <li class="btn btn-mini btn-link">${post.title}</li>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                  <li><g:link  class="btn btn-primary btn-mini" controller="post" action="edit" id="${post?.id}"><g:message code="default.button.edit.label" /></g:link></li>
                  <li><g:link  class="btn btn-danger btn-mini" controller="post" action="delete" id="${post?.id}"><g:message code="default.button.delete.label" /></g:link></li>
                </sec:ifAllGranted>
              </ul>


          </div>
      </div>

      <div class="span12">                        
          <div class="row show-grid clear-both">

              <div class="span9 main-column two-columns-right ">
                  
                  <g:if test="${productShow}">
                    <g:render template="/product/content"  model="['product':productShow.product,'files':productShow.files]" />
                  </g:if>

                  <div class="markdown-source">${post?.content?.encodeAsHTML()}</div>
                  
                  <div class="post-item-panel">
                      <ul>
                          <li class="date">
                            <p><i class="icon-calendar"></i><g:formatDate date="${post?.lastUpdated}" type="datetime" style="MEDIUM" /></p>
                          </li>
                          <li>
                            <p><i class="icon-user"></i>by ${post.creator.username}</p>
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
                      <h2>Recent Posts Widget</h2>
                      <ul>
                          <g:each var='recentPost' in='${recentPosts}' >
                            <li>
                                <a class="photo" href="#">
                                    <g:img alt="" uri="attachment/show?name=${recentPost.name}&file=${recentPost.mainImage}" />
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










%{--           <div class="markdown-source">${post?.content?.encodeAsHTML()}</div>
          
          <hr />
          
          <small><g:message code="post.lastUpdated.label" default="Last Updated" />: <g:formatDate date="${post?.lastUpdated}" type="datetime" style="MEDIUM" /></small> --}%
          

</div>
</body>
</html>
