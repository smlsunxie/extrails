package motoranger
import grails.plugin.springsecurity.SpringSecurityUtils

class ExtraSecureFilters {

    def userService
    def springSecurityService

    def filters = {

        user(controller:'*', action:'*') {
            before = {



                def currentUser = springSecurityService?.currentUser
                if(currentUser){
                    params.currentUserStoreId=currentUser?.store?.id
                    params.currentUserId=currentUser?.id
                }


                // 店家防護
                if(currentUser && userService.currentUserIsOperator()){
                    
                    def notAllow = false
    
                    if(controllerName=="login" && actionName=="swithUser"){
                        def user = User.findByUsername(params.username)

                        if(!user?.store || user.store.id != params.currentUserStoreId){
                            notAllow = true
                            flash.message = "無法切換到不屬於「${currentUser.store}」的使用者"

                        }

                    }


                    //User
                    if(controllerName == "user" && isFilterActionName(actionName) 
                        && params?.id && params.id.toLong() != currentUser.id.toLong())
                    {

                        def user = User.get(params.id)

                        if(user.store != currentUser.store && user.enabled){
                            flash.message = "已經啟用或不屬於「${currentUser.store}」的使用者不可維護"
                            notAllow=true
                        }
                    }

                    //store
                    if(controllerName == "store" && isFilterActionName(actionName) 
                        && params?.id && params.id.toLong() != currentUser?.store.id.toLong())
                    {

                        notAllow=true
                        flash.message = "只可維護自己的店家"

                    }

                    //store
                    if(controllerName == "event" && isFilterActionName(actionName) 
                        && params?.id)
                    {
                        def event = Event.findById(params.id)

                        if(event?.user == currentUser || event?.store == currentUser.store){


                        }else {
                            notAllow=true
                            flash.message = "只可維護自己店家的維修事件" 
                        }
                        

                    }

                    if(notAllow){
                        if(actionName != "show"){
                            redirect(action: "show", controller: "store", id: currentUser.store.id)
                            return false
                        }
                    }
                }

                if(currentUser && userService.currentUserIsCustomer()){
                    def notAllow = false

                    if(controllerName == "event" && actionName == "create" && params?.product?.id){

                        def product = Product.findById(params?.product?.id)
                        if(!product?.user || product.user.id !=  currentUser.id){
                            flash.message = "沒有權限建立不屬於自己產品的維修事件"
                            notAllow = true

                        }                        
                    }

                    if(controllerName == "eventDetail" && actionName == "create" && params?.head?.id){

                        def product = Event.findById(params.head.id).product

                        if(!product?.user || product.user.id !=  currentUser.id){
                            flash.message = "沒有權限建立不屬於自己產品的維修事件"
                            notAllow = true

                        }                        
                    }


                    if(params.id){

                        if(controllerName == "user" && isFilterActionName(actionName)){

                            if(currentUser.id.toLong() != params.id.toLong()){
                                flash.message = "沒有權限維護其他使用者"
                                notAllow = true

                            }

                        }

                        if(controllerName == "product" && isFilterActionName(actionName)){

                            def product = Product.findById(params.id)

                            if(!product?.user || product.user.id !=  currentUser.id){
                                flash.message = "沒有權限維護不屬於自己的產品"
                                notAllow = true

                            }

                        }

                        if(controllerName == "event" && isFilterActionName(actionName)){

                            def product = Event.findById(params.id).product

                            if(!product?.user || product.user.id !=  currentUser.id){
                                flash.message = "沒有權限維護不屬於自己產品的維修事件"
                                notAllow = true

                            }

                        }

                        if(controllerName == "eventDetail" && isFilterActionName(actionName)){

                            def product = EventDetail.findById(params.id).head.product

                            if(!product?.user || product.user.id !=  currentUser.id){

                                flash.message = "沒有權限維護不屬於自己產品的維修事件"
                                notAllow = true

                            }

                        }

                        if(controllerName == "part" && isFilterActionName(actionName)){


                            if(currentUser.id != Part.findById(params.id)?.user?.id){
                                flash.message = "沒有權限維護不屬於自己產品的維修項目"
                                notAllow = true

                            }

                        }

                    }

                    if(notAllow){

                        redirect(action: "show", controller: "user", id: currentUser.id)
                        return false
                    }

                }


            }

            after = { Map model ->
                def currentUser = springSecurityService?.currentUser


                if(actionName == "show" || actionName == "index" || actionName == "pickPartAddDetail"){
                    if(!model)model=[:]
                    model.currentUserIsEventOwner=[:]
                    model.eventDetailTotalPrice=[:]                    
                    if(model?.part){
                        setModelPartCostExtraCondiction(model.part, model)                   
                    }

                    if(model?.product){
                        setModelProductNameExtraCondiction(model.product)
                        setModelEventExtraCondiction(model.product?.events, model, true)
                    }
                    if(model?.unfinEvents){
                        setModelEventExtraCondiction(model.unfinEvents, model)
                    }
                    if(model?.endEvents){
                        setModelEventExtraCondiction(model.endEvents, model)
                    }
                    if(model?.eventDetail){
                        setModelEventExtraCondiction([model.eventDetail.head], model)
                        setModelPartCostExtraCondiction(model.eventDetail.part, model)
                    }

                    if(model?.event){
                        setModelEventExtraCondiction([model.event], model)
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

        def currentUser = springSecurityService?.currentUser
        def isCustomerAndPartOwner = (userService.currentUserIsCustomer()
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

        def isCustomerButNotProductOwner = (userService.currentUserIsCustomer() && currentUser.id != product?.user.id)
        def isNotLoggedIn = !springSecurityService.isLoggedIn() 


        if( isNotLoggedIn || isCustomerButNotProductOwner){
            product.name = product.name.replace(product.name.substring(2,4),"**")
            product.user = null
        }


    }
    private setModelEventExtraCondiction(events, model, withDetail = false){
        def currentUser = springSecurityService?.currentUser

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
