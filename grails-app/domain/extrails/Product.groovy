package extrails

import org.grails.taggable.Taggable

public enum ProductOwner {
    STORE,
    CUSTOMER;
}

class Product implements Taggable {


		String name
		String title
		// User owner
		ProductOwner owner
		Date years
		Long cost=0
		Long price=0
		Long mileage=0
		String mainImage
		String creator
		String description

    Date dateCreated    //建立日期
    Date lastUpdated    //修改日期

    static constraints = {

    	name blank: false, unique: true
    	title blank: false
      mainImage nullable: true, empty: true   
      description nullable: true, empty: true 	
    }
}
