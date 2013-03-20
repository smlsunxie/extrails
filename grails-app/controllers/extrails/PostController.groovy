package extrails

import grails.plugins.springsecurity.Secured

class PostController {

	static layout="bootstrap"
	def springSecurityService
    def messageSource





    /**
     * 直接建立內容後回到瀏覽頁面
     */
    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def create={
        def post = new Post(params)
        post.name = "post-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

        def products=Product.list()
        // def products=Product.executeQuery(
        //    'from Product p where p not in ' +
        //        '(:products)',
        //    [products: Post.list()*.product])


        // def tagStr=""

        // post.tags.each() {

        //     if(tagStr!='')tagStr+=","
        //     tagStr+= it

        // };
        log.info products.size()

        [ 
            products:products,
            post: post
        ]
    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def edit={Long id ->
        def post = Post.findByIdOrName(id, params.name)


        def products=Product.list()

        log.info products.size()

        [ 
            products:products,
            post: post
        ]
    }
    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def delete={ Long id ->
        def post = Post.findByIdOrName(id, params.name)
        post.delete(flush: true)

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'post.label', default: 'post'), id])

        redirect(action: "list")
    }
    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def save={

        def user = springSecurityService.currentUser

        if(params?.product)params.product=Product.findById(params?.product)
        
        def post = new Post(params)


        log.info "params.product="+post.product
        


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

    def show={ Long id ->
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

        ProductController productController = new ProductController()

        
    	[
            productShow:(post?.product?.id ? productController.show(post.product.id):null),
            post: post,
            recentPosts:recentPosts
        ]
    }

    def portfolio={
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

    def list={
        [
            posts: Post.list()
        ]
    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def update={ Long id ->

        log.info "params.product="+ params.product



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

        if(params.product!='null')params.product=Product.findById(params?.product)
        else params.product=null;

        log.info "params.product="+params.product

        post.properties = params




        if (!post.save(failOnError: true, flush: true)) {
            render(view: "edit", model: [post: post])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'post.label', default: 'Post'), post.id])
        redirect(action: "show", id: post.id)
    }





}
