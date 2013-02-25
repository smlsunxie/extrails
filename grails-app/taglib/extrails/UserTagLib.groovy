package extrails

class UserTagLib {
    def springSecurityService
    
    def emoticon = { attrs, body ->
       out << body() << (attrs.happy == 'true' ? " :-)" : " :-(")
    }
    
    def displayUserName = { attrs, body ->
    
        def output = ''
        
        try {
            def user = springSecurityService.currentUser
            
            def display = user?.fullName
            
            if (!display) {
                display = user?.username
            }
            
            output = display
            
        }
        catch (e) {
            log.error e.message
        }
        
        out << body() << output
    }
}
