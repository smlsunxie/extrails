package motoranger

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured


class ProductController {
	static layout="bootstrap"
    def s3Service
    def imageModiService
    def userService

    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def create(){ 

    	def product = new Product(params)

        if(product?.name)
            product.title=product.name

        [ product: product ]

    }


    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def save(){
        
        def product = new Product(params);

        product.creator = userService.currentUser().username

        def user = User.findByUsername(params.name)

        if(user){
            product.user = user
        }

        if (!product.validate()) {

            render(view: "create", model: [product: product])
            return
        }

        product.save(flush: true)

        flash.message = message(code: 'default.created.message', args: [message(code: 'product.label', default: 'product'), product])   

        redirect(action: "show", id:product.id)
    }


    def show(){ 
        def product = Product.findById(params.id)

        def eventUnFin = Event.findByProductAndStatus(product, motoranger.ProductStatus.UNFIN)

        def statusEnd = false
        if(!eventUnFin) statusEnd =true
        
        [
            product: product,
            statusEnd :statusEnd
        ]
    }
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def edit(){ 
        
        def product = Product.findById(params.id)


        if(params?.user?.id){
            product?.user = User.findByUsername(params?.user?.id)
        }
        
        if(!product?.user){
            product.user=User.findByUsername(product.name)
        }

        
        [ 
            product: product
        ]
    }
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def update(){ 

        def product = Product.findById(params.id)



        if(!params.mainImage)params.mainImage="";

        
        if (!product) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), product])
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

        if (!product.validate() && !product.save()) {
            render(view: "edit", model: [product: product])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'product.label', default: 'Product'), product])
        redirect(action: "show", id: product.id)
    }
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def delete(){ 
        def product = Product.findById(params.id)
        
        try{
            product.delete(flush: true,failOnError:true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'product.label', default: 'product'), product])
            redirect(action: "redirect", controller: "home")
        }catch (Exception e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), product])
            redirect(action: "show", id: product.id)
        }
    }




}
