package extrails


import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString


public enum UserType{
	GENERAL,
	NEIGHBOR,
	FREQUENT;
}

@ToString(includeNames = true, includeFields = true, excludes = 'dateCreated,lastUpdated,metaClass')
@EqualsAndHashCode
class User {

	transient springSecurityService

	String username
	String password

	String title=""

	String telphone=""
	String mobile=""
	Date birthday
	String address=""
	String email=""
	UserType type=extrails.UserType.GENERAL
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static hasMany = [serviceEvents:ServiceEvent]

	static constraints = {
		username blank: false, unique: true
		password blank: false
		birthday nullable:true

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
}
