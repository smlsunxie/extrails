package motoranger

class UserService {
	def springSecurityService

    def addProduct(userInstance, params){
    	def product = Product.findById(params?.product?.id)

        product.user=userInstance
        product.save(failOnError: true)

    }

    def modifyUserRole(userInstance, params){
	    def defRoles = Role.list()*.authority;
        def userRoleParams = params.list('userRoles');

        defRoles.each(){ defRole ->
        
            def addRoule =false;
            userRoleParams.each(){ userRole ->
                if(userRole == defRole){
                    addRoule = true;
                }
            }

            def roleInstance = Role.findByAuthority(defRole)
            def userRoleInstance = UserRole.get(userInstance?.id,roleInstance?.id)

            if(addRoule && !userRoleInstance){
                UserRole.create(userInstance,roleInstance,true)
            }else if(!addRoule && userRoleInstance) {
                UserRole.remove(userInstance,roleInstance)
            }
        }
    }

    def currentUserIsCustomer(){
        def currentUser = springSecurityService.currentUser
        def isCusRole =false
        def authorities = currentUser?.getAuthorities()

        if(currentUser && authorities.contains(motoranger.Role.findByAuthority('ROLE_CUSTOMER'))
            && !authorities.contains(motoranger.Role.findByAuthority('ROLE_OPERATOR'))
            && !authorities.contains(motoranger.Role.findByAuthority('ROLE_MANERGER')))
            isCusRole = true

        return isCusRole
    }

    def currentUserIsOperator(){
        def currentUser = springSecurityService?.currentUser
        def isOperatorRole =false

        if(currentUser && currentUser.getAuthorities().contains(motoranger.Role.findByAuthority('ROLE_OPERATOR')))
            isOperatorRole = true

        return isOperatorRole
    }

}
