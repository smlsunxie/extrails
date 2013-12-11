package motoranger




class Store {
    static searchable = true
	String name
	String title
	String address
	String telphone
    String mobile
    
    String fax
    String description
    String email


	static hasMany=[users:User]

    static constraints = {
    	name unique:true
    	mobile nullable:true 
    	telphone nullable:true 
    	address nullable:true

        fax nullable:true
        description nullable:true
        email nullable:true

    }
    public String toString() {

	    return title;
  	}
}
