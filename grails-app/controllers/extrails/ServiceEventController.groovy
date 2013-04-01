package extrails

import org.jsoup.Jsoup
import org.jsoup.nodes.*
import org.jsoup.select.*
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

        def serviceEvents

        if(params?.product)
            serviceEvents=ServiceEvent.findAllByProduct(Product.findById(params.product))
        else serviceEvents=ServiceEvent.list()

        [
            serviceEvents: serviceEvents
        ]
    }

    def changeStatus={ Long id ->

        log.info params.status
        def serviceEvent=ServiceEvent.findById(id)
        serviceEvent.status=params.status
        serviceEvent.save(flush: true)

        redirect(action:"list", controller:params.controllerName, params:[serviceEvent:id])

    }
    def htmImport={


        for ( i in 1..8 ){

            File input = grailsAttributes.getApplicationContext().getResource("/data/serviceEvent/${i}.htm").getFile()

            Document doc = Jsoup.parse(input, "UTF-8", "http://motoranger.net/");


            // serviceEvent
            Elements elements = doc.select("td[width=65%] > table[cellspacing=3]");
            Elements elements2 = doc.select("td[width=35%] > table[cellspacing=3]");

            elements.eachWithIndex(){ element,j ->

                

                Element userAndProductHtml = element.getElementsByTag("tr").get(3) 
                Elements userAndProductCols=userAndProductHtml.getElementsByTag("td")

                Element serviceEventHtml = element.getElementsByTag("tr").get(1) 
                Elements serviceEventCols=serviceEventHtml.getElementsByTag("td")

                def productName=serviceEventCols[3].getElementsByTag("a")[0].html()
                def mileage=serviceEventCols[5].html().decodeHTML().replace("  KM","")


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
                    productMap.creator=User.findByUsername("admin")
                    
                    product=new Product(productMap)
                    product.save(flush:true,failOnError:true)

                }else if(product.mileage < productMap.mileage.toLong() ){
                    product.mileage= productMap.mileage.toLong()
                    product.save(flush:true,failOnError:true)
                
                }


                //---------
                def serviceEventMap=[:]
                def serviceDateString=serviceEventCols[4].html()
                serviceEventMap.product=product
                serviceEventMap.creator=admin
                serviceEventMap.name="serviceEvent-${productName}-${serviceDateString}-${i}-${j}"


                serviceEventMap.user=recordUser
                serviceEventMap.mileage=mileage
                serviceEventMap.status=extrails.EventStatus.END
                serviceEventMap.serviceDate=new Date().parse("yyyy/M/d",serviceDateString)

                serviceEventMap.description=serviceEventCols[6].html().decodeHTML()

                def serviceEvent=new ServiceEvent(serviceEventMap).save(flush:true,failOnError:true)


                Elements serviceEventDetailsHtml=elements2.get(j).getElementsByTag("tr")

                serviceEventDetailsHtml.eachWithIndex(){ detailHtml,k ->
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
                            part.addTags("未分類")
                        }


                        def serviceEventDetailMap=[:]
                        serviceEventDetailMap.head=serviceEvent
                        serviceEventDetailMap.name="serviceEventDetail-${i}-${j}-${k}"
                        serviceEventDetailMap.qty=detailCols[2].html().decodeHTML().toInteger()
                        serviceEventDetailMap.creator=admin
                        serviceEventDetailMap.part=part

                        new ServiceEventDetail(serviceEventDetailMap).save(flush:true,failOnError:true)


                    }
                }
                   
            }
        }

    }
}
