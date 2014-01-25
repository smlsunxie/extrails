package motoranger

class EventDetailSecureFilters {

    def userService
    def secureFiltersService

    def filters = {

        create(controller:'eventDetail', action:'*') {
            before = {
                def currentUser = userService.currentUser()

                if(actionName == "create" || actionName == "save" || actionName == "*"){

                    if(currentUser && userService.isCustomer())
                    {

                        def product = Event.findById(params.head.id).product

                        if(!product?.user || product.user.id !=  currentUser.id){
                            flash.message = "沒有權限建立不屬於自己產品的維修事件之維修項目"
                            redirect(action: "show", controller: "user", id: currentUser.id)
                            return false 

                        }

                    }
                    else if(currentUser && (userService.isOperator() || userService.isManerger()))
                    {

                        def event = Event.findById(params.head.id)

                        if(!event?.store || event.store !=  currentUser.store){
                            flash.message = "沒有權限建立不屬於自己店家的維修事件之維修項目"
                            redirect(action: "show", controller: "store", id: currentUser.id)
                            return false 
                        }
                    }
                }else if(actionName == "edit" || actionName == "update" || actionName == "delete" || actionName == "*"){
                    def event = EventDetail.findById(params.id).head

                    if(event?.user == currentUser || (event?.store && event.store == currentUser?.store)){
                        return true                        
 
                    }else {
                        flash.message = "只可維護自己或所屬店家的維修事件之維修項目"
                        if(currentUser?.store)
                            redirect(action: "show", controller: "store", id: currentUser.store.id)
                        else redirect(action: "show", controller: "user", id: currentUser.id)

                        return false                        
                    } 
                }

            }
        }

        edit(controller:'eventDetail', action:'show') {

            after = { Map model ->

                if(model?.eventDetail){
                    model.currentUserIsEventOwner=[:]
                    model.eventDetailTotalPrice=[:] 
                    secureFiltersService.setModelEventExtraCondiction([model.eventDetail.head], model, true)
                    secureFiltersService.setModelPartCostExtraCondiction(model.eventDetail.part, model)
                }

            }
        }
    }
}
