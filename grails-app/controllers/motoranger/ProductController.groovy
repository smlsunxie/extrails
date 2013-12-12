package motoranger

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured


class ProductController {
	static layout="bootstrap"
    def s3Service
    def imageModiService
    def springSecurityService
    def messageSource

	@Secured(['ROLE_OPERATOR'])
    def create(){ 

    	def product = new Product(params)


        if(!params.name)
            product.title=product.name


        [ product: product ]

    }


    @Secured(['ROLE_OPERATOR'])
    def save(){
        
        def product = new Product(params);

        product.creator = springSecurityService.currentUser.username

        def user = User.findByUsername(params.name)

        if(user){
            product.user = user
        }

        if (!product.validate()) {
            if(product.hasErrors())
                product.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
            render(view: "create", model: [product: product])
            return
        }

        product.save(flush: true)

        flash.message = message(code: 'default.created.message', args: [message(code: 'product.label', default: 'product'), product.id])
        redirect(action: "show", id:product.id)
    }

    def show(){ 
        def product = Product.findByIdOrName(params.id, params.name)
        
        [
            product: product
        ]
    }
    @Secured(['ROLE_OPERATOR'])
    def edit(){ 
        
        def product = Product.findByIdOrName(params.id, params.name)
        if(!product?.user)product.user=User.findByUsername(product.name)
        
        [ 
            product: product
        ]
    }
    @Secured(['ROLE_OPERATOR'])
    def update(){ 

        def product = Product.findByIdOrName(params.id,params.name)



        if(!params.mainImage)params.mainImage="";

        
        if (!product) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list")
            return
        }

        if (params.version != null) {  



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
    @Secured(['ROLE_OPERATOR'])
    def delete(){ 
        def product = Product.findByIdOrName(params.id, params.name)
        product.delete(flush: true)

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'product.label', default: 'product'), id])

        redirect(action: "list")
    }




}
