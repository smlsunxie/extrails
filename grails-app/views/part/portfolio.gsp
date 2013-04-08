<html>
  <head>
    <title><g:message code="post.edit.title" defualt="修改文章"/></title>


  </head>
  <body>


    <g:set var="nowTag" value="${!params?.tag ? '標準維修' : params.tag}" />
    <div class="col-wrapper">
        <div class="portfolio-nav">
<!-- SET PORTFOLIO NAV FILTERS HERE -->                     
            <ul id="filters" data-option-key="filter" class="nav nav-pills nav-pills-portfolio">
                <li class="active">
                    <g:link controller="eventDetail" action='list' params="[event:params.event]">修改 ${event?.product.name} 維修記錄</g:link>
                </li>
                <g:each var="detail" in="${event.details}">
                    <li><a href="#" >${detail.part.title}</a></li>
                </g:each>
            </ul>
        </div>
<!-- START PORTFOLIO NAV -->                    
        <div class="portfolio-nav">
<!-- SET PORTFOLIO NAV FILTERS HERE -->                     
            <ul id="filters" data-option-key="filter" class="nav nav-pills nav-pills-portfolio">
                <g:each var="tag" in="${tags}">

                    <li class="${ nowTag == tag.toString() ? 'active' : '' }">
                        <g:link action="portfolio" params="[event:params.event,tag:tag]" >${tag}</g:link>
                    </li>
                </g:each>
            </ul>
        </div>
    <!-- END PORTFOLIO NAV -->

    <!-- START PORTFOLIO GRID -->                
        <div class="portfolio-grid-1 main-block">
            <ul id="portfolio" class="row thumbnails">                  
                <g:each var="part" in="${parts}">
                    <li class="span3 large hp-wrapper element ${part.tags.join(' ')}">        
                        <div class="thumbnail">
%{--                           <g:img alt="" uri="/attachment/show?name=${part.name}&file=${part.mainImage}" style='height:100px' />  --}%
                          <div class="caption">
                            <h3><g:link controller="part" action="show" id="${part.id}">${part.title}</g:link></h3>
                            <p>${part.description}</p>
                            <p>售價：${part.price}</p>
                            <p>
                                <g:link controller="eventDetail" action="create"
                                 params="[part:part.id, head:params?.event]" class="btn btn-primary">新增維修</g:link> 
                                
                            </p>


                          </div>
                        </div>
                    </li>
                </g:each>
            </ul>
        </div>
    </div>                

  </body>
</html>
