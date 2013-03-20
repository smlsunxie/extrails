package extrails


import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString



@ToString
public enum EventStatus {
    START,
    STOP,
    LOG,
    END;
}

@ToString(includeNames = true, includeFields = true, excludes = 'dateCreated,lastUpdated,metaClass')
@EqualsAndHashCode
class ServiceEventDetail {

		static belongsTo = [serviceEvent:ServiceEvent]

		String mainImage=""
		Part part
		EventStatus status


		Date dateCreated
		Date lastUpdated

		static constraints={
			part nullable:true
		}
}