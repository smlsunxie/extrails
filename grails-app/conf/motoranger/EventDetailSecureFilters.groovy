package motoranger

class EventDetailSecureFilters {

    def userService

    def filters = {



        all(controller:'eventDetail', action:'*') {
            before = {
                def currentUser = userService.currentUser()

                if(userService.isCustomer() && (actionName == "create" || actionName == "save") 
                    && params?.head?.id)
                {

                    def product = Event.findById(params.head.id).product

                    if(!product?.user || product.user.id !=  currentUser.id){
                        flash.message = "沒有權限建立不屬於自己產品的維修事件"
                        redirect(action: "user", controller: "store", id: currentUser.id)
                        return false 

                    }                        
                }else if(actionName != 'show' && params?.id && currentUser)
                {

                    def event = EventDetail.findById(params.id).head

                    if(event?.user == currentUser || (event?.store && event.store == currentUser?.store)){
                        return true                        
 
                    }else {
                        flash.message = "只可維護自己或所屬店家的維修事件"
                        if(currentUser?.store)
                            redirect(action: "show", controller: "store", id: currentUser.store.id)
                        else redirect(action: "user", controller: "store", id: currentUser.id)

                        return false                        
                    }
                }        
            }


            after = {

                if(actionName == "show" && model?.eventDetail){
                    model.currentUserIsEventOwner=[:]
                    model.eventDetailTotalPrice=[:] 
                    setModelEventExtraCondiction([model.eventDetail.head], model)
                    setModelPartCostExtraCondiction(model.eventDetail.part, model)
                }

            }
        }
    }
}
