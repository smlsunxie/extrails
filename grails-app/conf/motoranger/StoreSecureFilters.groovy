package motoranger

class StoreSecureFilters {

    def userService
    def secureFiltersService

    def filters = {

        all(controller:'store', action:'*') {
            before = {
                def currentUser = userService.currentUser()

                if(userService.isManerger() 
                    && (actionName == "edit" || actionName == "update" || actionName == "delete" || actionName == "*"))
                {

                    if(params.id.toLong() != currentUser.store.id){

                        flash.message = "只可維護自己的店家"
                        redirect(action: "show", controller: "store", id: currentUser.store.id)
                        return false

                    }
                }


            }
            after = { Map model ->
                def currentUser = userService.currentUser()


                if(actionName == 'show' && (model?.unfinEvents || model?.endEvents)){

                    model.currentUserIsEventOwner=[:]
                    model.eventDetailTotalPrice=[:]  

                    if(model?.unfinEvents){
                        secureFiltersService.setModelEventExtraCondiction(model.unfinEvents, model)
                    }
                    if(model?.endEvents){
                        secureFiltersService.setModelEventExtraCondiction(model.endEvents, model)
                    }

                    
 
                }

                if(params?.id && currentUser){

                    model.currentUserBelongsStore = 
                        (currentUser?.store?.id == params.id || userService.isAdmin())
                
                }


            }

        }
    }
}
