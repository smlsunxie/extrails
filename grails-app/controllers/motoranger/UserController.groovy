package motoranger

import org.springframework.dao.DataIntegrityViolationException
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityUtils
class UserController {


    static layout = 'bootstrap'

    def springSecurityService
    def userService



    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    @Secured(['ROLE_CUSTOMER'])
    def create() {
        

        
        def user = new User(params)
        
        if(params?.product?.id){
            def product = Product.findById(params?.product?.id)
            user.username = product?.name
            user.title = product?.name
            user.password = product?.name 
        }



        user.enabled = true


        [userInstance: user,roles: Role.list(),storeList:storeList()]
    }

    @Secured(['ROLE_CUSTOMER'])
    def save() {
        def userInstance = User.findByUsername(params.username);
        
        if(!userInstance) userInstance = new User(params)



        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance,roles: Role.list()])
            return
        }

        // 登入使用者若屬於 ROLE_MANERGER 則進行  userRoles UserRole Update
        if(SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN")){
            userService.modifyUserRole(userInstance, params)

        }else {
            def cusRole = Role.findByAuthority('ROLE_CUSTOMER')
            UserRole.create(userInstance,cusRole,true)
        }

        if(params?.product?.id){
            userService.addProduct(userInstance, params)
            redirect(controller: "product", action: "show", id: params?.product?.id)
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    @Secured(['ROLE_CUSTOMER'])
    def show() {
        
        def user 

        if(params.id)
            user = User.get(params.id)
        else user = springSecurityService.currentUser


        if (!user) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), user.id])
            redirect(action: "list")
            return
        }

        [user: user, products: Product.findAllByUser(user)]
    }

    @Secured(['ROLE_CUSTOMER'])
    def edit() {

        def userInstance

        if(params.id)
            userInstance = User.get(params.id)
        else userInstance = springSecurityService.currentUser

        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
            redirect(action: "list")
            return
        }
        
        [userInstance: userInstance,roles: Role.list()
        ,userRoles:UserRole.findAllByUser(userInstance)
        ,storeList:storeList()]
    }

    @Secured(['ROLE_CUSTOMER'])
    def update() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version != null) {
            if (userInstance.version >params.version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }


        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        // 登入使用者若屬於 ROLE_MANERGER 則進行  userRoles UserRole Update
        if(SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN")){
            userService.modifyUserRole(userInstance, params)

        }

        if(params?.product?.id){
            userService.addProduct(userInstance, params)
            redirect(controller: "product", action: "show", id: params?.product?.id)
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }



    @Secured(['ROLE_CUSTOMER'])
    def delete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        try {
            def userRoleInstances=UserRole.findAllByUser(userInstance)

            userRoleInstances?.each(){
                it.delete()
            }

            def products = Product.findByUser(userInstance)

            products?.each(){
                products.user = null
                products.save()
            }

            userInstance.delete(flush: true,failOnError:true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            
            def currentUser = springSecurityService?.currentUser
            if(userInstance.id == currentUser?.id){
                redirect(action: "show", controller: "user", id: currentUser.id)
            }else {
                def store = currentUser.store
                redirect(action: "show", controller: "store", id: store.id)
            }

            
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "show", id: id)
        }
    }

    def storeList(){
        def storeList=[]
        if(SpringSecurityUtils.ifAnyGranted("ROLE_MANERGER") 
            && springSecurityService?.currentUser?.store){  
            
            storeList << springSecurityService.currentUser.store
        
        }else if(SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN"))
            storeList=Store.list()

        log.debug storeList
        return storeList
    }
}
