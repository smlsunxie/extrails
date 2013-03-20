package extrails

import grails.plugins.springsecurity.Secured

class PartController {
	static layout="bootstrap"
    def s3Service
    def imageModiService
    def springSecurityService
    def messageSource

	@Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def create= { 

    	def part = new Part(params)

        log.info "part.mainImage ="+part.mainImage

        if(!params.name)
    	   part.name = "part-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

        [ part: part ]

    }
    def query= { 

        def part = Part.findByName(params.name)
        if(part){
            redirect(action:'show', id:part.id)
        }else {
            redirect(action:'create', params:params)
        }


    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def save= {

        def user = springSecurityService.currentUser
        
        def part = new Part(params)
        


        //set current user as creator
        part.creator = user

        if (!part.validate()) {
            if(part.hasErrors())
                part.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
            render(view: "create", model: [part: part])
            return
        }



        
        part.save(flush: true)

        if(params.tags instanceof String)
            part.tags=[params.tags];
        else part.tags = params.tags

        flash.message = message(code: 'default.created.message', args: [message(code: 'part.label', default: 'part'), part.id])
        redirect(action: "list")
    }


    def portfolio={


        def parts=Part.list()


        def tags=[]
        if(parts){
            parts.tags.each{ //i ->
                tags.addAll(it) 
            }
        }

        [
            parts: parts,
            tags: tags.unique()
        ]

    }

    def list={
        [
            parts: Part.list()
        ]
    } 
    def show={ Long id ->
        def part = Part.findByIdOrName(id, params.name)
        
        log.info "${grailsApplication.config.grails.aws.root}/${part.name}"

        [
            part: part,
            files: s3Service.getObjectList("${grailsApplication.config.grails.aws.root}/${part.name}")
        ]
    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def edit={ Long id ->
        def part = Part.findByIdOrName(id, params.name)

        [ 
            part: part
        ]
    }
    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def update={Long id ->

        def part = Part.findByIdOrName(id,params.name)



        if(params.tags instanceof String)
            part.tags=[params.tags];
        else part.tags = params.tags



        if(!params.mainImage)params.mainImage="";

        
        if (!part) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list")
            return
        }

        if (params.version != null) {  
            log.info part.version
            log.info params.version


            if (part.version > (params.version as Long)) {
                part.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'part.label', default: 'Part')] as Object[],
                          "Another user has updated this User while you were editing")

                flash.message = message(code: "Another user has updated this User while you were editing")
                render(view: "edit", model: [part: part])
                return
            }
        }

        part.properties = params

        if (!part.save(failOnError: true, flush: true)) {
            render(view: "edit", model: [part: part])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'part.label', default: 'Part'), part.id])
        redirect(action: "show", id: part.id)
    }

}
