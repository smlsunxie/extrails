import extrails.User
import extrails.Role
import extrails.UserRole
import extrails.SecurityMap
import extrails.Post
import extrails.Product
import org.grails.taggable.Tag

class BootStrap {

    def init = { servletContext ->

        //基本權限
        environments {

            //def role2 = Role.findOrSaveByAuthority('ROLE_FACEBOOK')
            def role1 = Role.findOrSaveByAuthority('ROLE_ADMIN')
            def role2 = Role.findOrSaveByAuthority('ROLE_MANERGER')
            def role3 = Role.findOrSaveByAuthority('ROLE_CLERK')
            def role4 = Role.findOrSaveByAuthority('ROLE_CUSTOMER')

            //create administrator
            def user1 = User.findByUsername('admin')


            // 動態定義 securityConfig by map in db 
            // new SecurityMap(url: '/securityInfo/config',
            //    configAttribute: 'ROLE_ADMIN').save(failOnError: true, flush: true)


            if (!user1) {
                user1 = new User(username: 'admin', password: 'admin', enabled: true, works: true).save(failOnError: true, flush: true)
                //join roles
                UserRole.create(user1, role1)
                UserRole.create(user1, role2)
                UserRole.create(user1, role3)
                UserRole.create(user1, role4)

            }



         

            // def defTags=['YAMAHA','KYMCO','SYM','SUZUKI','UNIVERSAL']

            // defTags.each{ tagName ->

            //     if(!Tag.findByName(tagName)){
            //         new Tag(name:tagName).save(failOnError: true, flush: true)
            //     }
            // }




            // def newsPost=new Post(name:'news', title:'新聞');
            // newsPost.addTag("news");

            // def abouts=new Post(name:'abouts', title:'關於我們');
            // abouts.addTag("abouts");

            production {
                //empty
            }
            
            development {
                def user2 = User.findByUsername('manager')
                def user3 = User.findByUsername('clerk')
                def user4 = User.findByUsername('customer')
                if (!user2) {
                    user2 = new User(username: 'manager', password: 'manager', enabled: true, works: true).save(failOnError: true, flush: true)
                    UserRole.create(user2, role2)
                }
                if (!user3) {
                    user3 = new User(username: 'clerk', password: 'clerk', enabled: true, works: true).save(failOnError: true, flush: true)
                    UserRole.create(user3, role3)
                }
                if (!user4) {
                    user4 = new User(username: 'customer', password: 'customer', enabled: true, works: true).save(failOnError: true, flush: true)
                    UserRole.create(user4, role4)
                }  


                new Product(name:'p1',title:'p1', years:new Date()).save(failOnError: true, flush: true)
                new Product(name:'p2',title:'p2', years:new Date()).save(failOnError: true, flush: true)

                new User(username: 'fat', password: 'fat', title: "小胖", enabled: true, works: true).save(failOnError: true, flush: true)
                new User(username: 'bro', password: 'bro', title: "小弟", enabled: true, works: true).save(failOnError: true, flush: true)
                new User(username: 'tin', password: 'tin', title: "宗庭", enabled: true, works: true).save(failOnError: true, flush: true)


            }
        }
    }

    def destroy = {
    }
}
