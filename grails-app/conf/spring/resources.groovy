import motoranger.*

beans = {
	userService(UserService){
		springSecurityService = ref("springSecurityService")
	}

	tagQueryService(TagQueryService){
		springSecurityService = ref("springSecurityService")
		userService = ref("userService")
	}
}
