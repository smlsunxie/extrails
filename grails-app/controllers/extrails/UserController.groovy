package extrails

class UserController extends grails.plugins.springsecurity.ui.UserController {

	def csvImport={

        try{
            def reader = grailsAttributes.getApplicationContext().getResource("/data/user.csv").getFile().toCsvMapReader([batchSize:50])
            
            reader.each{ batchList ->
                batchList.each{ map ->
                if(map?.password=="")map.password=map.username
                
                if(!User.findByUsername(map?.username))
                    new User(map).save(failOnError: true, flush: true)
                }
            }
                          
        }catch(Exception e){

        }
    }
}
