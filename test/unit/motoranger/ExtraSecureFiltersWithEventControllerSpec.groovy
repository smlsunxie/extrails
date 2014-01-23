package motoranger

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestFor(EventController)
@Mock([User, Role, UserRole, Store, UserService, ExtraSecureFilters])
class ExtraSecureFiltersWithEventControllerSpec extends Specification {

    def setup() {
		User.metaClass.encodePassword = {
			password = 'password'
		}

		def storeA = new Store(name: "storeA", title: "storeA").save(failOnError: true)
		def userStoreA = new User(username: 'userStoreA', title: 'userStoreA', password:'pass'
			, enabled: true, store: storeA).save(failOnError: true)
		def storeB = new Store(name: "storeB", title: "storeB").save(failOnError: true)

		ExtraSecureFilters.metaClass.springSecurityService = [ 
	    	currentUser: userStoreA
    	]
    	
    }

    def cleanup() {
    }


    void "使用者為 ROLE_OPERATOR 只可維護自己或所屬店家的事件"(){
    	setup: "mock user 有 ROLE_OPERATOR 權限，並且建立 storeB"
    	    UserService.metaClass.currentUserIsOperator = {
	        	true
	        }
			def userStoreA = User.findByUsername('userStoreA')
			params.id = userStoreA.store.id    	

    }
}
