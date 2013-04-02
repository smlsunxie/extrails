package extrails


import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString



@ToString(includeNames = true, includeFields = true, excludes = 'dateCreated,lastUpdated,metaClass')
@EqualsAndHashCode
class EventDetail {
		static searchable = true
		Event head
		String mainImage=""
		String name
		Part part
		Integer qty=0
		String description=""
		String creator
		Date dateCreated
		Date lastUpdated

		static constraints={
			part nullable:true
			
		}
}