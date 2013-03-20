package extrails


import grails.plugins.springsecurity.Secured

class ServiceEventController {

	static layout="bootstrap"
    def springSecurityService
    def messageSource

    @Secured(['ROLE_MANERGER','ROLE_ADMIN','ROLE_CLERK'])
    def create= { 

        def serviceEvent = new ServiceEvent(params);

        if(!params?.user)serviceEvent.user= springSecurityService.currentUser
        if(!params?.name)serviceEvent.name = "serviceEvent-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"
        if(params?.partId)serviceEvent.part=Part.findById(params?.partId)


    	[
            serviceEvent:serviceEvent
    	]

    }

    def save={
        def serviceEvent = new ServiceEvent(params);

        // if(params?.partId==)

        if(params?.partId && params?.partId!='null')serviceEvent.part=Part.findById(params?.partId)
        if(params?.userId && params?.userId!='null')serviceEvent.user=User.findById(params?.userId)
        if(params?.productId && params?.productId!='null')serviceEvent.product=Product.findById(params?.productId)

        session.partId=params?.partId
        session.userId=params?.userId
        session.productId=params?.productId




        if (!serviceEvent.validate()) {
            if(serviceEvent.hasErrors())
                serviceEvent.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
            render(view: "create", model: [serviceEvent: serviceEvent])
            return
        }



        serviceEvent.save(flush: true)
        
        flash.message = message(code: 'default.created.message', 
            args: [message(code: 'serviceEvent.label', default: 'serviceEvent'), serviceEvent.id])

        session.partId=null
        session.userId=null
        session.productId=null
        redirect(action: "list")


    }

    def list={
        [
            serviceEvents: ServiceEvent.list()
        ]
    }
}
