package motoranger

class UserSecureFilters {

    def userService
    def secureFiltersService

    def filters = {
        all(controller: 'user', action: "edit") {
            before = {


                if(actionName == "edit" || actionName == "update" || actionName == "delete"|| actionName == "*"){
                    def currentUser = userService.currentUser()

                    if(currentUser && userService.isCustomer()){
                        if(params.id.toLong() != currentUser.id){
                            flash.message = "不可維護其他使用者的資料"
                            redirect(action: "show", controller: "user", id: currentUser.id)
                            return false
                        }

                    }else if(currentUser && (userService.isOperator() || userService.isManerger())){
                        

                        def user = User.get(params.id)

                        if(user.store == currentUser.store || !user.enabled ){ 
                            return true

                        }else {
                            flash.message = "已經啟用或不屬於「${currentUser.store}」的使用者不可維護"

                            if(currentUser?.store)
                                redirect(action: "show", controller: "store", id: currentUser.store.id)
                            else redirect(action: "user", controller: "store", id: currentUser.id)

                            return false  
                        }
                    }
                }

            }
        }
        all(controller: 'user', action: "show") {
            after = { model ->
                if(model?.user)
                    secureFiltersService.setModelUserExtraCondiction(model.user)
                if(model?.products){
                    model.products.each(){ product ->
                        secureFiltersService.setModelProductNameExtraCondiction(product)
                    }
                }
            }

        }        
    }
}
