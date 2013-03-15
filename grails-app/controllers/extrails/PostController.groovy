package extrails

import grails.plugins.springsecurity.Secured

import grails.converters.JSON

import org.springframework.http.HttpStatus
import uk.co.desirableobjects.ajaxuploader.exception.FileUploadException
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.MultipartFile
import javax.servlet.http.HttpServletRequest
import grails.util.GrailsUtil
import org.codehaus.groovy.grails.web.context.ServletContextHolder



class PostController {

	static layout="bootstrap"
	def springSecurityService
    def ajaxUploaderService
    def messageSource
    def imageModiService
    def fileHandleService
    def s3Service




    /**
     * 直接建立內容後回到瀏覽頁面
     */
    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def create() {
        def post = new Post(params)
        post.name = "post-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"



        [ post: post ]
    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def edit(Long id) {
        def post = Post.findByIdOrName(id, params.name)

        // def tagStr=""

        // post.tags.each() {

        //     if(tagStr!='')tagStr+=","
        //     tagStr+= it

        // };

        [ 
            post: post
        ]
    }
    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def delete(Long id) {
        def post = Post.findByIdOrName(id, params.name)
        post.delete(flush: true)

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'post.label', default: 'post'), id])

        redirect(action: "list")
    }
    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def save() {

        def user = springSecurityService.currentUser
        
        def post = new Post(params)
        


        //set current user as creator
        post.creator = user

        if (!post.validate()) {
            if(post.hasErrors())
                post.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
            render(view: "create", model: [post: post])
            return
        }
        
        post.save(flush: true)

        if(params.tags instanceof String)
            post.tags=[params.tags];
        else post.tags = params.tags

        flash.message = message(code: 'default.created.message', args: [message(code: 'post.label', default: 'Post'), post.id])
        redirect(action: "show", id: post.id)
    }

    def show(Long id) {
        def post = Post.findByIdOrName(id, params.name)
        

        if (post) {
            //點擊次數 +1
            post.hits ++;
            post.save(flush: true)
        }
        
        if (!post) {
            post = new Post(params)
        }

        def recentPosts  = Post.findAll(max: 4, sort: 'dateCreated', order: 'desc') {
            // type == PostType.DEMO
            id != post.id
        }

        
    	[
            post: post,
            recentPosts:recentPosts
        ]
    }

    def portfolio(){
        def type = PostType.NEWS
        def posts

        switch (params.type) {
            case 'DEMO':
                type = PostType.DEMO
            break
            case 'NEWS':
                type = PostType.NEWS
            break
            case 'SALE':
                type = PostType.SALE
            break
        }


        posts=Post.findAllByType(type)





        def tags=[]
        if(posts){
            posts.tags.each{ //i ->
                tags.addAll(it) 
            }

        }

        log.info tags.unique()
        log.info type

        [
            type: type,
            posts: posts,
            tags: tags.unique()
        ]

    }

    def list(){
        [
            posts: Post.list()
        ]
    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def update(Long id) {

        def post = Post.findByIdOrName(id,params.name)



        if(params.tags instanceof String)
            post.tags=[params.tags];
        else post.tags = params.tags



        if(!params.mainImage)params.mainImage="";

        
        if (!post) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list")
            return
        }

        if (params.version != null) {  
            log.info post.version
            log.info params.version


            if (post.version > (params.version as Long)) {
                post.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'post.label', default: 'Post')] as Object[],
                          "Another user has updated this User while you were editing")

                flash.message = message(code: "Another user has updated this User while you were editing")
                render(view: "edit", model: [post: post])
                return
            }
        }

        post.properties = params

        if (!post.save(failOnError: true, flush: true)) {
            render(view: "edit", model: [post: post])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'post.label', default: 'Post'), post.id])
        redirect(action: "show", id: post.id)
    }



    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def attachmentSave(){
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
    def attachmentList(Long id) {
        def post = Post.findByIdOrName(id,params.name)
        // def fileLocation=grailsApplication.config.upload.files.path;

        
        if (!post) {
            post = new Post(params)
        }

        // File dir = new File("${fileLocation}/${params.name}");

        render (template:"attachmentList", model: [
            post: post,
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
    def attachment(Long id) {
        def post = Post.findByIdOrName(id,params.name)
        //  def fileLocation=grailsApplication.config.upload.files.path;
        
        if (!post) {
            post = new Post(params)
        }

        def file = params.file

        // 將已編碼 URL 還原
        file = URLDecoder.decode(file)


        
        try {

            // File object = new File("${fileLocation}/${post.name}/${file}")

            log.info "${grailsApplication.config.grails.aws.root}/${params.name}/${file}"
            def object = s3Service.getObject("${grailsApplication.config.grails.aws.root}/${params.name}/${file}")
            response.outputStream << object.dataInputStream
        }
        catch (e) {
            e.printStackTrace()
            log.error "Could not read ${file}"
            File object = new File(servletContext.getRealPath("images/notFind.jpg"))
            response.outputStream << new FileInputStream(object)

            // response.sendError 404
        }
    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def attachmentDelete() {

        // def file = new File(params.file);
        try {
            // file.delete();

            log.info "${params.file}"

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
