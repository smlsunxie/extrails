package extrails

import grails.plugins.springsecurity.Secured

class PostController {

	static layout="bootstrap"
	def springSecurityService



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
        [ post: post ]
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
}
