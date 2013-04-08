package extrails

import org.jsoup.Jsoup
import org.jsoup.nodes.*
import org.jsoup.select.*
import grails.plugins.springsecurity.Secured

class EventController {

	static layout="bootstrap"
    def springSecurityService
    def messageSource
    def eventTransationService

    @Secured(['ROLE_OPERATOR'])
    def create= { 

        if(params?.product){
            params.product=Product.findById(params.product)

            log.info params.product.mileage
            params.mileage=params.product.mileage

            def unfinEvent=Event.findByProductAndStatus(params.product,extrails.ProductStatus.UNFIN)

            if(unfinEvent){
                redirect(controller:"part", action:"portfolio", params:[event:unfinEvent.id])
            }
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
        
       
        log.info params.user

        if(params?.product && params?.product!='null')
            params.product=Product.findById(params.product)

        if(params?.user && params?.user!='null')
            params.user=User.findById(params.user)


        def event = new Event(params);
        event.creator=springSecurityService.currentUser.username
        event.date=new Date()




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
        event.merge(flush: true)
        event=Event.findByName(params.name)

        
        flash.message = message(code: 'default.created.message', 
            args: [message(code: 'event.label', default: 'event'), event.id])


        redirect(action: "portfolio", controller:"part", params:[event:event.id])


    }

    def delete={ Long id ->
        def event=Event.findById(id)

        if(event.status==extrails.ProductStatus.UNFIN){
            event.product.status=extrails.ProductStatus.END
            event.save(flush:true)
        }

        def details=EventDetail.findByHead(event)

        if(details)
            details.delete(flush:true)

        event.delete(flush:true)

        flash.message = message(code: 'default.delete.message', 
            args: [message(code: 'event.label', default: 'event'), event.id])

        redirect(action: "list", controller:"product")


    }

    def list={

        def events
        def count=1

        params.sort= 'dateCreated'
        params.order= 'asc'
        params.max=5

        if(params?.product)
            events=Event.findAllByProduct(Product.findById(params.product))
        else{

            if(params.q && params.q != ''){
                events= Event.search(params.q+"*").results
                count=events.size()
            }else {
                events= Event.list(params)
                count=Event.count()
            }
        }
        

        log.info count
        [
            events: events,
            count:count
        ]
    }

    def changeStatus={ Long id ->

        log.info params.status
        def event=Event.findById(id)
        event.status=params.status
        event.product.status=params.status
        event.save(flush: true)

        redirect(action:"list", controller:params.controllerName, params:[event:id])

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

                def productName=eventCols[3].getElementsByTag("a")[0].html()
                def mileage=eventCols[5].html().decodeHTML().replace("  KM","")


                //---------
                def userMap=[:]

                userMap.username=productName
                def user=User.findByUsername(userMap.username)
                if(!user){
                    userMap.title=userAndProductCols[0].html().decodeHTML()
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
