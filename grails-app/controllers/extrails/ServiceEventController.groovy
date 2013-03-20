package extrails


import grails.plugins.springsecurity.Secured

class ServiceEventController {

	static layout="bootstrap"

    @Secured(['ROLE_MANERGER','ROLE_ADMIN','ROLE_CLERK'])
    def index() { 

    	def roleClerk = Role.findByAuthority('ROLE_CLERK')
    	log.info roleClerk
    	log.info UserRole.findAllByRole(roleClerk)
    	def clerks = UserRole.findAllByRole(roleClerk)*.user

    	log.info clerks

    	[
    		clerks:clerks
    	]

    }
}
