package extrails

import grails.plugins.springsecurity.Secured
import org.grails.taggable.Tag
import grails.converters.JSON

import static org.codehaus.groovy.grails.commons.ConfigurationHolder.config as Config
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


    /**
     * 直接建立內容後回到瀏覽頁面
     */
    @Secured(['ROLE_USER'])
    def create() {
        def post = new Post(params)
        post.name = "news-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"



        [ post: post ]
    }

    @Secured(['ROLE_USER'])
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

    @Secured(['ROLE_USER'])
    def save() {

        def user = springSecurityService.currentUser
        
        def post = new Post(params)
        


        //set current user as creator
        post.creator = user

       
        
        if (!post.save(failOnError: true, flush: true)) {
            render(view: "create", model: [post: post])
            return
        }

         post.tags = params.tags // new line to be inserted

        flash.message = message(code: 'default.created.message', args: [message(code: 'post.label', default: 'Post'), post.id])
        redirect(action: "show", params: [name: post.name])
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
        
    	[post: post]
    }

    def list(){


        [
            posts: Post.list()
        ]

    }

    def update(Long id) {

        def post = Post.findByIdOrName(id,params.name)

        log.info params.tags instanceof String


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
            if (post.version > params.version) {
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
        redirect(action: "show", params: [name: post.name])
    }

    def tags = {
        render Tag.findAllByNameIlike("${params.term}%").name as JSON
    }

    def attachmentSave = {
        try {

            // 根據運行環境給定不同的檔案路徑
            String storagePath = Config.upload.files.path

            storagePath+="/${params.id}"

            //檢查路徑是否存在，若不存在則產生資料夾
            def storagePathDirectory = new File(storagePath)
            if (!storagePathDirectory.exists()) {
              print "CREATING DIRECTORY ${storagePath}: "
              if (storagePathDirectory.mkdirs()) {
                println "SUCCESS"
              } else {
                println "FAILED"
              }
            }

            // 定義上傳的檔案名稱
            File uploaded = new File("${storagePathDirectory}/${params.qqfile}")

            // 將使用者上傳檔案的 inputStream 指定給 uploaded 完成檔案儲存
            ajaxUploaderService.upload(request.inputStream, uploaded)


            return render(text: [success:true] as JSON, contentType:'text/json')

        } catch (FileUploadException e) {

            log.error("Failed to upload file.", e)
            return render(text: [success:false] as JSON, contentType:'text/json')

        }

    }


    /**
     * 附件上傳及清單（顯示在 iframe 頁框內）
     */
    def attachmentList(Long id) {
        def post = Post.findByIdOrName(id,params.name)


        
        if (!post) {
            post = new Post(params)
        }


        File dir = new File("${Config.upload.files.path}/${params.name}");

        render (template:"attachmentList", model: [
            post: post,
            files: dir.listFiles()
        ])

        
    }
    /**
     * 讀取附件
     */
    def attachment(Long id) {
       def post = Post.findByIdOrName(id,params.name)
        
        if (!post) {
            post = new Post(params)
        }

        def file = params.file

        // 將已編碼 URL 還原
        file = URLDecoder.decode(file)

        log.info "${Config.upload.files.path}${post.name}/${file}"
        
        try {

            File object = new File("${Config.upload.files.path}/${post.name}/${file}")
            response.outputStream << new FileInputStream(object)
        }
        catch (e) {
            log.error "Could not read ${file}"
            e.printStackTrace()
            response.sendError 404
        }
    }

    def attachmentDelete(Long id) {

        def file = new File(params.file);
        try {
            file.delete();
            return render(text: [success:true] as JSON, contentType:'text/json')
        }
        catch (e) {
            log.error "Could not read ${file}"
            e.printStackTrace()
            return render(text: [success:false] as JSON, contentType:'text/json')
        }
        
        
    }

}
