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

            if(store){
                redirect uri: "/store/show/${store.id}"
            }else {
                redirect uri: "/user/show/${currentUser.id}"
            }
        }else {


            def recentPosts = Post.list(max: 4, sort: 'dateCreated', order: 'desc')

            def unfinEvents= Event.findAllByStatus(motoranger.ProductStatus.UNFIN
                ,[max:4, order:"desc", sort:"date"])
            def endEvents= Event.findAllByStatus(motoranger.ProductStatus.END
                ,[max:4, order:"desc", sort:"date"])


            [ 
                recentPosts:recentPosts,
                unfinEvents:unfinEvents,
                endEvents:endEvents
            ]

        }


        



    }
    def question={

        flash.message = "留下您的建議，或者您也可以點選下方「意見回饋」按鈕寄送 mail"
        
    }


    def selectIndex= {

    }

    
}
