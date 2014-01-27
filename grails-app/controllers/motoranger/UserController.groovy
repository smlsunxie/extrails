package motoranger

import org.springframework.dao.DataIntegrityViolationException
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.transaction.annotation.*
class UserController {


    static layout = 'bootstrap'
    def userService


    @Secured(['ROLE_ADMIN'])
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    def create() {
        

        
        def user = new User(params)
        
        if(params?.product?.id){
            def product = Product.findById(params?.product?.id)
            user.username = product?.name
            user.title = product?.name
            user.password = product?.name 
        }


        if(userService.isLoggedIn() && (userService.isOperator() || userService.isManerger()))
            user.enabled = false
        else user.enabled = true


        [userInstance: user,roles: Role.list(),storeList:storeList()]
    }

    @Transactional
    def save() {
        def userInstance 
        if(userService.isOperator() || userService.isManerger())
            userInstance = User.findByUsername(params.username)
        
        if(!userInstance) userInstance = new User(params)





        if (!userInstance.validate()) {
            render(view: "create", model: [userInstance: userInstance,roles: Role.list()])
            return
        }

        if(!userService.isLoggedIn() && !userInstance?.email ){
            flash.message = "請輸入 email"
            render(view: "create", model: [userInstance: userInstance,roles: Role.list()])
            return            
        }

        if(userInstance.store){

            Store store = userInstance.store

            store.addToUsers(userInstance).save()
        }


        userInstance.save(flush: true)
        // 登入使用者若屬於 ROLE_MANERGER 則進行  userRoles UserRole Update
        if(userService.isAdmin()){
            userService.modifyUserRole(userInstance, params)

        }else {
            def cusRole = Role.findByAuthority('ROLE_CUSTOMER')

            if(!UserRole.get(userInstance?.id, cusRole.id))
                UserRole.create(userInstance,cusRole,true)
        }


        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance])


        if(params?.product?.id){
            userService.addProduct(userInstance, params)
            redirect(controller: "product", action: "show", id: params?.product?.id)
            return
        }else if(params?.store?.id){
            if(userService.isAdmin() || userService.isManerger()){
                redirect(action: "addToStore", id: userInstance.id, params:['store.id': params.store.id])
                return
            }else {
                flash.message+= "：沒有權限將使用者加入店家"
            }
        }

        if(userService.isLoggedIn()){
            redirect(action: "show", id: userInstance.id)
        }else {
            flash.message = flash.message + "可以開始登入使用！"
            redirect(action: "auth", controller:"login")
        }
    }
    
    def show() {
        
        if(params?.tour){
            session.tourStep=TourStep.STEP1_START
        }

        def user 

        if(params.id)
            user = User.get(params.id)
        else user = userService.currentUser()


        if (!user) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), user])
            redirect(action: "list")
            return
        }

        [user: user, products: Product.findAllByUser(user)]
    }

    def edit() {

        def userInstance

        if(params.id)
            userInstance = User.get(params.id)
        else userInstance = userService.currentUser()

        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), userInstance])
            redirect(action: "list")
            return
        }
        
        [userInstance: userInstance,roles: Role.list()
        ,userRoles:UserRole.findAllByUser(userInstance)
        ,storeList:storeList()]
    }

    def update() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), userInstance])
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

        if (!userInstance.validate()) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        userInstance.save(flush: true)
        // 登入使用者若屬於 ROLE_MANERGER 則進行  userRoles UserRole Update
        if(userService.isAdmin()){
            userService.modifyUserRole(userInstance, params)

        }

        if(params?.product?.id){
            userService.addProduct(userInstance, params)
            redirect(controller: "product", action: "show", id: params?.product?.id)
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance])
        redirect(action: "show", id: userInstance.id)
    }



    @Transactional
    def delete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), userInstance])
            redirect(action: "list")
            return
        }

        try {
            def userRoleInstances=UserRole.findAllByUser(userInstance)

            userRoleInstances?.each(){
                it.delete()
            }

            def products = Product.findAllByUser(userInstance)

            products?.each(){ product ->
                product.user = null
                product.save()
            }

            def parts = Part.findAllByUser(userInstance)

            parts.each(){ part ->
                if(EventDetail.findByPart(part)){
                    part.user = null
                    part.save()
                }else {
                    part.delete(flush: true,failOnError:true)
                }

            }

            userInstance.delete(flush: true,failOnError:true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), userInstance])
            
            def currentUser = userService.currentUser()

            if(!currentUser){
                redirect(url: '/j_spring_security_logout')
                return 
            }

            redirect(action: "index", controller: "home")

            
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), userInstance])
            redirect(action: "show", id: id)
        }
    }
    @Secured(['ROLE_MANERGER', 'ROLE_ADMIN'])
    def addToStore(){
        def currentUser = userService.currentUser()
        def user = User.get(params.id)
        def store = Store.get(currentUser.store.id)

        if(user?.store && user.store != store){
            flash.message = "此使用者已屬於「user.store」"
            redirect(action: "show", id: params.id)
            return
        }


        def admRole = Role.findByAuthority('ROLE_ADMIN')
        def mngRole = Role.findByAuthority('ROLE_MANERGER')

        if(UserRole.get(user.id, admRole.id) || UserRole.get(user.id, mngRole.id)){
            flash.message = "不可指派「${admRole}」或「${mngRole}」為作業員"
            redirect(action: "show", id: params.id)
            return    
        }

        store.addToUsers(user).save()

        def opRole = Role.findByAuthority('ROLE_OPERATOR')
        if(!UserRole.get(user?.id, opRole.id))
                UserRole.create(user,opRole,true)

        def cusRole = Role.findByAuthority('ROLE_CUSTOMER')
        if(UserRole.get(user?.id, cusRole.id))
            UserRole.remove(user,cusRole)             

        user.enabled=true

        user.save()

        flash.message="${flash?.message ? flash.message: ''}:指定「${user}」為「${store}」作業員"

        redirect action: "show", id: user.id

    }

    private def storeList(){
        def storeList=[]
        if(userService.isAdmin()){
            storeList=Store.list()
        }else if(userService.isManerger() 
            && userService.currentUser()?.store){  
            
            storeList << userService.currentUser().store
        
        }
        return storeList
    }
}
