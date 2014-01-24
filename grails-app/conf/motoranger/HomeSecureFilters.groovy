package motoranger
import grails.plugin.springsecurity.SpringSecurityUtils

class HomeSecureFilters {

    def secureFiltersService

    def filters = {

        all(controller:'home', action:'index') {


            after = {
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
