package extrails


import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString



@ToString(includeNames = true, includeFields = true, excludes = 'dateCreated,lastUpdated,metaClass')
@EqualsAndHashCode
class ServiceEventDetail {

		static belongsTo = [head:ServiceEvent]

		String mainImage=""
		String name
		
		Part part

		Integer qty=0

		User creator
		String description=""


		Date dateCreated
		Date lastUpdated

		static constraints={
			part nullable:true
			
		}
}