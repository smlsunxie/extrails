

<div class="visible-xs" >

  <div class="btn-group" id="actionbar">
    <button class="btn btn-default btn-success dropdown-toggle" type="button" data-toggle="dropdown">
    <g:message code="TagGroup.${params.group}" /><span class="caret"></span>
    </button>
    <ul class="dropdown-menu">
      <g:each var="group" in="${motoranger.TagGroup.values()}">

        <g:if test="${params.group.toString() != group.toString()}">
          <li >
            <g:link action="${actionName}" id="${eventInstance?.id}" params="[group: group]" ><g:message code="TagGroup.${group}" /></g:link>
          </li>
          </g:if>
      </g:each>
    </ul>
  </div>


  <div class="btn-group" id="actionbar">
    <button class="btn btn-default btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
      ${params.tag ? params.tag : '選擇標籤'}<span class="caret"></span>
    </button>
    <ul class="dropdown-menu">
      <g:each var="tag" in="${tags}" status="i">
        <g:if test="${params.tag != tag}">

          <li>
            <g:link elementId="tag-show-${i}" action="${actionName}" id="${eventInstance?.id}" params="[tag: tag, group: params.group]" >${tag}</g:link>
          </li>

        </g:if>
      </g:each>
    </ul>
  </div>
</div>


<div class="hidden-xs">
  <div class="portfolio-nav">
                
    <ul id="tagGroup" class="nav nav-pills nav-pills-portfolio">

      <g:each var="group" in="${motoranger.TagGroup.values()}">

        <li class="${ params.group.toString() == group.toString() ? 'active' : '' }">
          <g:link action="${actionName}" id="${eventInstance?.id}" params="[group: group]" ><g:message code="TagGroup.${group}" /></g:link>
        </li>
      </g:each>        

    </ul>
  </div>

  <div class="portfolio-nav">
                
    <ul data-option-key="filter" class="nav nav-pills nav-pills-portfolio">
      <g:each var="tag" in="${tags}" status="i">

        <li class="${ params.tag == tag.toString() ? 'active' : '' }">
          <g:link elementId="tag-show-${i}" action="${actionName}" id="${eventInstance?.id}" params="[tag: tag, group: params.group]" >${tag}</g:link>
        </li>
      </g:each>
    </ul>
  </div>
</div>

             
<div class="portfolio-grid-1 main-block row">
  <ul id="gallery" class="thumbnails">
         
    <g:each var="partInstance" in="${partInstanceList}" >
      <li class="col-md-3 col-sm-3 small hp-wrapper ${partInstance.tags.join(' ')}">  
   
        <div id="${partInstance.name}" class="thumbnail">
%{--                           <g:img alt="" uri="/attachment/show?name=${partInstance.name}&file=${partInstance.mainImage}" style='height:100px' />  --}%

            <div class="caption">

              <h3><g:link elementId="part-show-${partInstance.name}" controller="part" action="show" id="${partInstance.id}">${partInstance.title}</g:link></h3>
              <p>${partInstance.description}</p>

              <g:if test="${eventInstance}">

                <g:form name="eventDetail-save-${partInstance.name}" action="save" controller="eventDetail" class="form-thumbnail" params="['part.id':partInstance.id, 'part.name':partInstance.name, 'head.id':event.id]"> 
                  <p>


                    <div class="input-group">
                      <span class="input-group-addon">售價</span>
                      <g:textField value="${partInstance.price}" name="price" class="form-control" />
                    </div>

                    <div class="input-group">
                      <span class="input-group-addon">數量</span>
                      <g:textField value="1"  name="qty" class="form-control" />
                      <g:textField hidden value=""  name="name" />
                    </div>                          
                  </p>

                  <p>

                      <g:submitButton controller="eventDetail" action="create" class="btn btn-primary" value="快速新增" name="create" />

                      <g:link controller="eventDetail" action="create" params="['part.id':partInstance.id, 'head.id':event.id]" class="btn btn-primary">照相新增</g:link> 
                    

                  </p>
                </g:form>
              </g:if>

              <g:else>
                <p>售價：${partInstance.price}</p>
                <g:link controller="part" action="show" id="${partInstance.id}" class="btn">檢視項目</g:link>
              </g:else>
            </div>

        </div>
      </li>
    </g:each>

  </ul>
</div>
