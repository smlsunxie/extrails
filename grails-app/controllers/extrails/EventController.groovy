package extrails

import grails.converters.JSON

import org.jsoup.Jsoup
import org.jsoup.nodes.*
import org.jsoup.select.*
import grails.plugins.springsecurity.Secured

class EventController {

	static layout="bootstrap"
    def springSecurityService
    def messageSource

    @Secured(['ROLE_OPERATOR'])
    def create= { 

        def unfinEvent

        if(params?.event?.id)
             unfinEvent=Event.findById(params?.event.id)
        
        else if(params?.product?.id){
            params.product=Product.findById(params.product.id)

            params.mileage=params.product.mileage
            
            unfinEvent = Event.findByProductAndStatus(params.product,extrails.ProductStatus.UNFIN)
        }

        if(unfinEvent){
            redirect(controller:"part", action:"portfolio", params:['event.id':unfinEvent.id])
        } 

        def event = new Event(params);
        event.user=springSecurityService.currentUser
        event.name = "event-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

    	[
            event:event
    	]

    }
    @Secured(['ROLE_OPERATOR'])
    def save={
        
        // if(params?.product && params?.product!='null')
        //     params.product=Product.findById(params.product)

        // if(params?.user && params?.user!='null')
        //     params.user=User.findById(params.user)
        def event = Event.findByName(params.name);

        if(!event) event = new Event(params);
        
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

        event.product.status=extrails.ProductStatus.UNFIN
        event.save(flush: true)
        // event=Event.findByName(params.name)

        
        flash.message = message(code: 'default.created.message', 
            args: [message(code: 'event.label', default: 'event'), event.id])


        redirect(action: "portfolio", controller:"part", params:["event.id":event.id])


    }

    @Secured(['ROLE_OPERATOR'])
    def delete={ Long id ->

        def event=Event.findById(id)

        if(event.status==extrails.ProductStatus.UNFIN){
            event.product.status=extrails.ProductStatus.END
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
    def edit={ Long id ->
        def event = Event.findByIdOrName(id, params.name)

        [ 
            event: event
        ]
    }
    @Secured(['ROLE_OPERATOR'])
    def update={Long id ->

        def event = Event.findByIdOrName(id, params.name)

        // if(params?.product && params?.product!='null')
        //     params.product=Product.findById(params.product)

        // if(params?.user && params?.user!='null')
        //     params.user=User.findById(params.user)

        
        if (!event) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), id])
            redirect(action: "index", controller:"home")
            return
        }


        event.properties = params

        if(event.product.mileage.toLong() < params.mileage.toLong()){
            event.product.mileage=params.mileage.toLong()
        }

        if (!event.save(failOnError: true, flush: true)) {
            render(view: "edit", model: [event: event])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'event'), event.id])
        redirect(action: "show", id:event.id)
    }

    @Secured(['ROLE_OPERATOR'])
    def updateReceivedMoney={ Long id ->

        def event=Event.findById(id)
        try{
            if(!params.value)params.value=0

            def receivedMoney=params.value.toLong()
            def totalPrice=0


            if(event?.details)totalPrice=event?.details.price.sum()



            if(receivedMoney<=totalPrice){

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
    def updateDate={ Long id ->


        def event=Event.findById(id)
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
    def list={

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

    def show={ Long id ->

        def event=Event.findById(id)

        [
            event: event
        ]
    }


    @Secured(['ROLE_OPERATOR'])
    def changeStatus={ Long id ->


        def event=Event.findById(id)
        event.status=params.status
        event.product.status=params.status
        event.save(flush: true)


        // if(params.controllerName=="home")
        //     redirect(action:"index", controller:params.controllerName, params:[event:id])
        // else redirect(action:"list", controller:params.controllerName, params:[event:id])

        redirect(action:"index", controller:"home", params:[event:id])

    }

    def initTotalPrice={
        def events=Event.list()
        events.eachWithIndex(){event,i ->
            log.info "${i}/${events.size()} start"
            if(event?.details){
                event.totalPrice= event.details.price.sum()
                event.receivedMoney=event.totalPrice
                event.save(flush: true,failOnError:true)
                log.info event.totalPrice
            }
        }

    }

    def htmImport={ 


        for ( i in 1..8 ){

            File input = grailsAttributes.getApplicationContext().getResource("/data/event/${i}.htm").getFile()

            Document doc = Jsoup.parse(input, "UTF-8", "http://motoranger.net/");


            // event
            Elements elements = doc.select("td[width=65%] > table[cellspacing=3]");
            Elements elements2 = doc.select("td[width=35%] > table[cellspacing=3]");



            elements.eachWithIndex(){ element,j ->

                
                

                Element userAndProductHtml = element.getElementsByTag("tr").get(3) 
                Elements userAndProductCols=userAndProductHtml.getElementsByTag("td")

                Element eventHtml = element.getElementsByTag("tr").get(1) 
                Elements eventCols=eventHtml.getElementsByTag("td")

                def productName=eventCols[3].getElementsByTag("a")[0].html().replace("-","")
                def mileage=eventCols[5].html().decodeHTML().replace("  KM","")


                //---------
                def userMap=[:]

                userMap.username=productName
                def user=User.findByUsername(userMap.username)
                if(!user){
                    userMap.title=userAndProductCols[0].html().decodeHTML()
                    if(userMap.title=='')
                        userMap.title=userMap.username
                    
                    userMap.password=userMap.username
                    user=new User(userMap)
                    user.save(flush:true,failOnError:true)
                }else {
                    user.title=userAndProductCols[0].html().decodeHTML()
                    user.save(flush:true,failOnError:true)
                }

                //---------
                def admin=User.findByUsername("admin")
                def recordUser=User.findByTitle(userAndProductCols[1].html().decodeHTML())


                if(!recordUser)recordUser=admin
                //---------
                def productMap=[:]
                productMap.name=productName
                productMap.mileage=mileage
                productMap.user=user

                

                def product=Product.findByName(productMap.name)
                if(!product){
                    def brand=userAndProductCols[2].html().decodeHTML()

                    if(brand=="山葉")brand=extrails.ProductBrand.YAMAHA
                    else if(brand=="光陽")brand=extrails.ProductBrand.KYMCO
                    else if(brand=="三陽")brand=extrails.ProductBrand.SYM
                    else if(brand=="川崎")brand=extrails.ProductBrand.KAWASAKI
                    else if(brand=="比雅久")brand=extrails.ProductBrand.PGO
                    else if(brand=="哈特佛")brand=extrails.ProductBrand.HORTFORD
                    else if(brand=="偉士牌")brand=extrails.ProductBrand.VESPA
                    else if(brand=="台鈴")brand=extrails.ProductBrand.SUZUKI
                    else brand=extrails.ProductBrand.OTHERS

                    productMap.brand=brand
                    productMap.title=productMap.name
                    productMap.creator="admin"
                    
                    product=new Product(productMap)
                    product.save(flush:true,failOnError:true)

                }else if(product.mileage < productMap.mileage.toLong() ){
                    product.mileage= productMap.mileage.toLong()
                    product.save(flush:true,failOnError:true)
                
                }


                //---------
                def eventMap=[:]
                def dateString=eventCols[4].html()
                eventMap.product=product
                eventMap.creator="admin"
                eventMap.name="event-${productName}-${dateString}-${i}-${j}"


                eventMap.user=recordUser
                eventMap.mileage=mileage
                eventMap.status=extrails.ProductStatus.END
                eventMap.date=new Date().parse("yyyy/M/d",dateString)

                eventMap.description=eventCols[6].html().decodeHTML()

                def event=new Event(eventMap).save(flush:true,failOnError:true)


                Elements eventDetailsHtml=elements2.get(j).getElementsByTag("tr")

                eventDetailsHtml.eachWithIndex(){ detailHtml,k ->
                    if(k>0){
                        Elements detailCols=detailHtml.getElementsByTag("td")
                        def partMap=[:]
                        partMap.title=detailCols[0].html().decodeHTML().replace("  ","")

                        def part=Part.findByTitle(partMap.title)

                        if(!part){
                            partMap.name="part-${i}-${j}-${k}"
                            partMap.price=detailCols[1].html().decodeHTML().replace(",","").toLong()
                            partMap.cost=partMap.price
                            part=new Part(partMap)
                            part.save(flush:true,failOnError:true)
                            part.addTag("未分類")
                        }


                        def eventDetailMap=[:]
                        eventDetailMap.head=event
                        eventDetailMap.name="eventDetail-${i}-${j}-${k}"
                        eventDetailMap.qty=detailCols[2].html().decodeHTML().toInteger()
                        eventDetailMap.creator="admin"
                        eventDetailMap.part=part

                        new EventDetail(eventDetailMap).save(flush:true,failOnError:true)


                    }
                }
                log.info "${i}:${elements.size()}/${j} end"
                   
            }
        }

    }
}
