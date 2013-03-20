package extrails


import grails.plugins.springsecurity.Secured

class ServiceEventController {

	static layout="bootstrap"
    def springSecurityService
    def messageSource

    @Secured(['ROLE_MANERGER','ROLE_ADMIN','ROLE_CLERK'])
    def create= { 

        def serviceEvent = new ServiceEvent(params);

        // if(params?.part)serviceEvent.part=Part.findById params?.part
        // if(params?.user)serviceEvent.user=User.findById params?.user
        // else 

        if(!params?.user)serviceEvent.user= springSecurityService.currentUser

        // if(params?.product)serviceEvent.user=Product.findById params?.product 
        if(!params?.name)serviceEvent.name = "serviceEvent-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"


        if(params?.partId)serviceEvent.part=Part.findById(params?.partId)


    	def roleClerk = Role.findByAuthority('ROLE_CLERK')

    	def users = UserRole.findAllByRole(roleClerk)*.user

        def products=Product.list()

        def parts = Part.list()

    	[
            serviceEvent:serviceEvent,
    		users:users,
            parts:parts,
            products:products
    	]

    }

    def save={
        def serviceEvent = new ServiceEvent(params);


        if(params?.part)serviceEvent.part=Part.findById(params?.part)
        if(params?.user)serviceEvent.user=User.findById(params?.user)
        if(params?.product)serviceEvent.product=Product.findById(params?.product)





        if (!serviceEvent.validate()) {
            if(serviceEvent.hasErrors())
                serviceEvent.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
                params.serviceEvent=serviceEvent
            redirect(action: "create")
            return
        }



        serviceEvent.save(flush: true)
        
        flash.message = message(code: 'default.created.message', 
            args: [message(code: 'serviceEvent.label', default: 'serviceEvent'), serviceEvent.id])
        redirect(action: "list")


    }

    def list={

    }
}
