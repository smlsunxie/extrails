package motoranger

import org.grails.taggable.*

class TagQueryService {

    def springSecurityService
    def userService


    def getlikeTag = { query ->
        return Tag.findAllByNameIlike("%${query}%").name
    }

    def getUniTag ={ params ->

        def currentUser = springSecurityService.currentUser

        def allTagIds

        def partIds = []


        if(params.group.toString() == motoranger.TagGroup.RECENT.toString()){

                partIds = params.recentPartIds

        }else if(params.group.toString() == motoranger.TagGroup.CUSTOMIZED.toString()){

            if(userService.currentUserIsOperator()){

                partIds = Part.findAllByStore(currentUser.store)*.id

            }else if(userService.currentUserIsCustomer()){
                
                partIds = Part.findAllByUser(currentUser)*.id

            }

        }else if(params.group.toString() == motoranger.TagGroup.UNIVERSAL.toString()){
            def store = Store.findByName('store-default-motocycle')
            partIds = Part.findAllByStore(store)*.id
        }


        String domainTagsHQL= """
           SELECT distinct tagLink.tag.id
           FROM TagLink tagLink 
           where tagLink.type=:domainName
           and tagLink.tagRef in (:partIds)
        """
        def allTags =[]
        if(partIds){
            allTagIds = TagLink.executeQuery(domainTagsHQL,
                    [domainName:'part', partIds: partIds])

        	allTags=Tag.withCriteria{
                if(allTagIds)
        		  "in" ("id", allTagIds)
                else eq("id",-1L)
        	}
        }

		return allTags?.name
    }
    def getCurrentUserPartsWithTag = { params ->

        def parts
        

        if(params.tag){

            def currentUser = springSecurityService.currentUser
            parts = Part.findAllByTagWithCriteria(params.tag) {

                if(params.group.toString() == motoranger.TagGroup.CUSTOMIZED.toString()){
                    if(userService.currentUserIsOperator()){
                        eq('store', currentUser.store)
                    }
                    else{
                        eq('user', currentUser)
                    }

                }else if(params.group.toString() == motoranger.TagGroup.RECENT.toString()){

                    'in'('id', params.recentPartIds)

                }else if(params.group.toString() == motoranger.TagGroup.UNIVERSAL.toString()){
                    def store = Store.findByName('store-default-motocycle')
                    eq('store', store)
                }



            }

        }     
        
        return parts
    }

    def getUniTagByList ={ domainList ->

        def tags=[]
        if(domainList){
            

            domainList.tags.each{ //i ->
                tags.addAll(it) 
            }
            
        }

        return tags.unique()

        
    }

    def getRecentPartIds(){

        def partIds =[]
        def params= [:]
        params.max = 400
        params.sort = "date"
        params.order = "desc"

        def currentUser = springSecurityService.currentUser
        def recentEvents 

        if(userService.currentUserIsOperator()){
            recentEvents =Event.findAllByStore(currentUser.store, params)
        }else {
            recentEvents =Event.findAllByUser(currentUser, params)
        }

        recentEvents.each(){ recentEvent ->
            recentEvent.details.each(){ detail ->
                partIds << detail.part.id
            }
            
        }

        return partIds
    }
}