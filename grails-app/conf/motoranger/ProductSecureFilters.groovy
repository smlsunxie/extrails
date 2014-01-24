package motoranger

class ProductSecureFilters {

    def userService

    def filters = {


        all(controller:'product', action:'*') {
            before = {
                def currentUser = userService.currentUser()

                if(actionName == "edit" || actionName == "update" || actionName == "delete" || actionName == "*"){

                    if(currentUser && userService.isCustomer()){

                        def product = Product.findById(params.id)

                        if(!product?.user || product.user.id !=  currentUser.id){
                            flash.message = "已啟用使用者之產品不可維護"
                            redirect(action: "show", controller: "user", id: currentUser.id)
                        }

                    }else if(currentUser && (userService.isOperator() || userService.isManerger())){

                        def product = Product.findById(params.id)

                        if(product.user.enabled && product.user!=currentUser){
                            flash.message = "已啟用使用者之產品不可維護"
                            redirect(action: "show", controller: "store", id: currentUser.store.id)
                        }

                    }
                }

            }

            after = {

                if(actionName=="show" && model?.product){

                    model.currentUserIsEventOwner=[:]
                    model.eventDetailTotalPrice=[:]                     
                    setModelProductNameExtraCondiction(model.product)
                    setModelEventExtraCondiction(model.product?.events, model, true)
                }

            }

        }
    }
}
