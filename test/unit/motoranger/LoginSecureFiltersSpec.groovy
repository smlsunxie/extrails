package motoranger

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestFor(LoginController)
@Mock([User, Store, UserService, LoginSecureFilters])
class LoginSecureFiltersSpec extends Specification {

    def setup() {

		User.metaClass.encodePassword = {
			password = 'password'
		}

	    UserService.metaClass.isOperator = {
        	true
        }	        
	    UserService.metaClass.isManerger = {
        	false
        }


		def storeA = new Store(name: "storeA", title: "storeA").save(failOnError: true)
		def userA = new User(username: 'userA', title: 'userA', password:'pass'
			, enabled: true, store: storeA).save(failOnError: true)
		def storeB = new Store(name: "storeB", title: "storeB").save(failOnError: true)
		def userB = new User(username: 'userB', title: 'userB', password:'pass'
			, enabled: true, store: storeB).save(failOnError: true)    	

		UserService.metaClass.currentUser = {
        	userA
        }
    }

    def cleanup() {
    }

    void "切換使用者，需要有 operator 或 manerger 的權限，並且只能切換所屬店家的使用者"() {
    	setup: "取得使用者，以及要切換的使用者為屬於不同店家的使用者"
    		def userA = User.findByUsername('userA')
    		def userB = User.findByUsername('userB')
    		params.username = userB.username
    	when: "進行切使用者"
    		response.reset()
	    	withFilters(controller:'login', action:'switchUser') {
			    controller.switchUser()
			}
		then: "不允許切換"
			flash.message == "無法切換到不屬於「${userA.store}」的使用者"
			assert response.redirectedUrl == '/store/show/'+userA.store.id


			// assert response.redirectedUrl == '/store/show/'+userA.store.id



    }
}
