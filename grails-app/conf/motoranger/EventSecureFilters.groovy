package motoranger

class EventSecureFilters {

    def userService

    def secureFiltersService

    def filters = {

        all(controller:'event', action:'*') {


            before = {
                def currentUser = userService.currentUser()



                if(userService.isCustomer() && (actionName == "create" || actionName == "save" || actionName == "*") 
                    && params?.product?.id)
                {

                    def product = Product.findById(params.product.id)

                    if(!product?.user || product.user.id !=  currentUser.id){
                        flash.message = "沒有權限建立不屬於自己產品的維修事件"
                        redirect(action: "user", controller: "store", id: currentUser.id)
                        return false 

                    }                        
                }else if((userService.isOperator() || userService.isManerger) 
                     && (actionName == "edit" || actionName == "update" || actionName == "delete"  || actionName == "*")){

                    def event = Event.findById(params.id)

                    if(event?.user == currentUser || (event?.store && event.store == currentUser?.store)){
 
                    }else {
                        flash.message = "只可維護自己或所屬店家的維修事件"
                        if(currentUser?.store)
                            redirect(action: "show", controller: "store", id: currentUser.store.id)
                        else redirect(action: "user", controller: "store", id: currentUser.id)

                        return false                        
                    }
                }




            }
            after = { Map model ->
                def currentUser = userService.currentUser()


                if(actionName == "unfinListOfStore" || actionName == "endListOfStore" ){

                    model.currentUserIsEventOwner=[:]
                    model.eventDetailTotalPrice=[:]  

                    if(model?.events){
                        secureFiltersService.setModelEventExtraCondiction(model.events, model)                   
                    } 
                }else if(actionName == "show" || actionName == "pickPartAddDetail" ){

                    model.currentUserIsEventOwner=[:]
                    model.eventDetailTotalPrice=[:]  

                    if(model?.event){
                        secureFiltersService.setModelEventExtraCondiction([model.event], model)
                    }
                }

            }

        }
    }
}
