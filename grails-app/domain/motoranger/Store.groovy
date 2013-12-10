package motoranger




class Store {

	String name
	String title
	String address
	String telphone
	String mobile
    User owner


	static hasMany=[users:User]

    static constraints = {
    	name unique:true
    	mobile nullable:true 
    	telphone nullable:true 
    	address nullable:true
        owner nullable:true

    }
    public String toString() {

	    return title;
  	}
}
