package extrails


import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString


@ToString
public enum EventStatus {
    UNFIN,
    END;
}

	// <option value="A">定期保養</option>
	// <option value="B">一般維修</option>
	// <option value="D">引擎大修</option>
	// <option value="E">車禍維修</option>
	// <option value="F">故障診斷</option>
	// <option value="G">eFi檢測</option>
	// <option value="H">排氣定檢</option>
	// <option value="I">強制險續保</option>
	// <option value="J">更換行照</option>


@EqualsAndHashCode
class Event {
	static searchable = true
	String name
	String description
	Product product
	Long mileage

	static hasMany = [details:EventDetail]


	EventStatus status=extrails.EventStatus.UNFIN

	User user
 	
 	Date date
 	
 	String creator
	Date dateCreated
	Date lastUpdated


	static constraints = {
    name blank: false, unique: true
    description nullable: true, empty: true
    user nullable: true, empty: true

  }

  public String toString(){
  	"${product.name}"
  }

}