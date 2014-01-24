package motoranger

import grails.transaction.Transactional

@Transactional
class SecureFiltersService {

	def userService

    private setModelPartCostExtraCondiction(part, model){

        def currentUser = userService.currentUser()
        def isCustomerAndPartOwner = (userService.isCustomer()
            && currentUser.id == part?.user.id)
        def isManergerAndPartOwner = (userService.isManerger()
            && currentUser.store.id == part?.store.id)

        model.userIsPartOwner = (isCustomerAndPartOwner 
            || isManergerAndPartOwner 
            || userService.isAdmin())

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
