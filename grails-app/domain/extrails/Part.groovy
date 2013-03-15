package extrails
import org.grails.taggable.Taggable


class Part implements Taggable {
		String name
		String title
		Double cost
		Double price
		String description
		int stockCount
		String mainImg 

		User creator		//建立者
    Date dateCreated    //建立日期
    Date lastUpdated    //修改日期

    static constraints = {
    	name blank: false, unique: true
    	title blank: false
      description nullable: true, empty: true
      creator nullable: true
    }
}
