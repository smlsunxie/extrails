package motoranger

import grails.converters.JSON

import org.jsoup.Jsoup
import org.jsoup.nodes.*
import org.jsoup.select.*
import grails.plugin.springsecurity.annotation.Secured

class EventController {

	static layout="bootstrap"
    def userService
    def tagQueryService

    def show() { 

        def event=Event.findById(params.id)

        [
            event: event
        ]
    }

    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def create() { 

        def unfinEvent

        if(params?.product?.id){
            params.product=Product.findById(params.product.id)

            params.mileage=params.product.mileage
            
            unfinEvent = Event.findByProductAndStatus(params.product,motoranger.ProductStatus.UNFIN)
        }

        if(unfinEvent){
            redirect(controller:"event", action:"pickPartAddDetail", id:unfinEvent.id)
        } 

        def event = new Event(params);

        def currentUser = userService.currentUser()
        
        event.user=currentUser
        if(currentUser?.store){
            event.store=currentUser.store
        }

        event.name = "event-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

    	[
            event:event
    	]

    }


    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def save() {
        

        def event = Event.findByName(params.name);

        if(!event) 
            event = new Event(params);
        else event.properties = params
        
        event.creator=userService.currentUser().username




        if (!event.validate()) {
            if(event.hasErrors())
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


        redirect(controller:"event", action:"pickPartAddDetail", id:event.id)


    }
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def pickPartAddDetail(){

        def event
        
        if(params?.id){
            event=Event.findById(params.id,[sort: 'dateCreated', order: 'desc'])
        }

        if(!params?.group)params.group = motoranger.TagGroup.CUSTOMIZED
        
        if(params?.group.toString() == motoranger.TagGroup.RECENT.toString() && !params?.tag){

            session.recentPartIds = tagQueryService.getRecentPartIds()
        } 

        params.recentPartIds = session.recentPartIds

        def tags = tagQueryService.getUniTag(params)
        def parts = tagQueryService.getCurrentUserPartsWithTag(params)

        [
            event: event,
            tags: tags, 
            parts: parts
        ]

    }


    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
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
        event.delete(flush:true)


        flash.message = message(code: 'default.deleted.message'
            , args: [message(code: 'event.label', default: 'event'), event])

        def currentUser = userService.currentUser()

        if(userService.isOperator()|| userService.isManerger()){
            def store = currentUser.store
            redirect(action: "show", controller: "store", id: store.id)
        }else if(userService.isCustomer()){
            redirect(action: "show", controller: "user", id: currentUser.id)
        }



    }
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def edit() { 
        def event = Event.findByIdOrName(params.id, params.name)

        [ 
            event: event
        ]
    }
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def update() {

        def event = Event.findByIdOrName(params.id, params.name)
        println "update = "+ event

        
        if (!event) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), event])
            redirect(action: "index", controller:"home")
            return
        }


        event.properties = params

        if(params.mileage && event.product.mileage.toLong() < params.mileage.toLong()){
            event.product.mileage=params.mileage.toLong()
        }

        if (!event.save(flush: true)) {
            render(view: "edit", model: [event: event])
            return
        }


        flash.message = message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'event'), event])
        

        if(params?.status == 'END'){
            
            def currentUser = userService.currentUser()

            if(userService.isOperator() || userService.isManerger()){
                def store = currentUser.store
                redirect(action: "show", controller: "store", id: store.id)
                return
            }else if(userService.isCustomer()){
                redirect(action: "show", controller: "user", id: currentUser.id)
                return
            }
        }
        else if(request.getHeader('referer').indexOf("event/pickPartAddDetail") != -1
            || request.getHeader('referer').indexOf("/store/") != -1){
             redirect(uri: request.getHeader('referer') )
             return
        }else {
            redirect(action: "show", id:event.id)
            return
        }
    }

    @Secured(['ROLE_OPERATOR', 'ROLE_MANERGER'])
    def updateReceivedMoney() { 

        def event=Event.findById(params.id)
        try{
            if(!params.value)params.value=0

            def receivedMoney=params.value.toLong()

            // if(event?.details)totalPrice=event?.details.price.sum()



            if(receivedMoney<=event.totalPrice){

                event.receivedMoney=receivedMoney

                if(receivedMoney + event.discountMoney > event.totalPrice)
                    event.discountMoney=event.totalPrice - receivedMoney

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
    @Secured(['ROLE_OPERATOR', 'ROLE_MANERGER'])
    def updateDiscountMoney() { 

        def event=Event.findById(params.id)
        try{
            if(!params.value)params.value=0

            def unreceiveMoney=params.value.toLong()

            // if(event?.details)totalPrice=event?.details.price.sum()
            println unreceiveMoney
            println event.receivedMoney
            println event.totalPrice

            println event.totalPrice  -  event.discountMoney -event.receivedMoney

            if(unreceiveMoney<=event.totalPrice - event.receivedMoney){

                event.discountMoney=event.totalPrice - event.receivedMoney -unreceiveMoney

                event.save(flush:true,failOnError:true)

                params.success=true

            }else {
                params.success=false
                params.msg="未收金額超過總價"
            }
            
        }catch(Exception e){
            params.success=false
            params.msg="請輸入數值資料"
        }

        params.event=event

        render params as JSON


    }

    @Secured(['ROLE_OPERATOR', 'ROLE_MANERGER'])
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

        def currentUser=userService.currentUser()
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

    def endListOfStore(){

        params.max=12
        params.order="desc"
        params.sort="lastUpdated"


        def store = Store.findById(params.store.id)

        def query = Event.where {
            store == store
            status == motoranger.ProductStatus.END
        }

        def results = query.list(params)


        render view:'list', model: [events:results, title: "最近維修完成"]
    }

    def unfinListOfStore(){

        params.order="desc"
        params.sort="lastUpdated"


        def store = Store.findById(params.store.id)

        def query = Event.where {
            store == store
            status == motoranger.ProductStatus.UNFIN
        }

        def results = query.list(params)


        render view:'list', model: [events:results, title: "所有維修中"]
    }

}
