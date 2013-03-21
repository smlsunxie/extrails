package extrails

import grails.plugins.springsecurity.Secured
class ServiceEventDetailController {
    static layout="bootstrap"

    def springSecurityService
    def messageSource

    @Secured(['ROLE_MANERGER','ROLE_ADMIN','ROLE_CLERK'])
    def create= { 

    	def serviceEventDetail=new ServiceEventDetail(params)

        serviceEventDetail.name = "serviceEventDetail-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"


    	if(params?.serviceEvent)
    		serviceEventDetail.head=ServiceEvent.findById(params.serviceEvent)

		if(params?.partId && params?.partId!='null')
			serviceEventDetail.part=Part.findById(params?.partId)


        params?.user=springSecurityService.currentUser
        






        [
        	serviceEventDetail:serviceEventDetail
        ]

    }

    def save={

    	if(params?.head && params?.head!='null')
    		params.head=ServiceEvent.findById(params.head)

		if(params?.part && params?.part!='null')
			params.part=Part.findById(params?.part)
        else params.part=null

        if(params?.user && params?.user!='null')
        	params.user= User.findById(params.user)

        def serviceEventDetail=new ServiceEventDetail(params)

        serviceEventDetail.creator=springSecurityService.currentUser

        if (!serviceEventDetail.validate()) {
            if(serviceEventDetail.hasErrors())
                serviceEventDetail.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
            render(view: "create", model: [serviceEventDetail: serviceEventDetail])
            return
        }



        serviceEventDetail.save(flush: true)
        
        flash.message = message(code: 'default.created.message', 
            args: [message(code: 'serviceEvent.label', default: 'serviceEvent'), serviceEventDetail.id])


        redirect(action: "list", controller:"ServiceEvent")



    }

    def list={

        def serviceEvent=ServiceEvent.findById(params.serviceEvent)


        [
            serviceEvent: serviceEvent
        ]
    }


}
