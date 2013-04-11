package extrails

import grails.plugins.springsecurity.Secured
import org.grails.plugins.csv.CSVMapReader

class HomeController {
	static layout = 'bootstrap'
	def springSecurityService

    def index= {
        // 如果已經登入
        // 先檢查 User.works（是否已經通過「開始使用」步驟）
        // 如果 User.works == FALSE 則先跳到步驟 II
       
        // if (springSecurityService.isLoggedIn()) { 
            
            // def user = springSecurityService.currentUser
            
            // if (!user?.works) {
            //     redirect action: 'step2'
            //     return
            // }
        // }


        def recentPosts = Post.findAll(max: 4, sort: 'dateCreated', order: 'desc') {

        }

        def createProducts=Product.findAllByOwner(extrails.ProductOwner.CUSTOMER
            ,[max:4,order:"desc", sort: 'dateCreated'])

        def unfinEvents= Event.findAllByStatus(extrails.ProductStatus.UNFIN
            ,[order:"desc",sort:"lastUpdated"])
        def endEvents= Event.findAllByStatus(extrails.ProductStatus.END
            ,[max:8,order:"desc",sort:"lastUpdated"])

        def operators=UserRole.findAllByRole(extrails.Role.findByAuthority('ROLE_OPERATOR'))*.user

        [
            recentPosts:recentPosts,
            unfinEvents:unfinEvents,
            endEvents:endEvents,
            createProducts:createProducts,
            operators:operators
        ]


    }
    def question={
        
    }




    
}
