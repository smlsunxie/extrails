package extrails




class Store {

	String name
	String title
	String address
	String telphone
	String mobile


	static hasMany=[users:User]

    static constraints = {
    	name unique:true
    	mobile nullable:true 
    	telphone nullable:true 
    	address nullable:true

    }
    public String toString() {

	    return title;
  	}
}
