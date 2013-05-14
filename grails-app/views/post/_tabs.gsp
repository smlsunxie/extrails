            <ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#setup" data-toggle="tab">設置</a></li>
              <li class=""><a href="#imagesTab" data-toggle="tab">圖片</a></li>
              <li class=""><a href="#content" data-toggle="tab">編輯</a></li>
              <li class=""><a href="#preview" data-toggle="tab">預覽</a></li>

            </ul>
            <div id="myTabContent" class="tab-content">
              
              <div class="tab-pane fade in active" id="setup">
                <g:render template="form" />
              </div>

              %{-- 編輯區域 tab --}%
              <div class="tab-pane fade" id="content">

                <div class="row">

                  <div class="span4">
                    <g:render template="md_help" />

                  </div>
                  <div class="span8">
                    <div class="wmd-panel wmd-editor">
                        <div id="wmd-button-bar"></div>
                        <g:textArea name="content" cols="40" rows="20" value="${post?.content}" class="wmd-input enable-tabkey" id="wmd-input" />
                    </div>                    
                  </div>

                </div>






              </div>

              %{-- preview tab --}%
              <div class="tab-pane fade" id="preview">
                <div id="wmd-preview" class="wmd-panel wmd-preview"></div>


              </div>

              %{-- 圖片 tab --}%
              <div class="tab-pane fade" id="imagesTab">

                <div class="row-fluid">

                    <g:render template="/attachment/uploadBtn" model="[name:post.name ,mainImage: post?.mainImage]" />  
                </div>

              </div>

            </div>

    <r:script>


      $(function() {
        $("ul[name='tags']").tagit({select:true, tagSource: "${g.createLink(controller:'tag',action: 'listAsJson')}"});

      });


    </r:script>
