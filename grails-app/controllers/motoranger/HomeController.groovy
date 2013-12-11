package motoranger

import grails.plugin.springsecurity.annotation.Secured
import org.grails.plugins.csv.CSVMapReader

class HomeController {
	static layout = 'bootstrap'
	def springSecurityService


    def index= {

        def currentUser = springSecurityService.currentUser
        def store = currentUser?.store
        
        if(currentUser){
            def currentUserRoles = currentUser.getAuthorities()

            def roleManarger = Role.findByAuthority 'ROLE_MANARGER'
            def roleCustomer = Role.findByAuthority 'ROLE_CUSTOMER'
            def roleOperator = Role.findByAuthority 'ROLE_OPERATOR'


            if(store){
                redirect uri: "/store/show/${store.id}"
            }else {
                redirect uri: "/user/show/${currentUser.id}"
            }
        }else {


            def recentPosts = Post.list(max: 4, sort: 'dateCreated', order: 'desc')

            def unfinEvents= Event.findAllByStatus(motoranger.ProductStatus.UNFIN
                ,[order:"desc",sort:"lastUpdated"])
            def endEvents= Event.findAllByStatus(motoranger.ProductStatus.END
                ,[max:8,order:"desc",sort:"lastUpdated"])


            [
                recentPosts:recentPosts,
                unfinEvents:unfinEvents,
                endEvents:endEvents
            ]

        }


        



    }
    def question={
        
    }


    def selectIndex= {

    }
    
}
