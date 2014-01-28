package motoranger

import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON
class EventDetailController {
    static layout="bootstrap"

    def userService


    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def create(){

    	def eventDetail=new EventDetail(params)

        eventDetail.name = "eventDetail-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

        eventDetail.price=eventDetail.part.price
        
        params.qty=1
        [
        	eventDetailInstance:eventDetail
        ]

    }

    def show(){

        def eventDetail = EventDetail.findById(params.id);

        [
            eventDetailInstance:eventDetail
        ]

    }

    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
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


        def creator = userService.currentUser().username
        eventDetail.creator = creator

        if (!eventDetail.validate()) {
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

    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def edit(){ 
        def eventDetail = EventDetail.findByIdOrName(params.id, params.name)

        [ 
            eventDetailInstance: eventDetail
        ]
    }
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
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
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
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
