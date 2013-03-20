package extrails

import grails.converters.JSON
import grails.plugins.springsecurity.Secured


class ProductController {
	static layout="bootstrap"
    def s3Service
    def imageModiService
    def springSecurityService
    def messageSource

	@Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def create= { 

    	def product = new Product(params)

        log.info "product.mainImage ="+product.mainImage

        if(!params.name)
    	   product.name = "product-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

        [ product: product ]

    }
    def query= { 

        def product = Product.findByName(params.name)
        if(product){
            redirect(action:'show', id:product.id)
        }else {
            redirect(action:'create', params:params)
        }


    }

    def checkNameIsNew={
        log.info params.name
        def product = Product.findByName(params.name)
        if(product){
            render(text: [success:false] as JSON, contentType:'text/json')
        }else render(text: [success:true] as JSON, contentType:'text/json')

    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def save={

        def user = springSecurityService.currentUser
        
        // if(!params?.owner){
        // 	params.owner=user
        // }

        def product = new Product(params)


        


        //set current user as creator
        product.creator = user

        if (!product.validate()) {
            if(product.hasErrors())
                product.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
            render(view: "create", model: [product: product])
            return
        }



        
        product.save(flush: true)

        if(params.tags instanceof String)
            product.tags=[params.tags];
        else product.tags = params.tags

        flash.message = message(code: 'default.created.message', args: [message(code: 'product.label', default: 'product'), product.id])
        redirect(action: "list")
    }


    def portfolio={


        def products=Product.list()


        def tags=[]
        if(products){
            products.tags.each{ //i ->
                tags.addAll(it) 
            }
        }

        [
            products: products,
            tags: tags.unique()
        ]

    }

    def list={
        [
            products: Product.list()
        ]
    } 
    def show={ Long id ->
        def product = Product.findByIdOrName(id, params.name)
        
        log.info "${grailsApplication.config.grails.aws.root}/${product.name}"

        [
            product: product,
            files: s3Service.getObjectList("${grailsApplication.config.grails.aws.root}/${product.name}")
        ]
    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def edit={ Long id ->
        def product = Product.findByIdOrName(id, params.name)

        [ 
            product: product
        ]
    }
    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def update={ Long id ->

        def product = Product.findByIdOrName(id,params.name)



        if(params.tags instanceof String)
            product.tags=[params.tags];
        else product.tags = params.tags



        if(!params.mainImage)params.mainImage="";

        
        if (!product) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list")
            return
        }

        if (params.version != null) {  
            log.info product.version
            log.info params.version


            if (product.version > (params.version as Long)) {
                product.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'product.label', default: 'Product')] as Object[],
                          "Another user has updated this User while you were editing")

                flash.message = message(code: "Another user has updated this User while you were editing")
                render(view: "edit", model: [product: product])
                return
            }
        }

        product.properties = params

        if (!product.save(failOnError: true, flush: true)) {
            render(view: "edit", model: [product: product])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'product.label', default: 'Product'), product.id])
        redirect(action: "show", id: product.id)
    }

}
