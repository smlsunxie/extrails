package extrails
import org.grails.taggable.Taggable

import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
class Part implements Taggable {
		String name
		String title
		Long cost=0
		Long price=0
    Long wage=0

		String description
		Integer stockCount=0
		String mainImage=''

		User creator		//建立者
    Date dateCreated    //建立日期
    Date lastUpdated    //修改日期

    static constraints = {
    	name blank: false, unique: true
    	title blank: false
      description nullable: true, empty: true
      creator nullable: true
      mainImage nullable: true, empty: true
    }

    String toString(){
      "${name}-${title}"
    }
}
