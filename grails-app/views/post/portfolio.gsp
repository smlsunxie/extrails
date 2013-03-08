<html>
  <head>
    <title><g:message code="post.edit.title" defualt="修改文章"/></title>


  </head>
  <body>

    <div class="container">
%{--         <div class="row show-frid">
            <div class="span12">
                <div id="breadcrumb">
                    <ul>
                        <li class="home"><a href="#">${type}</a></li>
                    </ul>
                </div>
            </div>
        </div> --}%


        <div class="col-wrapper">
 
<!-- START PORTFOLIO NAV -->                    
            <div class="portfolio-nav">
<!-- SET PORTFOLIO NAV FILTERS HERE -->                     
                <ul id="filters" data-option-key="filter" class="nav nav-pills nav-pills-portfolio">

                    <li class="active"><a href="#" data-toggle="pill" data-filter="*">All</a></li>
                    <g:each var="tag" in="${tags}">
                        <li><a href="#" data-toggle="pill" data-filter=".${tag}">${tag}</a></li>
                    </g:each>

                </ul>

            </div>
        <!-- END PORTFOLIO NAV -->

        <!-- START PORTFOLIO GRID -->                
            <div class="portfolio-grid-1 main-block">
                <div id="portfolio" class="row">                        

                    <g:each var="post" in="${posts}">
                        <div class="span6 large hp-wrapper element ${post.tags.join(' ')}">        
     

                            <g:link controller="post" action="show" id="${post.id}"><g:img alt="" dir='img' file="460_arrow_2_hover.png" class="hover-shade" />
                            </g:link>
                            <a href="#" style="width: 460px; height: 340px;" class="top-link"><g:img alt="" uri="/post/attachment/${post.id}?file=${post.mainImage}" /></a>
                            <div class="top-block">
                                <g:link controller="post" action="show" id="${post.id}">${post.title}</g:link>
                                <p><i class="icon-tags"></i>
                                    <g:each var='tag' in='${post.tags}'>
                                    <a >${tag}</a></p>
                                    </g:each>
                                </p>

                            </div>  
                            <div class="bottom-block">
                                <p>${post.description}</p>
                            </div>        
          
                        </div>
                    </g:each>
                </div>
            </div>
        </div>                
    </div> 
  </body>
</html>
