package motoranger

class ExtraSecureFilters {

    def userService
    def springSecurityService

    def filters = {


        user(controller:'*', action:'*') {
            before = {
                def currentUser = springSecurityService.currentUser

                if(currentUser && userService.currentUserIsOperator() && params?.id && actionName != "show"){
                    if(params.id.toLong() != currentUser.id.toLong() && controllerName == "user" && isFilterActionName(actionName)){

                        def user = User.get(params.id)

                        if(user.enabled){
                            flash.message = "已經啟用的使用者不可維護"
                            redirect(action: "show", controller: "user", id: user.id)
                            return false
                        }
                    }
                    if(params.id.toLong() != currentUser?.store.id.toLong() && controllerName == "store" && isFilterActionName(actionName)){

                        if(actionName=="show"){
                            params.notAllow=true
                        }else {
                            flash.message = "只可維護自己的店家"
                            redirect(action: "show", controller: "store", id: currentUser.store.id)
                            return false
                        }
                    }                    
                }

                if(currentUser && userService.currentUserIsCustomer()){
                    def notAllow = false

                    if(controllerName == "event" && actionName == "create" && params?.product?.id){
                        if(isUserNotOwnProduct(currentUser.id, params?.product?.id)){
                            flash.message = "沒有權限建立不屬於自己產品的維修事件"
                            notAllow = true

                        }                        
                    }

                    if(controllerName == "eventDetail" && actionName == "create" && params?.head?.id){

                        def productId = Event.findById(params.head.id).product.id

                        if(isUserNotOwnProduct(currentUser.id, productId)){
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

                            if(Product.findById(params.id).user.id != currentUser.id){
                                flash.message = "沒有權限維護不屬於自己的產品"
                                notAllow = true

                            }

                        }

                        if(controllerName == "event" && isFilterActionName(actionName)){

                            def productId = Event.findById(params.id).product.id

                            if(isUserNotOwnProduct(currentUser.id, productId)){
                                flash.message = "沒有權限維護不屬於自己產品的維修事件"
                                notAllow = true

                            }

                        }

                        if(controllerName == "eventDetail" && isFilterActionName(actionName)){

                            def productId = EventDetail.findById(params.id).head.product.id

                            if(isUserNotOwnProduct(currentUser.id, productId)){

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

                        if(actionName == "show"){
                            flash.message = "不是屬於您的資料，檢視受限"
                            params.notAllow=true

                        }else{
                            redirect(action: "show", controller: "user", id: currentUser.id)
                            return false
                        }
                    }else {

                    }

                }


            }
        }

    }

    private isFilterActionName(actionName){
        if((actionName == "show" 
            || actionName == "edit"
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
