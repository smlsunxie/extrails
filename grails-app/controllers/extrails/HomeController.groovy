package extrails



class HomeController {
	static layout = 'bootstrap'
	def springSecurityService

    def index() {
        // 如果已經登入
        // 先檢查 User.works（是否已經通過「開始使用」步驟）
        // 如果 User.works == FALSE 則先跳到步驟 II
       
        if (springSecurityService.isLoggedIn()) { 
            
            def user = springSecurityService.currentUser
            
            // if (!user?.works) {
            //     redirect action: 'step2'
            //     return
            // }
        }


        def recentPosts = Post.findAll(max: 4, sort: 'dateCreated', order: 'desc') {

        }

        [
            recentPosts:recentPosts
        ]


    }
    def abouts(){
        
    }
}
