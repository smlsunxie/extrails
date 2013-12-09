package motoranger

import grails.converters.JSON

import org.jsoup.Jsoup
import org.jsoup.nodes.*
import org.jsoup.select.*
import grails.plugin.springsecurity.annotation.Secured

class EventController {

	static layout="bootstrap"
    def springSecurityService
    def messageSource

    @Secured(['ROLE_OPERATOR'])
    def create() { 

        def unfinEvent

        if(params?.event?.id){
             unfinEvent=Event.findById(params?.event.id)
        
        }else if(params?.product?.id){
            params.product=Product.findById(params.product.id)

            params.mileage=params.product.mileage
            
            unfinEvent = Event.findByProductAndStatus(params.product,motoranger.ProductStatus.UNFIN)
        }

        if(unfinEvent){
            redirect(controller:"part", action:"portfolio", params:['event.id':unfinEvent.id])
        } 

        def event = new Event(params);
        event.user=springSecurityService.currentUser
        event.store=springSecurityService.currentUser.store

        event.name = "event-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

    	[
            event:event
    	]

    }


    @Secured(['ROLE_OPERATOR'])
    def save() {
        

        def event = Event.findByName(params.name);

        if(!event) 
            event = new Event(params);
        else event.properties = params
        
        event.creator=springSecurityService.currentUser.username




        if (!event.validate()) {
            if(event.hasErrors())
                event.errors?.allErrors?.each{ 
                    flash.message=  messageSource.getMessage(it, null)
                };
            render(view: "create", model: [event: event])
            return
        }


        if(event.product.mileage.toLong() < params.mileage.toLong()){
            event.product.mileage=params.mileage.toLong()
        }

        event.product.status=motoranger.ProductStatus.UNFIN
        event.save(flush: true)
        // event=Event.findByName(params.name)

        
        flash.message = message(code: 'default.created.message', 
            args: [message(code: 'event.label', default: 'event'), event.id])


        redirect(action: "show", id: event.id)


    }
    @Secured(['ROLE_OPERATOR'])
    def pickPartAddDetail(){

        def parts
        def event
        def tags
        if(params?.id){
            event=Event.findById(params?.id,[sort: 'dateCreated', order: 'desc'])
        }

        if(params?.tag){
            parts=Part.findAllByTag(params.tag,[sort: 'title', order: 'asc'])
        }

        


        [
            parts: parts,
            event:event
        ]

    }


    @Secured(['ROLE_OPERATOR'])
    def delete() { 

        def event=Event.findById(params.id)

        if(event.status==motoranger.ProductStatus.UNFIN){
            event.product.status=motoranger.ProductStatus.END
            event.product.save(flush:true)
        }

        def details=EventDetail.findAllByHead(event)

        event?.details?.each(){
            it.delete()
        }
        // event.save()
        event.delete(flush:true)

        flash.message = message(code: 'default.delete.message', 
            args: [message(code: 'event.label', default: 'event'), event.id])

        redirect(action: "index", controller:"home")


    }
    @Secured(['ROLE_OPERATOR'])
    def edit() { 
        def event = Event.findByIdOrName(params.id, params.name)

        [ 
            event: event
        ]
    }
    @Secured(['ROLE_OPERATOR'])
    def update() {

        def event = Event.findByIdOrName(params.id, params.name)

        
        if (!event) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), id])
            redirect(action: "index", controller:"home")
            return
        }


        event.properties = params

        if(params.mileage && event.product.mileage.toLong() < params.mileage.toLong()){
            event.product.mileage=params.mileage.toLong()
        }

        if (!event.save(failOnError: true, flush: true)) {
            render(view: "edit", model: [event: event])
            return
        }


        flash.message = message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'event'), event.id])
        
        if(request.getHeader('referer').indexOf("event/pickPartAddDetail") != -1
            || request.getHeader('referer').indexOf("/store/") != -1){
             redirect(uri: request.getHeader('referer') )
        }else {
            redirect(action: "show", id:event.id)
        }
    }

    @Secured(['ROLE_OPERATOR'])
    def updateReceivedMoney() { 

        def event=Event.findById(params.id)
        try{
            if(!params.value)params.value=0

            def receivedMoney=params.value.toLong()

            // if(event?.details)totalPrice=event?.details.price.sum()



            if(receivedMoney<=event.totalPrice){

                event.receivedMoney=params.value.toLong()

                event.save(flush:true,failOnError:true)

                params.success=true

            }else {
                params.success=false
                params.msg="已收金額超過總價"
            }
            
        }catch(Exception e){
            params.success=false
            params.msg="請輸入數值資料"
        }

        params.event=event

        render params as JSON


    }
    @Secured(['ROLE_OPERATOR'])
    def updateDate() { 


        def event=Event.findById(params.id)
        try{



            event.date=new Date(params.date.toLong())

            event.save(flush:true,failOnError:true)

            params.success=true


            
        }catch(Exception e){
            params.success=false
            params.msg="更新日期異常！"
        }

        params.event=event

        log.info params.event.date

        params.date=event.date.format("yyyy-MM-dd")


        render params as JSON


    }
    def list() {

        def events
        def count=1

        params.sort= 'lastUpdated'
        params.order= 'desc'

        def currentUser=springSecurityService.currentUser
        if(params?.product?.id){
            if(!currentUser)params.max=1
            events=Event.findAllByProduct(Product.findById(params.product.id),params)
        }else{

            // if(params.q && params.q != ''){
            //     events= Event.search(params.q+"*").results
            //     count=events.size()
            // }else {
            //     events= Event.list(params)
            //     count=Event.count()
            // }

            events= Event.list(params)
            count=Event.count()
        }
        

        [
            events: events,
            count:count
        ]
    }

    def show() { 

        def event=Event.findById(params.id)

        [
            event: event
        ]
    }


}
