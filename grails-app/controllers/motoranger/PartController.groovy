package motoranger

import grails.plugin.springsecurity.annotation.Secured
import org.jsoup.Jsoup
import org.jsoup.nodes.*
import org.jsoup.select.*

class PartController {
	static layout="bootstrap"
    def s3Service
    def imageModiService
    def messageSource
    def tagQueryService
    def userService

    def index(){
        if(!params?.group)params.group = motoranger.TagGroup.RECENT


        if(params.group == motoranger.TagGroup.RECENT && !session?.recentPartIds ){
            session.recentPartIds = tagQueryService.getRecentPartIds()
        }

        params.recentPartIds = session.recentPartIds

        def tags = tagQueryService.getUniTag(params)
        def parts = tagQueryService.getCurrentUserPartsWithTag(params)

        [
            tags: tags, 
            parts: parts
        ]
        

    }

	@Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def create(){

    	def part = new Part(params)
        boolean isCusRole = false
        def currentUser = userService.currentUser()

        if(currentUser?.store){
            part.store=currentUser.store
            part.user=null
        }else if(!part.user){
            part.user = currentUser
        }

        if(!params.name)
    	   part.name = "part-${new Date().format('yyyy')}-${new Date().format('MMddHHmmss')}"

        [ part: part ]

    }
    @Secured(['ROLE_OPERATOR', 'ROLE_MANERGER'])
    def query(){

        def part = Part.findByName(params.name)
        if(part){
            redirect(action:'show', id:part.id)
        }else {
            redirect(action:'create', params:params)
        }


    }
    
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def addEvent(){

        def part = Part.findByName(params.name)
        if(part){
            redirect(controller:'event', action:'create', params:[partId:part.id])
        }else {
            redirect(action:'create', params:params)
        }


    }

    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def save(){

        if(!params?.price)params.price=0
        if(!params?.cost)params.cost=0

        def part = Part.findByName(params.name);
        if(!part) 
            part = new Part(params);
        else part.properties = params

        //set current user as creator
        part.creator = userService.currentUser().username

        if (!part.validate()) {
            render(view: "create", model: [part: part])
            return
        }



        
        part.save(flush: true)

        if(params.tags instanceof String)
            part.tags=[params.tags];
        else if(params?.tags)
            part.tags = params.tags
        else part.tags=["未分類"]

        if(params?.event?.id){
            def newParams=[:]
            newParams.qty=1
            newParams.price = part.price
            newParams.cost = part.cost
            newParams["part.id"] = part.id
            newParams["head.id"] = params.event.id
            redirect(controller:"eventDetail", action: "save", params: newParams)
            return 
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'part.label', default: 'part'), part])
        redirect(action: "show", id:part.id)
    }


    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def list(){
        [
            parts: Part.list()
        ]
    } 
    def show(){ 
        def part = Part.findById(params.id)

        [
            part: part
        ]
    }

    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def edit(){ 
        def part = Part.findById(params.id)

        def eventDetails= EventDetail.findAllByPart(part)

        [ 
            part: part,
            historyCost: eventDetails*.cost.unique().sort(),
            historyPrice: eventDetails*.price.unique().sort()
        ]
    }
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def update(){

        def part = Part.findByIdOrName(params.id,params.name)

        if(!params?.price)params.price=0
        if(!params?.cost)params.cost=0


        if(params.tags instanceof String)
            part.tags=[params.tags];
        else part.tags = params.tags



        if(!params.mainImage)params.mainImage="";

        
        if (!part) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list")
            return
        }

        if (params.version != null) {  

            if (part.version > (params.version as Long)) {
                part.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'part.label', default: 'Part')] as Object[],
                          "Another user has updated this User while you were editing")

                flash.message = message(code: "Another user has updated this User while you were editing")
                render(view: "edit", model: [part: part])
                return
            }
        }

        part.properties = params



        if (!part.save()) {
            render(view: "edit", model: [part: part])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'part.label', default: 'Part'), part])
        redirect(action: "show", id: part.id)
    }
    @Secured(['ROLE_CUSTOMER', 'ROLE_OPERATOR', 'ROLE_MANERGER'])
    def delete(){ 
        def part = Part.findById(params.id)
        
        
        try{
            part.delete(flush: true,failOnError:true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'part.label', default: 'part'), part])
            redirect(action: "index")
        }catch(Exception e){
            flash.message = "維修記錄使用到該維修項目：${part.title}，無法刪除。請修正標籤，例如：不使用"
            redirect(action: "show" ,id:part.id)
        }



    }

}
