<!DOCTYPE html>
<html>
  <head>
    <title><g:message code="default.home.label"/></title>

  </head>
  <body>

      <sec:ifAllGranted roles="ROLE_OPERATOR">
        <g:actionbar actionName="${actionName}" domain="${store}" />
      </sec:ifAllGranted>

    <div class="main-block block-posts">
      <div class="title-wrapper">
          <h1><i class="icon-signin"></i> 維修中</h1>
      </div>
        <div class="row show-grid clear-both">
            <div class="col-sm-12 col-md-12">
              <div class="row show-grid">
                
                <g:render template="/event/stick" model="['stickName':'alert']"
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
            <g:render template="/event/stick" model="['stickName':'success']"
              collection="${endEvents}" var="event"  />
        </div>
      </div>
    </div>


  </body>
</html>
