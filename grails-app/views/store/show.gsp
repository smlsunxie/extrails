<!DOCTYPE html>
<html>
  <head>
    <title><g:message code="default.home.label"/></title>

  </head>
  <body>

    <sec:ifAllGranted roles="ROLE_MANERGER">
      <div class="row" id="actionbar">

        <div class="col-sm-12 col-md-12">           
          <g:link  class="btn btn-primary" controller="store" action="edit" id="${store.id}" >修改店家資料</g:link>


        </div>

      </div>
    </sec:ifAllGranted>



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


  </body>
</html>
