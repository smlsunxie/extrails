package motoranger

class PartSecureFilters {

    def userService

    def filters = {

        all(controller:'part', action:'*') {
            before = {
                def currentUser = userService.currentUser()

                if(userService.isCustomer() && params?.id 
                     && (actionName == "edit" || actionName == "update" || actionName == "delete")){

                    def part = Part.findById(params.id)

                    if(Part?.user || currentUser != Part.user){
                        flash.message = "沒有權限維護不屬於自己的維修項目"
                        redirect(action: "user", controller: "store", id: currentUser.id)

                    }

                }else if(actionName != 'show' && params?.id && currentUser){

                    def part = Part.findById(params.id)
                    if(part?.user == currentUser || (part?.store && part.store == currentUser?.store)){
                    }else {
                        flash.message = "只可維護自己或所屬店家的維修項目"
                        if(currentUser?.store)
                            redirect(action: "show", controller: "store", id: currentUser.store.id)
                        else redirect(action: "user", controller: "store", id: currentUser.id)

                        return false                        

                    }

                }         
            }

            after = {
                if(actionName == "show" && model?.part){
                    setModelPartCostExtraCondiction(model.part, model)                   
                }
            }

        }
    }
}
