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

    }
}
