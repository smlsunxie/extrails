package extrails

import org.grails.taggable.Taggable
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString



@ToString
public enum ProductOwner {
    STORE,
    CUSTOMER;
}

public enum ProductBrand {
    HORTFORD,
    KAWASAKI,
    KYMCO,
    OTHERS,
    PGO,
    SUZUKI,
    SYM,
    YAMAHA,
    VESPA;
}


@EqualsAndHashCode
class Product implements Taggable {
    static searchable = true

		String name
		String title
		ProductOwner owner=extrails.ProductOwner.STORE
		Date years
		Long cost=0
		Long price=0
		Long mileage=0
		String mainImage=""

    ProductBrand brand=extrails.ProductBrand.OTHERS
    String engineId=""
		String description

    User user
    String color=""
    Integer cc=0

    User creator
    Date dateCreated    //建立日期
    Date lastUpdated    //修改日期

    static constraints = {
      creator nullable: true
    	name blank: false, unique: true
    	title blank: false
      mainImage nullable: true, empty: true   
      description nullable: true, empty: true
      user nullable: true
      years nullable: true

    }
  //   String toString(){
  //     "${name}"
		// }


}
