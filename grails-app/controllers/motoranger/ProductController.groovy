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
            product.name = "product-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"
        else {
            product.title=product.name
        }


        product.user=User.findByUsername(product.name)
        if(!product?.user){
            product.user=new User()
            product.user.username=product.name
            product.user.title=product.name
        }



        [ product: product ]

    }


    @Secured(['ROLE_OPERATOR'])
    def save(){
        
        def user=User.findById(params["user.id"])
        if(!user){

            params.user.password=params.user.username
            user=new User(params.user)
            user.save(flush: true,failOnError:true)      
            params["user.id"]=user.id
        }

        def product = Product.findByName(params.name);


        if(!product) 
            product = new Product(params);
        else 
            product.properties = params



        


        //set current user as creator
        product.creator = springSecurityService.currentUser.username

        if (!product.validate()) {
            if(product.hasErrors())
                product.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
            render(view: "create", model: [product: product])
            return
        }

        product.save(flush: true)

        // if(params.tags instanceof String)
        //     product.tags=[params.tags];
        // else product.tags = params.tags

        flash.message = message(code: 'default.created.message', args: [message(code: 'product.label', default: 'product'), product.id])
        redirect(action: "show", id:product.id)
    }



    @Secured(['ROLE_OPERATOR'])
    def list(){

        def products
        def productCount


        params.sort= 'lastUpdated'
        params.order= 'desc'
        params.max=5

        if(params.q && params.q != ''){
            def users= User.search('*'+params.q+'*',[max:9999]).results
            products=Product.findAllByUserInList(users,params)
            productCount= Product.findAllByUserInList(users).size()
        }else {
            log.info "search 3"
            products= Product.list(params)
            productCount= Product.count()
        }

        [
            products: products,
            count: productCount
        ]
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
        
        if(!product?.user){
            def user=new User()
            user.username=product.name
            user.title=product.name
            user.password=user.username
            user.save()
            product.user=user
            product.save(flush:true)
        }


        [ 
            product: product
        ]
    }
    @Secured(['ROLE_OPERATOR'])
    def update(){ 

        // def user=User.findByUsername(params.username)


        // user.title=params.userTitle
        // user.telphone=params.userTelphone
        // user.mobile=params.userMobile
        // user.description=params.userDescription



        // params.user=user

        def product = Product.findByIdOrName(params.id,params.name)



        // if(params.tags instanceof String)
        //     product.tags=[params.tags];
        // else product.tags = params.tags



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


    def checkNameIsNew(){
        params.name=params.name.toUpperCase()
        def product = Product.findByName(params.name)
        if(product){
            redirect(action:'show', params:params)
        }else {

            def users= User.search('*'+params.name+'*',[max:1]).results


            //如果檢查使用者查出來的資料只有一筆，且查詢內容與使用者名稱相同，就視為有 user 沒有 product 所以要進行建立的動作
            if (!users 
                || (users.size()==1 && !Product.findByUser(users.get(0)) ) 
            )
                redirect(action:'create', params:params)
            else {
                params.q=params.name.toUpperCase()
                chain(action:'list', params:params)
            }
        }

    }

}
