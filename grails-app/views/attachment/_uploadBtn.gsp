                    <div class="controls">
                    <uploader:uploader  id="fileupload" url="${[controller:'attachment', action:'save']}" params='[name:name]' >
                      <uploader:onComplete>
                        displayList();
                      </uploader:onComplete>
                    </uploader:uploader>
                    </div>
                    
                    <hr/>

                    <div  class="row-fluid">
                      <div id="images" class="span12">
                      </div>
                    </div>


    <r:script>
      var displayList=function(){
        <g:remoteFunction controller='attachment' action="list" params="[name:name, mainImage: mainImage]" update="images" />
      }

      $(function() {
        displayList();
      });
    </r:script>
