package motoranger

class User {
	static searchable = true

	transient springSecurityService

	String username
	String password

	String title=""
	String telphone=""

	String mobile=""
	String address=""
	String email=""
	String description=""

	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	Store store

	static hasMany=[products:Product]
	
	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
		store nullable: true
		products nullable: true
		// title nullable: true
		// telphone nullable: true
		// mobile nullable: true
		// address nullable: true
		// email nullable: true
		// description nullable: true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}

	public String toString(){
		return title
	}


}
