import extrails.User
import extrails.Role
import extrails.UserRole
import extrails.SecurityMap
import extrails.Post
import extrails.Product
import extrails.Part
import extrails.ProductOwner
import org.grails.taggable.Tag

class BootStrap {

    def init = { servletContext ->

        //基本權限
        environments {

            //def role2 = Role.findOrSaveByAuthority('ROLE_FACEBOOK')
            def role1 = Role.findOrSaveByAuthority('ROLE_ADMIN')
            def role2 = Role.findOrSaveByAuthority('ROLE_MANERGER')
            def role3 = Role.findOrSaveByAuthority('ROLE_OPERATOR')
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


                def p1 = new Product(name:'P12345',title:'P12345', years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p2 = new Product(name:'P22345',title:'P22345', years:new Date(), owner:extrails.ProductOwner.CUSTOMER).save(failOnError: true, flush: true)

                def part1 = new Part(name:'part1', title:'part1', price:100L).save(failOnError: true, flush: true)
                part1.addTag("標準維修")
                def part2 = new Part(name:'part2', title:'part2', price:200L).save(failOnError: true, flush: true)
                part2.addTag("標準維修")

                def post = new Post(name:'post1', title:'post1', product:p1).save(failOnError: true, flush: true)


                def user5=new User(username: 'fat', password: 'fat', title: "小胖", enabled: true, works: true).save(failOnError: true, flush: true)
                def user6=new User(username: 'bro', password: 'bro', title: "小弟", enabled: true, works: true).save(failOnError: true, flush: true)
                def user7=new User(username: 'tin', password: 'tin', title: "宗庭", enabled: true, works: true).save(failOnError: true, flush: true)
                def user8=new User(username: 'paul', password: 'paul', title: "保羅", enabled: true, works: true).save(failOnError: true, flush: true)
                UserRole.create(user5, role3)
                UserRole.create(user6, role3)
                UserRole.create(user7, role3)
                UserRole.create(user8, role3)

            }
        }
    }

    def destroy = {
    }
}
