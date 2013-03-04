package extrails

import grails.plugins.springsecurity.Secured
import org.grails.taggable.Tag
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

    def update(Long id, Long version) {

        def post = Post.get(id)

        post.tags = params.tags
        
        if (!post) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {  
            if (post.version > version) {
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

    def attachment = {
        try {

            // 根據運行環境給定不同的檔案路徑
            String storagePath = ""
            if (GrailsUtil.environment == "production") {
              storagePath = "/opt/uploadfiles"
            } else {
              def servletContext = ServletContextHolder.servletContext
              storagePath = servletContext.getRealPath('tmp/uploadfiles')
            }

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


}
