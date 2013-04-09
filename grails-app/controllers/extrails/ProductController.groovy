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

    @Secured(['ROLE_OPERATOR'])
    def save={
        
        if(params?.user && params?.user!='null')
            params.user=User.findById(params.user)
        else params.user=null

        def product = new Product(params)


        


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


        if(params.q && params.q != ''){
            products= Product.search("*"+params.q+"*").results
            productCount= products.size()
        }else {
            products= Product.list(params)
            productCount= Product.count()
        }

        def unfinEvents= Event.findAllByStatus(extrails.ProductStatus.UNFIN)
        def endEvents= Event.findAllByStatus(extrails.ProductStatus.END
            ,[max:4,order:"dasc",sort:"lastUpdated"])
        [
            products: products,
            count: productCount,
            unfinEvents:unfinEvents,
            endEvents:endEvents
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
    @Secured(['ROLE_OPERATOR'])
    def edit={ Long id ->
        


        def product = Product.findByIdOrName(id, params.name)

        [ 
            product: product
        ]
    }
    @Secured(['ROLE_OPERATOR'])
    def update={ Long id ->

        if(params?.user && params?.user!='null')
            params.user=User.findById(params.user)
        else params.user=null

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

        redirect(action:"list")

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
