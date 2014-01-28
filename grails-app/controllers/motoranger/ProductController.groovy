package motoranger

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ProductController {
	static layout="bootstrap"
    def userService

    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def create(){ 

    	def product = new Product(params)

        if(product?.name)
            product.title=product.name

        respond product
    }


    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    @Transactional
    def save(Product productInstance){

        productInstance.creator = userService.currentUser().username

        def user = User.findByUsername(params.name)

        if(user){
            productInstance.user = user
        }

        if (productInstance.hasErrors()) {
            respond productInstance.errors, view:'create'
            return
        }

        productInstance.save flush:true, failOnError: true

        request.withFormat {
            '*' { 
                flash.message = message(code: 'default.created.message', args: [message(code: 'product.label', default: 'Product'), productInstance])
                redirect productInstance
            }
        }
    }


    def show(Product productInstance) {
        if (productInstance == null) {
            notFound()
            return
        }

        def eventUnFin = Event.findByProductAndStatus(productInstance, motoranger.ProductStatus.UNFIN)

        def statusEnd = false
        if(!eventUnFin) statusEnd =true

        respond productInstance, model: [statusEnd :statusEnd]
    }

    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    @Transactional
    def edit(Product productInstance) {
        if (productInstance == null) {
            notFound()
            return
        }        
        if(params?.user?.id){
            productInstance?.user = User.findByUsername(params?.user?.id)
        }
        
        if(!productInstance?.user && productInstance?.name){
            productInstance.user=User.findByUsername(productInstance.name)
        }        
        respond productInstance
    }

    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def update(Product productInstance) {
        if (productInstance == null) {
            notFound()
            return
        }

        if(!productInstance.mainImage)productInstance.mainImage="";


        if (productInstance.hasErrors()) {
            respond productInstance.errors, view:'edit'
            return
        }

        productInstance.save flush:true

        request.withFormat {
            '*' {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Product.label', default: 'Product'), productInstance.id])
                redirect productInstance
            }
        }
    }

    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    @Transactional
    def delete(Product productInstance) {
        if (productInstance == null) {
            notFound()
            return
        }
        productInstance.delete flush:true

        request.withFormat {
            '*' { 
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Product.label', default: 'Product'), productInstance])
                redirect controller: "home", action: "redirect"
            }
        }

        
    }

    protected void notFound() {
        request.withFormat {
            '*'{                 
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'productInstance.label', default: 'Product'), params.id])
                redirect controller: "home", action: "redirect"
            }
        }        
    }

}
