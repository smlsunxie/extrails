package motoranger

import org.grails.taggable.Taggable

public enum ProductStatus {
    UNFIN,
    END;
}

class Product {
    static searchable =  {
        user component: true
    }

	String name
	String title
	Date years
	Long cost=0
	Long price=0
	Long mileage=0
	String mainImage=""
    ProductStatus status=motoranger.ProductStatus.END
    Brand brand
    static hasMany = [events:Event]

    String description
    User user
    Integer cc=0


    String creator
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
        brand nullable: true

    }
  static mapping = {
       events sort: 'date', order: 'desc'
  }


}
