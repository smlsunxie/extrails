package extrails

import org.grails.taggable.Taggable
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString



@ToString
public enum ProductOwner {
    STORE,
    CUSTOMER;
}

@EqualsAndHashCode
@ToString(includeNames = true, includeFields = true, excludes = 'dateCreated,lastUpdated,metaClass')
class Product implements Taggable {


		String name
		String title
		// User owner
		ProductOwner owner=extrails.ProductOwner.STORE
		Date years
		Long cost=0
		Long price=0
		Long mileage=0
		String mainImage=""
		User creator
		String description

    Date dateCreated    //建立日期
    Date lastUpdated    //修改日期

    static hasMany = [serviceEvents:ServiceEvent]

    static constraints = {
      creator nullable: true
    	name blank: false, unique: true
    	title blank: false
      mainImage nullable: true, empty: true   
      description nullable: true, empty: true 	
    }
  //   String toString(){
  //     "${name}"
		// }


}
