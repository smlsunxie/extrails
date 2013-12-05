  <div class="controls">
    <div  class="row-fluid" >

      <div  class="col-sm-4 col-md-4" >

        <uploader:uploader debug="true" id="fileupload" url="${[controller:'attachment', action:'save']}" params='[name:name]' >
          <uploader:onComplete>
            displayList();
          </uploader:onComplete>
        </uploader:uploader>

      </div>

      <div id="webcamCtrlDiv"   >
        <div  class="span2" >
          <input type="button" style="height: 35px;" id="shapshot" name="shapshot" value="攝影照像">
        </div>
        <div  class="span2" >
          <input type="button" style="height: 35px;" id="uploadShapshot" name="uploadShapshot" value="照片上傳">
        </div>
      </div>
    </div>

  </div>  
  <hr/>

  <div id="webcamViewDiv" class="row-fluid" >
    <video class="span6 thumbnail" autoplay></video>
    <canvas class="span6 thumbnail" height = '225'></canvas>    
  </div>




  <div  class="row-fluid">
    <div id="images" class="span12">
    </div>
  </div>


    <r:script>

      var video = document.querySelector('video');
      var canvas = document.querySelector('canvas');
      var ctx = canvas.getContext('2d');
      var localMediaStream = null;

      function snapshot() {
        if (localMediaStream) {
          console.log(canvas.width);

          ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
        }

      }

      function uploadShapshot(){
          var image    = canvas.toDataURL("image/jpeg").replace('data:image/jpeg;base64,', '');

          var fd = new FormData();
          fd.append('image', image);
          fd.append('name', "${name}");
          $.ajax({
              type: 'POST',
              url: '/attachment/SaveBlob',
              data: fd,
              processData: false,
              contentType: false
          }).done(function(data) {
              // print the output from the upload.php script
              displayList();
          }); 
      }

      $("#shapshot").on('click', snapshot);
      $("#uploadShapshot").on('click', uploadShapshot);

      // Not showing vendor prefixes or code that works cross-browser.
      navigator.webkitGetUserMedia({video: true}, function(stream) {
        video.src = window.URL.createObjectURL(stream);
        localMediaStream = stream;
      },function(){ // success
        console.log("false");
        $("#webcamCtrlDiv").css( "display", "none" );
        $("#webcamViewDiv").css( "display", "none" );
        // $("#webcamCtrlDiv").css( "display", "block" );
        // $("#webcamViewDiv").css( "display", "block" );

      },
      function(){
        console.log("success");
        $("#webcamCtrlDiv").css( "display", "block" );
        $("#webcamViewDiv").css( "display", "block" );
      });


      var displayList=function(){
        <g:remoteFunction controller='attachment' action="list" params="[name:name, mainImage: mainImage]" update="images" />
      }

      $(function() {
        displayList();
      });
    </r:script>
