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

        // // 取得首頁公告資料    
        // def posts = Post.findAll(max: 10, sort: 'dateCreated', order: 'desc') {
        //     type == PostType.ANNOUNCE
        // }

        // // 取得新書資料
        // def books = Book.findAll(max: 10, sort: 'publishDate', order: 'desc') {
        //     title != null
        // }
    }
}
