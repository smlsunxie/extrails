package extrails


import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString


@ToString
public enum EventStatus {
    UNFIN,
    END;
}


@EqualsAndHashCode
class ServiceEvent {

	String name
	String description
	Product product

	static hasMany = [details:ServiceEventDetail]


	EventStatus status=extrails.EventStatus.UNFIN
 
 	User creator
	Date dateCreated
	Date lastUpdated


	static constraints = {
    name blank: false, unique: true
    description nullable: true, empty: true

  }

  public String toString(){
  	"${product.name}"
  }

}