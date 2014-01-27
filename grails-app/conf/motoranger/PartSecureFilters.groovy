package motoranger

class PartSecureFilters {

    def userService
    def secureFiltersService

    def filters = {

        all(controller:'part', action:'*') {
            before = {
                def currentUser = userService.currentUser()

                if(actionName == "edit" || actionName == "update" || actionName == "delete" || actionName == "*"){


                    if(currentUser && userService.isCustomer()){
                        def part = Part.findById(params.id)

                        if(part?.user && currentUser == part.user){
                            return true

                        }else {
                            flash.message = "沒有權限維護不屬於自己的維修項目"
                            redirect(action: "show", controller: "user", id: currentUser.id)
                            return false

                        }

                    }else if(currentUser && (userService.isOperator() || userService.isManerger())){

                        def part = Part.findById(params.id)
                        if(part?.user == currentUser || (part?.store && part.store == currentUser?.store)){
                        
                            return true
                        }else {

                            flash.message = "只可維護自己或所屬店家的維修項目"
                            redirect(action: "show", controller: "store", id: currentUser.store.id)
                            
                            return false                        

                        }

                    } 

                }        
            }

            after = { Map model ->
                if(actionName == "show" && model?.part){
                    secureFiltersService.setModelPartCostExtraCondiction(model.part, model)                   
                }
            }

        }
    }
}