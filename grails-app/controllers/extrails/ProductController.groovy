package extrails

import grails.converters.JSON
import grails.plugins.springsecurity.Secured


class ProductController {
	static layout="bootstrap"
    def s3Service
    def imageModiService
    def springSecurityService
    def messageSource

	@Secured(['ROLE_OPERATOR'])
    def create= { 

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
    def save={
        
        def user=User.findByUsername(params.username)
        if(!user){
            user=new User()
            user.username=params.username
        }

        user.title=params.userTitle
        user.telphone=params.userTelphone
        user.mobile=params.userMobile
        user.description=params.userDescription
        user.password=user.username

        user.save()
        params.user=user

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


    // def portfolio={


    //     def products=Product.list()


    //     def tags=[]
    //     if(products){
    //         products.tags.each{ //i ->
    //             tags.addAll(it) 
    //         }
    //     }

    //     [
    //         products: products,
    //         tags: tags.unique()
    //     ]

    // }
    @Secured(['ROLE_OPERATOR'])
    def list={

        def products
        def productCount

        params.sort= 'lastUpdated'
        params.order= 'desc'
        params.max=5


        if(flash.users){
            // chain from checkNameIsNew
            products=Product.findAllByUserInList(flash.users)
            productCount= products.size()
        }else if(params.q && params.q != ''){
            products= Product.search("*"+params.q+"*").results
            productCount= products.size()
        }else {
            products= Product.list(params)
            productCount= Product.count()
        }

        // def unfinEvents= Event.findAllByStatus(extrails.ProductStatus.UNFIN)
        // def endEvents= Event.findAllByStatus(extrails.ProductStatus.END
        //     ,[max:8,order:"desc",sort:"lastUpdated"])
        [
            products: products,
            count: productCount
            // ,
            // unfinEvents:unfinEvents,
            // endEvents:endEvents
        ]
    } 


    def show={ Long id ->
        def product = Product.findByIdOrName(id, params.name)
        
        [
            product: product,
            files: s3Service.getObjectList("${grailsApplication.config.grails.aws.root}/${product.name}")
        ]
    }
    @Secured(['ROLE_OPERATOR'])
    def edit={ Long id ->
        


        def product = Product.findByIdOrName(id, params.name)
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
    def update={ Long id ->

        def user=User.findByUsername(params.username)


        user.title=params.userTitle
        user.telphone=params.userTelphone
        user.mobile=params.userMobile
        user.description=params.userDescription

        params.user=user

        def product = Product.findByIdOrName(id,params.name)



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
    def delete={ Long id ->
        def product = Product.findByIdOrName(id, params.name)
        product.delete(flush: true)

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'product.label', default: 'product'), id])

        redirect(action: "list")
    }

    @Secured(['ROLE_OPERATOR'])
    def changeStatusEnd={ Long id ->

        def product=Product.findById(id)
        def lastEvent=Event.findByProductAndStatus(product,extrails.ProductStatus.UNFIN)
        
        lastEvent.status=params.status
        lastEvent.product.status=params.status

        lastEvent.save(flush: true)

        redirect(action:"index", controller:"home")

    }
    // def query= { 

    //     def product = Product.findByName(params.name)
    //     if(product){
    //         redirect(action:'show', id:product.id)
    //     }else {
    //         redirect(action:'create', params:params)
    //     }


    // }

    def checkNameIsNew={
        params.name=params.name.toUpperCase()
        def product = Product.findByName(params.name)
        if(product){
            redirect(action:'show', params:params)
        }else {

            def users= User.search('*'+params.name+'*').results
            users.each(){
                log.info it.title
            }
            if (!users)
                redirect(action:'create', params:params)
            else {
                flash.users=users
                chain(action:'list', params:params)
            }
        }

    }
    def csvImport={


        def reader = grailsAttributes.getApplicationContext().getResource("/data/product.csv").getFile().toCsvMapReader([batchSize:50])
        reader.each{ batchList ->
            batchList.each{ map ->

                map.user=User.findByUsername(map?.user)

                if(map?.years=="")map.years=null
                else map.years=new Date().parse("yyyy/M/d",map.years)

                if(map.title=="")map.title=map.name

                if(!Product.findByName(map?.name))
                    new Product(map).save(failOnError: true, flush: true)
            }
        }              


      
    }

}
