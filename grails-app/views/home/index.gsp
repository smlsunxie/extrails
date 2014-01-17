<!DOCTYPE html>
<html>
	<head>
		<title><g:message code="default.home.label"/></title>

	</head>
	<body>
<!-- MAIN CONTENT AREA: SLIDER BANNER (REVOLUTION SLIDER) -->
    <div class="bannercontainer">
        <div class="banner">
            <ul>
                <!-- MAIN CONTENT AREA: SLIDER BANNER (REVOLUTION SLIDER) - SLIDE 1 [SLIDE
                STYLE=BOXFADE] -->
                <li class="slide1 slide" data-transition="boxfade" data-slotamount="5"
                    data-masterspeed="300">
                    <img alt="" src="img/slider01.png" class="img-responsive" />
                    <div class="caption sft carousel-caption" data-x="-60" data-y="70" data-speed="1000"
                         data-start="1000" data-easing="easeInBack" style="background: none;">
                        <p class="middle">立即註冊試用！</p>
                    </div>
                    <div class="caption sfl carousel-caption" data-x="98" data-y="101" data-speed="1000"
                         data-start="1000" data-easing="easeOutBack" style="background: none;">
                        <p class="big">MotoRanger</p>
                    </div>                    
                    <div class="caption sfl carousel-caption" data-x="98" data-y="151" data-speed="1000"
                         data-start="1000" data-easing="easeOutBack" style="background: none;">
                        <p class="big">線上摩托維修記錄</p>
                    </div>
                    <div class="caption sfl carousel-caption" data-x="98" data-y="201" data-speed="1000"
                         data-start="1000" data-easing="easeOutBack" style="background: none;">
                        <p class="big">不再忘記何時加機油！</p>
                    </div>
                    <div class="caption sfb carousel-caption" data-x="111" data-y="257" data-speed="1000"
                         data-start="1000" data-easing="easeInBack" style="background: none; width: 436px;">
                        <p class="middle">您可以自定維修項目，打造屬於你的機車行</p>
                    </div>
                </li>

            </ul>
            <div class="tp-bannertimer"></div>
        </div>
    </div>






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

%{-- 
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


                      <g:render template="/post/mainImg" class="img-rounded img-responsive" model="[post:recentPost]" />

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

 --}%
	</body>
</html>
