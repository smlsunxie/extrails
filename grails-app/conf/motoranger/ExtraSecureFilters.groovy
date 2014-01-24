package motoranger
import grails.plugin.springsecurity.SpringSecurityUtils

class ExtraSecureFilters {

    def userService

    def filters = {

        eventFilter(controller:'event', action:'*') {


            before = {
                def currentUser = userService.currentUser()



                if(userService.isCustomer() && (actionName == "create" || actionName == "save") 
                    && params?.product?.id)
                {

                    def product = Product.findById(params.product.id)

                    if(!product?.user || product.user.id !=  currentUser.id){
                        flash.message = "沒有權限建立不屬於自己產品的維修事件"
                        redirect(action: "user", controller: "store", id: currentUser.id)
                        return false 

                    }                        
                }else if((userService.isOperator() || userService.isManerger) 
                     && (actionName == "edit" || actionName == "update" || actionName == "delete")){

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
                        setModelEventExtraCondiction(model.events, model)                   
                    } 
                }else if(actionName == "show" || actionName == "pickPartAddDetail" ){

                    model.currentUserIsEventOwner=[:]
                    model.eventDetailTotalPrice=[:]  

                    if(model?.event){
                        setModelEventExtraCondiction([model.event], model)
                    }
                }

            }

        }

        eventDetailFilter(controller:'eventDetail', action:'*') {
            before = {

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
        productFilter(controller:'product', action:'*') {
            before = {
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
        partFilter(controller:'part', action:'*') {
            before = {
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
        loginFilter(controller:'login', action:'swithUser') {
            before = {
                def user = User.findByUsername(params.username)

                if((userService.isOperator() || userService.isManerger())
                    && (!user?.store || user.store.id != currentUser.store.id))
                {

                    flash.message = "無法切換到不屬於「${currentUser.store}」的使用者"
                    redirect(action: "show", controller: "store", id: currentUser.store.id)
                    return false

                }
            }            
        }

        homeFilter(controller:'home', action:'index') {


            after = {
                model.currentUserIsEventOwner=[:]
                model.eventDetailTotalPrice=[:]                 
                
                if(model?.unfinEvents){
                    setModelEventExtraCondiction(model.unfinEvents, model)
                }
                if(model?.endEvents){
                    setModelEventExtraCondiction(model.endEvents, model)
                }
            }

        }        
        userFilter(controller: 'user') {
            before = {
                if(currentUser && userService.isCustomer()
                    && (actionName == "edit" || actionName == "update" || actionName == "delete")){
                    if(params?.id != currentUser.id){
                        flash.message = "不可維護其他使用者的資料"
                        redirect(action: "show", controller: "user", id: currentUser.id)


                    }

                }else if(currentUser && userService.isOperator() && userService.isManerger()
                    && (actionName == "edit" || actionName == "update" || actionName == "delete")){
                    

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

    private isFilterActionName(actionName){
        if((actionName == "edit"
            || actionName == "update"
            || actionName == "save"
            || actionName == "delete"
            || actionName == "pickPartAddDetail"))
            return true
        else return false

    }

    private setModelPartCostExtraCondiction(part, model){

        def currentUser = userService.currentUser()
        def isCustomerAndPartOwner = (userService.isCustomer()
            && currentUser.id == part?.user.id)
        def isManergerAndPartOwner = (SpringSecurityUtils.ifAnyGranted("ROLE_MANERGER")
            && currentUser.store.id == part?.store.id)

        println "isCustomerAndPartOwner = ${isCustomerAndPartOwner}"
        println "isManergerAndPartOwner = ${isManergerAndPartOwner}"

        model.userIsPartOwner = (isCustomerAndPartOwner 
            || isManergerAndPartOwner 
            || SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN"))

        if(!model.userIsPartOwner){
            part.cost = null
        }  

    }

    private setModelProductNameExtraCondiction(product){
        def currentUser = userService.currentUser()
        def isCustomerButNotProductOwner = (userService.isCustomer() && currentUser.id != product?.user.id)
        def isNotLoggedIn = !currentUser


        if( isNotLoggedIn || isCustomerButNotProductOwner){
            product.name = product.name.replace(product.name.substring(2,4),"**")
            product.user = null
        }


    }
    private setModelEventExtraCondiction(events, model, withDetail = false){
        def currentUser = userService.currentUser()

        events.each(){ event ->
            def userStoreOwnEvent = (currentUser?.store && currentUser?.store == event?.store)
            def userOwnEvent = (currentUser && currentUser == event?.user)
            if(userStoreOwnEvent || userOwnEvent){
                model.currentUserIsEventOwner[event.id]=true

                if(withDetail){
                    event.details.each(){ detail ->
                        model.eventDetailTotalPrice[detail.id] = "${detail?.price}*${detail?.qty}=${detail?.price*detail?.qty}"
                    }
                }

            }else{
                model.currentUserIsEventOwner[event.id]=false
                if(withDetail){
                    event.details.each(){ detail ->
                        model.eventDetailTotalPrice[detail.id] = "****"
                    }
                }
            }

            setModelProductNameExtraCondiction(event.product)
        }
    }
}
