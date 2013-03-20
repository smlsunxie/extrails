package extrails


import uk.co.desirableobjects.ajaxuploader.exception.FileUploadException
import grails.converters.JSON
import grails.plugins.springsecurity.Secured

class AttachmentController {

    def s3Service
    def imageModiService

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def save={
        try {
            // def fileLocation=grailsApplication.config.upload.files.path;
            // log.info fileLocation

            //檢查路徑是否存在，若不存在則產生資料夾
            // fileHandleService.checkAndCreate(new File("${fileLocation}/${params.name}"));

            // 定義上傳的檔案名稱
            // File uploaded = new File("${fileLocation}/${params.name}/${params.qqfile}")
            // File compressed = new File("${fileLocation}/${params.name}/${params.qqfile}_compressed")

            // 將使用者上傳檔案的 inputStream 指定給 uploaded 完成檔案儲存
            // ajaxUploaderService.upload(request.inputStream, uploaded)

            //改變檔案大小

            def ri = (InputStream)request.inputStream

            def oi=imageModiService.sizeMiddle(ri)

            log.info "${grailsApplication.config.grails.aws.root}/${params.name}/${params.qqfile}"
            
            s3Service.saveObject "${grailsApplication.config.grails.aws.root}/${params.name}/${params.qqfile}", new ByteArrayInputStream(oi.toByteArray())



            return render(text: [success:true] as JSON, contentType:'text/json')

        } catch (FileUploadException e) {

            log.error("Failed to upload file.", e)
            return render(text: [success:false] as JSON, contentType:'text/json')

        }

    }


    /**
     * 附件上傳及清單（顯示在 iframe 頁框內）
     */
    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def list= {
        // File dir = new File("${fileLocation}/${params.name}");

        render (template:"list", model: [
            name: params.name,
            mainImage: params.mainImage,
            // files: dir.listFiles()
            files: s3Service.getObjectList("${grailsApplication.config.grails.aws.root}/${params.name}")
        ])

        // [
        //     content: content,
        //     files: s3Service.getObjectList("attachment/${content.lesson?.course?.id}/${content.lesson?.id}/${content.id}")
        // ]
        
    }

    /**
     * 讀取附件
     */
    def show= {

        def file = params.file

        // 將已編碼 URL 還原
        file = URLDecoder.decode(file)


        log.info resource(dir: 'images', file: 'notFind.jpg', absolute: true);
        log.info resource(dir: 'images', file: 'notFind.jpg');


        try {

            // File object = new File("${fileLocation}/${post.name}/${file}")

            def object = s3Service.getObject("${grailsApplication.config.grails.aws.root}/${params.name}/${file}")
            response.outputStream << object
        }
        catch (e) {
            e.printStackTrace()
            log.error "Could not read ${file}"
            File notFindImg  = grailsAttributes.getApplicationContext().getResource("/images/notFind.jpg").getFile()
            response.outputStream << new FileInputStream(notFindImg)

            // response.sendError 404
        }
    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def delete= {

        // def file = new File(params.file);
        try {
            // file.delete();

            s3Service.deleteObject "${params.file}"

            return render(text: [success:true] as JSON, contentType:'text/json')
        }
        catch (e) {
            log.error "Could not read ${file}"
            e.printStackTrace()
            return render(text: [success:false] as JSON, contentType:'text/json')
        }
        
        
    }

}
