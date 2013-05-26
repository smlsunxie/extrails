package extrails


import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@EqualsAndHashCode
class Event {
	// static searchable = true
	String name
	String description
	Product product
	Long mileage=0

	static hasMany = [details:EventDetail]


	ProductStatus status=extrails.ProductStatus.UNFIN

	User user
 	
 	Date date
 	
 	String creator

 	Long receivedMoney=0
 	Long totalPrice=0

	Date dateCreated
	Date lastUpdated

	

	static constraints = {
	    creator nullable: true
	    name blank: false, unique: true
	    description nullable: true, empty: true
  }

  static mapping = {
       sort date: "desc"
  }
}