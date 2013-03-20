package extrails


import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'dateCreated,lastUpdated,metaClass')
@EqualsAndHashCode
class ServiceEvent {



	static belongsTo = [user:User, product:Product]
	static hasMany = [serviceEventDetails:ServiceEventDetail]
	Date dateCreated
	Date lastUpdated
}