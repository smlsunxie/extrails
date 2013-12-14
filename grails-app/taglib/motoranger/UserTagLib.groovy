package motoranger

class UserTagLib {
    def springSecurityService
    
    def emoticon = { attrs, body ->
       out << body() << (attrs.happy == 'true' ? " :-)" : " :-(")
    }
    
    def displayUserName = { attrs, body ->
    
        def output = ''
        
        try {
            def user = springSecurityService.currentUser
            
            def display =  user?.title
            
            output = display
            
        }
        catch (e) {
            log.error e.message
        }
            
        out << body() << output
    }

    def actionbar= {attrs, body ->

        def nextActionName

        if(attrs.actionName=="create" || attrs.actionName=="save")
            nextActionName="save";
        else if(attrs.actionName=="edit")
            nextActionName="update"
        else if(attrs.actionName=="show")
            nextActionName="edit"



        out << body() << render(template:'/component/actionbar'
            , model:[actionName:actionName, nextActionName:nextActionName ,domain:attrs?.domain])
    }

    def switchUser={attrs, body ->

        def currentUser = springSecurityService.currentUser

        def operators=[]
        if(currentUser?.store 
            && currentUser.getAuthorities().contains(motoranger.Role.findByAuthority('ROLE_MANERGER'))){

            def users=User.findAllByStore(springSecurityService?.currentUser?.store)

            users.each(){
                if(it.getAuthorities().contains(motoranger.Role.findByAuthority('ROLE_OPERATOR'))
                    && it != currentUser){
                    operators << it
                }

            }
            out << body() << render(template:'/component/swichUser'
            , model:[operators:operators])
        }else {
            out << body() << ""
        }
    }
    def footer={attrs, body ->

        def currentUser = springSecurityService.currentUser
        
        def store = currentUser?.store

        if(store){

            out << body() << g.applyLayout(name: "inc_footer_store", 
                model:[store: store])

        }else {
            out << body() << g.applyLayout(name: "inc_footer")
        }
    }

    def homeNav={ attrs, body ->
        def currentUser = springSecurityService.currentUser
        def store = currentUser?.store

        if(store){
            out << body() << link(controller:'home'){
                store.title+"<i>store</i>"
            }        
        }else {
            out << body() << link(controller:'home'){
                g.message(code:"store.navbar.label")+"<i>store</i>"
            }
        }   

    }

}
