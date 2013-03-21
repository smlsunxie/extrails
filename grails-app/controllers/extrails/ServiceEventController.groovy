package extrails


import grails.plugins.springsecurity.Secured

class ServiceEventController {

	static layout="bootstrap"
    def springSecurityService
    def messageSource

    @Secured(['ROLE_MANERGER','ROLE_ADMIN','ROLE_CLERK'])
    def create= { 

        def serviceEvent = new ServiceEvent(params);

        serviceEvent.name = "serviceEvent-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

    	[
            serviceEvent:serviceEvent
    	]

    }

    def save={
        
       
        // if(params?.partId==)

        if(params?.product && params?.product!='null')
            params.product=Product.findById(params?.product)

        def serviceEvent = new ServiceEvent(params);
        serviceEvent.creator=springSecurityService.currentUser

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


        redirect(action: "create", controller:"ServiceEventDetail", params:[serviceEvent:serviceEvent.id])


    }

    def list={

        [
            serviceEvents: ServiceEvent.list()
        ]
    }
}
