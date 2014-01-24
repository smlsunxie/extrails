package motoranger

import grails.test.mixin.Mock
import spock.lang.Specification

@TestFor(UserController)
@Mock([User, Role, UserRole, UserService, UserSecureFilters])
class UserSecureFiltersSpec extends Specification {

    def setup() {
		User.metaClass.encodePassword = {
			password = 'password'
		}

        
	    UserService.metaClass.isManerger = {
        	false
        }


		def userA = new User(username: 'userA', title: 'userA', password:'pass'
			, enabled: true).save(failOnError: true)
		def userB = new User(username: 'userB', title: 'userB', password:'pass'
			, enabled: true).save(failOnError: true)    	


		UserService.metaClass.currentUser = {
        	userA
        }

    }

    def cleanup() {
    }

    void "使用者權限為客戶，不可維護其他使用者"() {
    	setup: "取得權限為客戶的使用者"
		    UserService.metaClass.isCustomer = {
	        	true
	        }    
	        def userA = User.findByUsername("userA")
	        def userB = User.findByUsername("userB")
	    when: "進行編輯其他使用者"
	    	params.id = userB.id
    		response.reset()
	    	withFilters(controller:'user', action:'*') {
			    controller.edit()
			}
		then: "不允許編輯"
			assert flash.message == "不可維護其他使用者的資料"
			assert response.redirectedUrl == "user/show/${userA.id}"




    }
}
