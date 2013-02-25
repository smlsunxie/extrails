import extrails.User
import extrails.Role
import extrails.UserRole

class BootStrap {

    def init = { servletContext ->

        //基本權限
        environments {

            def role1 = Role.findOrSaveByAuthority('ROLE_USER')
            //def role2 = Role.findOrSaveByAuthority('ROLE_FACEBOOK')
            def role3 = Role.findOrSaveByAuthority('ROLE_ADMIN')
            
            //create administrator
            def user1 = User.findByUsername('admin')


            if (!user1) {
                user1 = new User(username: 'admin', password: 'admin', enabled: true, works: true).save(failOnError: true, flush: true)
                //join roles
                UserRole.create(user1, role1)
                //UserRole.create(user1, role2)
                UserRole.create(user1, role3)
            }

            production {
                //empty
            }
            
            development {
                def user2 = new User(username: 'user', password: 'user', enabled: true).save(failOnError: true, flush: true)
            }
        }
    }

    def destroy = {
    }
}
