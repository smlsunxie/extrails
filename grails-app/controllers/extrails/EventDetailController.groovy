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


    	if(params?.head)
    		eventDetail.head=Event.findById(params.head)

		if(params?.part && params?.part!='null'){
			eventDetail.part=Part.findById(params?.part)
            eventDetail.price=eventDetail.part.price
        }
        
        params.qty=1
        [
        	eventDetail:eventDetail
        ]

    }

    def save={


    	if(params?.head && params?.head!='null')
    		params.head=Event.findById(params.head)

		if(params?.part && params?.part!='null')
			params.part=Part.findById(params?.part)
        else params.part=null

        if(!params?.name)
            params.name = "eventDetail-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"
        
        if(!params?.qty)
            params?.qty=1


        def eventDetail=new EventDetail(params)

        eventDetail.creator=springSecurityService.currentUser.username

        if (!eventDetail.validate()) {
            if(eventDetail.hasErrors())
                eventDetail.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
            redirect(action: "portfolio", controller:"part"
                , params:[event:params?.head])
            return
        }

        // eventDetail define hasMany
        // cause error:a different object with the same identifier value was already associated with the session: [extrails.EventDetail#1]
        // use merge for Copy the state of the given object onto the persistent object with the same identifier
        eventDetail.merge(flush: true)
        eventDetail=EventDetail.findByName(params.name)
        
        flash.message = message(code: 'default.created.message', 
            args: [message(code: 'event.label', default: 'event'), eventDetail.id])


        redirect(action: "portfolio", controller:"part"
            , params:[event:eventDetail.head.id])



    }
    @Secured(['ROLE_OPERATOR'])
    def edit={ Long id ->
        def eventDetail = EventDetail.findByIdOrName(id, params.name)

        [ 
            eventDetail: eventDetail
        ]
    }
    @Secured(['ROLE_OPERATOR'])
    def update={Long id ->

        def eventDetail = EventDetail.findByIdOrName(id, params.name)

        if(params?.head && params?.head!='null')
            params.head=Event.findById(params.head)

        if(params?.part && params?.part!='null')
            params.part=Part.findById(params?.part)
        else params.part=null


        if(!params.mainImage)params.mainImage="";

        
        if (!eventDetail) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list", controller:"product")
            return
        }


        eventDetail.properties = params

        if (!eventDetail.save(failOnError: true, flush: true)) {
            render(view: "edit", model: [eventDetail: eventDetail])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'eventDetail.label', default: 'EventDetail'), eventDetail.id])
        redirect(action: "list", params:[event: eventDetail.head.id])
    }
    def delete={ Long id ->

        def eventDetail = EventDetail.findById(id)
        def headId=eventDetail.head.id


        eventDetail.delete(flush:true)

        redirect(action: "list", controller:"eventDetail"
            , params:[event:headId])

    }

    def list={


        def event=Event.findById(params.event)


        [
            event: event
        ]
    }


}