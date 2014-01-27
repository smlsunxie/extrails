package motoranger
import grails.plugin.springsecurity.SpringSecurityUtils

class HomeSecureFilters {

    def userService
    def secureFiltersService

    def filters = {

        all(controller:'home', action:'index') {


            after = { Map model ->

                if(model ){
                    model.currentUserIsEventOwner=[:]
                    model.eventDetailTotalPrice=[:]                 
                    
                    if(model?.unfinEvents){
                        secureFiltersService.setModelEventExtraCondiction(model.unfinEvents, model)
                    }
                    if(model?.endEvents){
                        secureFiltersService.setModelEventExtraCondiction(model.endEvents, model)
                    }
                }
            }

        }        


    }




}
