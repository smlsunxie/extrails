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
		def storeB = new Store(name: "storeB", title: "storeB").save(failOnError: true)

		ExtraSecureFilters.metaClass.springSecurityService = [ 
	    	currentUser: userStoreA
    	]
    	
    }

    def cleanup() {
    }

    void "使用者為 ROLE_MANERGER 不可維護不屬於自己的店家"() {
    	setup: "mock user 有 ROLE_MANERGER 權限，並且建立 storeB"
    	    UserService.metaClass.currentUserIsManerger = {
	        	true
	        }
			def userStoreA = User.findByUsername('userStoreA')
			def storeB = Store.findByName('storeB')
			params.id = storeB.id


    	when: "屬於 storeA 的 user 修改 storeB 時透過 filter 檢查"
    		response.reset()
	    	withFilters(controller:"store",action:"*") {
			    controller.edit()
			}
		then: "storeA 的 user 不可修改 storeB"
			assert flash.message == "只可維護自己的店家"
			assert response.redirectedUrl == '/store/show/'+userStoreA.store.id


    	when: "屬於 storeA 的 user 刪除 storeB 時透過 filter 檢查"
    		response.reset()
	    	withFilters(controller:"store",action:"*") {
			    controller.delete()
			}
		then: "storeA 的 user 不可刪除 storeB"
			assert flash.message == "只可維護自己的店家"
			assert response.redirectedUrl == '/store/show/'+userStoreA.store.id			


    	when: "屬於 storeA 的 user 更新 storeB 時透過 filter 檢查"
    		response.reset()
	    	withFilters(controller:"store",action:"*") {
			    controller.update()
			}
		then: "storeA 的 user 不可更新 storeB"
			assert flash.message == "只可維護自己的店家"
			assert response.redirectedUrl == '/store/show/'+userStoreA.store.id	

    }

    void "使用者為 ROLE_MANERGER 可以維護自己的店家"() {
    	setup: "mock user 有 ROLE_MANERGER 權限，並且建立 storeB"
    	    UserService.metaClass.currentUserIsManerger = {
	        	true
	        }
			def userStoreA = User.findByUsername('userStoreA')
			params.id = userStoreA.store.id


    	when: "屬於 storeA 的 user 修改 storeA 時透過 filter 檢查"
    		response.reset()
	    	withFilters(controller:"store",action:"*") {
			    controller.edit()
			}
		then: "storeA 的 user 可修改 storeA"
			assert !response.redirectedUrl


    	when: "屬於 storeA 的 user 刪除 storeA 時透過 filter 檢查"
    		response.reset()
	    	withFilters(controller:"store",action:"*") {
			    controller.delete()
			}
		then: "storeA 的 user 可刪除 storeA"
			assert flash.message == 'default.deleted.message'
			assert response.redirectedUrl=="/store/list"


    	when: "屬於 storeA 的 user 更新 storeA 時透過 filter 檢查"
    		response.reset()
	    	withFilters(controller:"store",action:"*") {
			    controller.update()
			}
		then: "storeA 的 user 可更新 storeA"
			assert flash.message == 'default.updated.message'
			assert response.redirectedUrl=="/store/show/"+userStoreA.store.id

    }

}
