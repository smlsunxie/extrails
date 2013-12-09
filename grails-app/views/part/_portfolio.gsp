<g:set var="tagQueryService" bean="tagQueryService"/>
<g:set var="nowTag" value="${params.tag}" />

<html>
<head>
<title><g:message code="post.edit.title" defualt="修改文章"/></title>


</head>
<body>

  <div class="col-wrapper">
              
    <div class="portfolio-nav">
                  
      <ul data-option-key="filter" class="nav nav-pills nav-pills-portfolio">
        <g:each var="tag" in="${tagQueryService.getUniTag('part')}">

          <li class="${ nowTag == tag.toString() ? 'active' : '' }">
            <g:link action="${actionName}" id="${event?.id}" params="[tag:tag]" >${tag}</g:link>
          </li>
        </g:each>
      </ul>
    </div>


                 
    <div class="portfolio-grid-1 main-block">
      <ul id="portfolio" class="row thumbnails">                  
        
        <g:each var="part" in="${parts}">
          <li class="col-sm-3 col-md-3 large hp-wrapper element ${part.tags.join(' ')}">        
            <div id="${part.name}" class="thumbnail">
  %{--                           <g:img alt="" uri="/attachment/show?name=${part.name}&file=${part.mainImage}" style='height:100px' />  --}%

                <div class="caption">

                  <h3><g:link controller="part" action="show" id="${part.id}">${part.title}</g:link></h3>
                  <p>${part.description}</p>

                  <g:if test="${event}">
                    <g:form action="save" controller="eventDetail" class="form-thumbnail" params="['part.id':part.id, 'part.name':part.name, 'head.id':event.id]"> 
                      <p>


                        <div class="input-group">
                          <span class="input-group-addon">售價</span>
                          <g:textField value="${part.price}" name="price" class="form-control" />
                        </div>

                        <div class="input-group">
                          <span class="input-group-addon">數量</span>
                          <g:textField value="1"  name="qty" class="form-control" />
                        </div>                          
                      </p>

                      <p>

                          <g:submitButton controller="eventDetail" action="create"class="btn btn-primary" name="快速新增" />

                          <g:link controller="eventDetail" action="create" params="['part.id':part.id, 'head.id':event.id]" class="btn btn-primary">照相新增</g:link> 
                        

                      </p>
                    </g:form>
                  </g:if>

                  <g:else>
                    <p>售價：${part.price}</p>
                    <g:link controller="part" action="show" id="${part.id}" class="btn">檢視項目</g:link>
                  </g:else>
                </div>

            </div>
          </li>
        </g:each>

      </ul>
    </div>

  </div>                

</body>
</html>
