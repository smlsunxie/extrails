<!DOCTYPE html>
<html>
	<head>
		<title><g:message code="default.home.label"/></title>

	</head>
	<body>

    <div class="main-block block-posts">
      <div class="title-wrapper">
          <h1><i class="icon-signin"></i> 維修中</h1>
      </div>
        <div class="row show-grid clear-both">
            <div class="col-sm-12 col-md-12">
              <div class="row show-grid">
                
                <g:render template="/event/stickWithImage" model="['stickName':'alert']"
                  collection="${unfinEvents}" var="event"  />
              
              </div>
            </div>
        </div>
    </div>
    
    <hr>
    <div class="main-block block-posts">
      <div class="title-wrapper">
          <h1><i class="icon-ok "></i> 維修完成</h1>
      </div>
      <div class="row show-grid clear-both">
        <div class="col-sm-12 col-md-12">
          <div class="row show-grid">
            <g:render template="/event/stickWithImage" model="['stickName':'success']"
              collection="${endEvents}" var="event"  />
        </div>
      </div>
    </div>


    <hr>

    <div class="main-block block-posts">
        <div class="title-wrapper">
            <h2>最近的文章</h2><a href="#" class="all"></a>
        </div>
        <div class="row show-grid clear-both">
            <div class="col-sm-12 col-md-12">
              <div class="row show-grid">
                <g:each var='recentPost' in='${recentPosts}' >
                  <div class="col-sm-3 col-md-3">
                    <a class="block-post-img" href="#">


                      <g:render template="/post/mainImg" model="[post:recentPost]" />

                    </a>
                    <g:link controller='post' action='show' id='${recentPost.id}' class="block-post-title">${recentPost?.title}</g:link>
                    <p class="block-post-date"><g:formatDate date='${recentPost.lastUpdated}' type='date' style='MEDIUM' /></p>
                    <p class="block-post-content">${recentPost.description}</p>
                    <g:link controller='post' action='show' id='${recentPost.id}' class="block-post-more">Read more&nbsp;&raquo;</g:link>
                  </div>
                </g:each>
              </div>
            </div>
        </div>
    </div>


	</body>
</html>
