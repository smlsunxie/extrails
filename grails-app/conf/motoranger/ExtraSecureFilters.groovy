package motoranger
import grails.plugin.springsecurity.SpringSecurityUtils

class ExtraSecureFilters {

    def userService
    def springSecurityService

    def filters = {

        user(controller:'*', action:'*') {
            before = {


                def currentUser = springSecurityService?.currentUser
                if(currentUser){
                    params.currentUserStoreId=currentUser?.store?.id
                    params.currentUserId=currentUser?.id
                }

                
                // 店家防護
                if(currentUser && userService.currentUserIsOperator()){
                    
                    def notAllow = false


                    //User
                    if(controllerName == "user" && isFilterActionName(actionName) 
                        && params.id.toLong() != currentUser.id.toLong())
                    {

                        def user = User.get(params.id)

                        if(user.enabled){
                            flash.message = "已經啟用的使用者不可維護"
                            notAllow=true
                        }
                    }

                    //store
                    if(controllerName == "store" && isFilterActionName(actionName) 
                        && params.id.toLong() != currentUser?.store.id.toLong())
                    {

                        notAllow=true
                        flash.message = "只可維護自己的店家"

                    }

                    if(notAllow){
                        if(actionName != "show"){
                            redirect(action: "show", controller: "store", id: currentUser.id)
                            return false
                        }
                    }
                }

                if(currentUser && userService.currentUserIsCustomer()){
                    def notAllow = false

                    if(controllerName == "event" && actionName == "create" && params?.product?.id){

                        def product = Product.findById(params?.product?.id)
                        if(!product?.user || product.user.id !=  currentUser.id){
                            flash.message = "沒有權限建立不屬於自己產品的維修事件"
                            notAllow = true

                        }                        
                    }

                    if(controllerName == "eventDetail" && actionName == "create" && params?.head?.id){

                        def product = Event.findById(params.head.id).product

                        if(!product?.user || product.user.id !=  currentUser.id){
                            flash.message = "沒有權限建立不屬於自己產品的維修事件"
                            notAllow = true

                        }                        
                    }


                    if(params.id){

                        if(controllerName == "user" && isFilterActionName(actionName)){

                            if(currentUser.id.toLong() != params.id.toLong()){
                                flash.message = "沒有權限維護其他使用者"
                                notAllow = true

                            }

                        }

                        if(controllerName == "product" && isFilterActionName(actionName)){

                            def product = Product.findById(params.id)

                            if(!product?.user || product.user.id !=  currentUser.id){
                                flash.message = "沒有權限維護不屬於自己的產品"
                                notAllow = true

                            }

                        }

                        if(controllerName == "event" && isFilterActionName(actionName)){

                            def product = Event.findById(params.id).product

                            if(!product?.user || product.user.id !=  currentUser.id){
                                flash.message = "沒有權限維護不屬於自己產品的維修事件"
                                notAllow = true

                            }

                        }

                        if(controllerName == "eventDetail" && isFilterActionName(actionName)){

                            def product = EventDetail.findById(params.id).head.product

                            if(!product?.user || product.user.id !=  currentUser.id){

                                flash.message = "沒有權限維護不屬於自己產品的維修事件"
                                notAllow = true

                            }

                        }

                        if(controllerName == "part" && isFilterActionName(actionName)){


                            if(currentUser.id != Part.findById(params.id)?.user?.id){
                                flash.message = "沒有權限維護不屬於自己產品的維修項目"
                                notAllow = true

                            }

                        }

                    }

                    if(notAllow){

                        redirect(action: "show", controller: "user", id: currentUser.id)
                        return false
                    }

                }


            }
        }

    }

    private isFilterActionName(actionName){
        if((actionName == "edit"
            || actionName == "update"
            || actionName == "save"
            || actionName == "delete"
            || actionName == "pickPartAddDetail"))
            return true
        else return false

    }

    private isUserNotOwnProduct(userId, productId){
        if(Product.findById(productId).user.id == userId){
            return false
        }else {
            return true            
        }

    }
}
