package motoranger

class ProductSecureFilters {

    def userService

    def filters = {


        all(controller:'product', action:'*') {
            before = {
                def currentUser = userService.currentUser()
                if(userService.isCustomer() && params?.id
                 && (actionName == "edit" || actionName == "update" || actionName == "delete")){

                    def product = Product.findById(params.id)

                    if(!product?.user || product.user.id !=  currentUser.id){
                        redirect(action: "user", controller: "store", id: currentUser.id)
                    }

                }else if(params?.id && currentUser
                    && (actionName == "edit" || actionName == "update" || actionName == "delete")){

                    def product = Product.findById(params.id)

                    if(product.user.enabled && product.user!=currentUser){
                        flash.message = "已啟用使用者之產品不可維護"
                        redirect(action: "user", controller: "store", id: currentUser.id)
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
