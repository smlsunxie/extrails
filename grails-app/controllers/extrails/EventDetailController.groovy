package extrails

import grails.plugins.springsecurity.Secured
class EventDetailController {
    static layout="bootstrap"

    def springSecurityService
    def messageSource

    @Secured(['ROLE_OPERATOR'])
    def create= { 

    	def eventDetail=new EventDetail(params)

        eventDetail.name = "eventDetail-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"


    	if(params?.event)
    		eventDetail.head=Event.findById(params.event)

		if(params?.partId && params?.partId!='null')
			eventDetail.part=Part.findById(params?.partId)




            params.qty=1
        






        [
        	eventDetail:eventDetail
        ]

    }

    def save={

        log.info params.head

    	if(params?.head && params?.head!='null')
    		params.head=Event.findById(params.head)

		if(params?.part && params?.part!='null')
			params.part=Part.findById(params?.part)
        else params.part=null


        def eventDetail=new EventDetail(params)

        eventDetail.creator=springSecurityService.currentUser.username

        if (!eventDetail.validate()) {
            if(eventDetail.hasErrors())
                eventDetail.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
            render(view: "create", model: [eventDetail: eventDetail])
            return
        }

        // eventDetail define hasMany
        // cause error:a different object with the same identifier value was already associated with the session: [extrails.EventDetail#1]
        // use merge for Copy the state of the given object onto the persistent object with the same identifier
        eventDetail.merge(flush: true)
        eventDetail=EventDetail.findByName(params.name)
        
        flash.message = message(code: 'default.created.message', 
            args: [message(code: 'event.label', default: 'event'), eventDetail.id])


        redirect(action: "list", controller:"EventDetail", params:[event:eventDetail.head.id])



    }

    def list={


        def event=Event.findById(params.event)


        [
            event: event
        ]
    }


}
