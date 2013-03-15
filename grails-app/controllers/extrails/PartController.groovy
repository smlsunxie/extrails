package extrails

import grails.plugins.springsecurity.Secured
import grails.plugins.springsecurity.Secured
import org.grails.taggable.Tag
class PartController {
	static layout="bootstrap"

	@Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def create() { 

    	def part = new Part(params)

        if(!params.name)
    	   part.name = "part-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

        [ part: part ]

    }

    @Secured(['ROLE_MANERGER','ROLE_ADMIN'])
    def save() {

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
}
