package motoranger

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestFor(StoreController)
@Mock([User, Role, UserRole, Store, UserService, ExtraSecureFilters])
class ExtraSecureFiltersWithStoreControllerSpec extends Specification {

    def setup() {
		User.metaClass.encodePassword = {
			password = 'password'
		}

		def storeA = new Store(name: "storeA", title: "storeA").save(failOnError: true)
		def userStoreA = new User(username: 'userStoreA', title: 'userStoreA', password:'pass'
			, enabled: true, store: storeA).save(failOnError: true)


        UserService.metaClass.currentUserIsOperator = {
        	true
        }
        UserService.metaClass.currentUserIsCustomer = {
        	true
        }

		ExtraSecureFilters.metaClass.springSecurityService = [ 
	    	currentUser: userStoreA
    	]
    	
    }

    def cleanup() {
    }

    void "使用者只能維護所屬店家的資料"() {

    	setup: "建立 storeB"
    		def storeB = new Store(name: "storeB", title: "storeB").save(failOnError: true)
			def userStoreA = User.findByUsername('userStoreA')

    	when: "屬於 storeA 的 user 進行維護 storeB 時透過 filter 檢查"

	    	params.id = storeB.id
	    	withFilters(controller:"store",action:"*") {
			    controller.edit()
			}

		then: "storeA 的 user 不可維護 storeB"
			assert flash.message == "只可維護自己的店家"
			assert response.redirectedUrl == '/store/show/'+userStoreA.store.id
    }
}
