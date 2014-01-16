package motoranger

import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON
class EventDetailController {
    static layout="bootstrap"

    def springSecurityService
    def messageSource


    @Secured(['ROLE_CUSTOMER'])
    def create(){

    	def eventDetail=new EventDetail(params)

        eventDetail.name = "eventDetail-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

        eventDetail.price=eventDetail.part.price
        
        params.qty=1
        [
        	eventDetail:eventDetail
        ]

    }

    def show(){

        def eventDetail = EventDetail.findById(params.id);

        [
            eventDetail:eventDetail
        ]

    }

    @Secured(['ROLE_CUSTOMER'])
    def save(){

        println params
        if(!params?.name)
            params.name = "eventDetail-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"
        

        if(!params?.qty)
            params?.qty=1


        def eventDetail = EventDetail.findByName(params.name);

        if(!eventDetail) 
            eventDetail = new EventDetail(params);
        else 
            eventDetail.properties = params


        def creator = springSecurityService.currentUser.username
        eventDetail.creator = creator

        if (!eventDetail.validate()) {
            if(eventDetail.hasErrors())
                eventDetail.errors?.allErrors?.each{ 
                    println  messageSource.getMessage(it, null)
                };
            redirect(uri: request.getHeader('referer') )
            return
        }

        if(eventDetail.cost == 0){
            eventDetail.cost = eventDetail.part.cost 
        }

        eventDetail.save(flush: true)


        
        flash.message = message(code: 'default.created.message', 
            args: [message(code: 'event.label', default: 'event'), eventDetail])


        if(request.getHeader('referer').indexOf("part/create?event.id")!=-1){
            redirect(controller:"event", action:"pickPartAddDetail", id:params.head.id)
        }else 
            redirect(uri: request.getHeader('referer') )


    }

    @Secured(['ROLE_CUSTOMER'])
    def edit(){ 
        def eventDetail = EventDetail.findByIdOrName(params.id, params.name)

        [ 
            eventDetail: eventDetail
        ]
    }
    @Secured(['ROLE_CUSTOMER'])
    def update(){

        def eventDetail = EventDetail.get(params.id)

        
        if (!eventDetail) {
            flash.message = message(code: 'default.not.found.message',
                args: [message(code: 'part.label', default: 'part'), eventDetail])
            redirect(action: "list", controller:"product")
            return
        }


        eventDetail.properties = params





        if (!eventDetail.save(flush: true)) {
            render(view: "edit", model: [eventDetail: eventDetail])
            return
        }



        flash.message = message(code: 'default.updated.message', args: [message(code: 'eventDetail.label', default: 'EventDetail'), eventDetail])
        redirect(action: "show", controller:"event", id: eventDetail.head.id)


    }
    @Secured(['ROLE_CUSTOMER'])
    def delete(){ 

        def eventDetail = EventDetail.findById(params.id)
        def headId=eventDetail.head.id

        def event = Event.findById(headId)
        event.totalPrice -=  eventDetail.price * eventDetail.qty
        event.save()

        eventDetail.delete(flush:true)


        flash.message = message(code: 'default.deleted.message', args: [message(code: 'part.label', default: 'part'), eventDetail])


        if(request.getHeader('referer').indexOf("/eventDetail/show") != -1)
            redirect(action: "show", controller:"event", id:headId)
        else redirect(uri: request.getHeader('referer') )

    }



}
