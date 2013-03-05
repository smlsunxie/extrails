            <ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#setup" data-toggle="tab">設置</a></li>
              <li class=""><a href="#imagesTab" data-toggle="tab">圖片</a></li>
              <li class=""><a href="#content" data-toggle="tab">編輯</a></li>
              <li class=""><a href="#preview" data-toggle="tab">預覽</a></li>

            </ul>
            <div id="myTabContent" class="tab-content">
              
              <div class="tab-pane fade in active" id="setup">
                <g:render template="setup" />
              </div>

              %{-- 編輯區域 tab --}%
              <div class="tab-pane fade" id="content">
                    <div class="wmd-panel wmd-editor">
                        <div id="wmd-button-bar"></div>
                        <g:textArea name="content" cols="40" rows="20" value="${post?.content}" class="wmd-input enable-tabkey" id="wmd-input" />
                    </div>
              </div>

              %{-- preview tab --}%
              <div class="tab-pane fade" id="preview">
                <div id="wmd-preview" class="wmd-panel wmd-preview"></div>
              </div>

              %{-- 圖片 tab --}%
              <div class="tab-pane fade" id="imagesTab">

                <div class="row-fluid">
                  <div class="span3 pull-right">
                    <h3>
                        請選擇封面圖檔
                    </h3>
                  </div>
                  <div class="span9">
                    <uploader:uploader  id="fileupload" url="${[ action:'attachmentSave', id:post.name]}" >
                      <uploader:onComplete>
                        displayList();
                      </uploader:onComplete>
                    </uploader:uploader>

                </div>
                </div>




                <div  class="row-fluid">
                  <div id="images" class="span12">
                  </div>
                </div>

              </div>

            </div>

    <r:script>
      var displayList=function(){
        <g:remoteFunction action="attachmentList" params="[name:post.name]" update="images" />
      }

      $(function() {
        displayList();
      });

      var showConfirm=function(){
        return confirm("${message(code: 'default.button.delete.confirm.message')}");
      }

    </r:script>
