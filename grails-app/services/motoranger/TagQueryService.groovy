package motoranger

import org.grails.taggable.*

class TagQueryService {

    def springSecurityService
    def userService


    def getlikeTag = { query ->
        return Tag.findAllByNameIlike("%${query}%").name
    }

    def getUniTag ={ domainName ->

        def currentUser = springSecurityService.currentUser

        def allTagIds

        def partIds

		String domainTagsHQL= """
           SELECT distinct tagLink.tag.id
           FROM TagLink tagLink 
           where tagLink.type=:domainName
           and tagLink.tagRef in (:partIds)
        """

        if(userService.currentUserIsCustomer()){
            partIds = Part.findAllByUser(currentUser)*.id
        }else if(userService.currentUserIsOperator()){
            partIds = Part.findAllByStore(currentUser.store)*.id
        }


        allTagIds = TagLink.executeQuery(domainTagsHQL,
                [domainName:domainName, partIds: partIds])

    	def allTags=Tag.withCriteria{
            if(allTagIds)
    		  "in" ("id", allTagIds)
            else eq("id",-1L)
    	}

		return allTags?.name
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
}