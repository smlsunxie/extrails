package extrails


import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'dateCreated,lastUpdated,metaClass')
@EqualsAndHashCode
class ServiceEvent {

	String name
	String description
	Product product
	Part part

	User user
 
	Date dateCreated
	Date lastUpdated


	static constraints = {
    name blank: false, unique: true
    description nullable: true, empty: true
    part nullable: true
  }
}