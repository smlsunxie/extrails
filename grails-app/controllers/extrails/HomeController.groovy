package extrails

import grails.plugins.springsecurity.Secured
import org.grails.plugins.csv.CSVMapReader

class HomeController {
	static layout = 'bootstrap'
	def springSecurityService

    def index= {



        def recentPosts = Post.findAll(max: 4, sort: 'dateCreated', order: 'desc') {

        }

        def createProducts=Product.findAllByOwner(extrails.ProductOwner.CUSTOMER
            ,[max:4,order:"desc", sort: 'dateCreated'])

        def unfinEvents= Event.findAllByStatus(extrails.ProductStatus.UNFIN
            ,[order:"desc",sort:"lastUpdated"])
        def endEvents= Event.findAllByStatus(extrails.ProductStatus.END
            ,[max:8,order:"desc",sort:"lastUpdated"])

        //add manager constrant

        def operators=[]





        if(springSecurityService?.currentUser?.store 
            && springSecurityService?.currentUser.getAuthorities().contains(extrails.Role.findByAuthority('ROLE_MANERGER'))){

            def users=User.findAllByStore(springSecurityService?.currentUser?.store)

            users.each(){
                if(it.getAuthorities().contains(extrails.Role.findByAuthority('ROLE_OPERATOR'))){
                    operators << it
                }

            }

            // def query=UserRole.where{
            //     role==extrails.Role.findByAuthority('ROLE_OPERATOR')
            //     // user==springSecurityService.currentUser.store.id
            // }


            // operators= query.list().user

            // log.info operators.title
            // log.info operators.store
        }

        [
            recentPosts:recentPosts,
            unfinEvents:unfinEvents,
            endEvents:endEvents,
            // createProducts:createProducts,
            operators:operators
        ]


    }
    def question={
        
    }




    
}
