package motoranger

import org.grails.taggable.*

class TagQueryService {

    def getlikeTag = { query ->
        return Tag.findAllByNameIlike("%${query}%").name
    }

    def getUniTag ={ domainName ->

		String domainTagsHQL = """
		   SELECT distinct tagLink.tag.id
		   FROM TagLink tagLink
		   where type=:domainName
		"""
		def allTagIds = TagLink.executeQuery(domainTagsHQL, [domainName:domainName ])

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