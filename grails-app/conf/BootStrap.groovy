import extrails.*
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
                user1 = new User(username: 'admin', password: 'admin', title:'shadow',mobile:'0911111111', enabled: true, works: true).save(failOnError: true, flush: true)
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
                // if (!user3) {
                //     user3 = new User(username: 'clerk', password: 'clerk', enabled: true, works: true).save(failOnError: true, flush: true)
                //     UserRole.create(user3, role3)
                // }
                if (!user4) {
                    user4 = new User(username: 'customer', password: 'customer', enabled: true, works: true).save(failOnError: true, flush: true)
                    UserRole.create(user4, role4)
                }  

                def store1=new Store(title:'store1', name:'store1', address:'taipei', telphone:'2222222').save(flush:true, failonerror:true)

                user1.store=store1
                user1.save(flush:true, failOnError:true)

                def user5=new User(username: 'fat', password: 'fat', title: "小胖", enabled: true, works: true, store:store1).save(failOnError: true, flush: true)
                def user6=new User(username: 'bro', password: 'bro', title: "小弟", enabled: true, works: true).save(failOnError: true, flush: true)
                def user7=new User(username: 'tin', password: 'tin', title: "宗庭", enabled: true, works: true).save(failOnError: true, flush: true)
                def user8=new User(username: 'paul', password: 'paul', title: "保羅", enabled: true, works: true, store:store1).save(failOnError: true, flush: true)
                UserRole.create(user5, role3)
                UserRole.create(user6, role3)
                UserRole.create(user7, role3)
                UserRole.create(user8, role3)


                def p1 = new Product(name:'P12345',title:'P12345', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p2 = new Product(name:'P22345',title:'P22345', user:user8, years:new Date(), owner:extrails.ProductOwner.CUSTOMER).save(failOnError: true, flush: true)

                def p3 = new Product(name:'P1',title:'P1', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p4 = new Product(name:'P2',title:'P2', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p5 = new Product(name:'P3',title:'P3', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p6 = new Product(name:'P4',title:'P4', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p7 = new Product(name:'P5',title:'P5', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p8 = new Product(name:'P6',title:'P6', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p9 = new Product(name:'P7',title:'P7', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p10 = new Product(name:'P8',title:'P8', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p11 = new Product(name:'P9',title:'P9', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p12 = new Product(name:'P10',title:'P10', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                def p13 = new Product(name:'P11',title:'P11', user:user7, years:new Date(), mileage:1234L).save(failOnError: true, flush: true)
                

                def part1 = new Part(name:'part1', title:'part1', price:100L).save(failOnError: true, flush: true)
                part1.addTag("標準維修")

                def part2 = new Part(name:'part2', title:'part2', price:200L).save(failOnError: true, flush: true)
                part2.addTag("標準維修")

                def event1 = new Event(name:'event1', user:user7, product:p1, totalPrice:100L, date:new Date()).save(failOnError: true, flush: true)
                def eventDetail1= new EventDetail(name:'eventDetail1',part:part1, head:event1).save(failOnError: true, flush: true)

                def event2 = new Event(name:'event2', user:user7, product:p2, date:new Date(), status:extrails.ProductStatus.END).save(failOnError: true, flush: true)
                def eventDetail2= new EventDetail(name:'eventDetail2',part:part2, head:event1).save(failOnError: true, flush: true)




                def post = new Post(name:'post1', title:'post1', product:p1).save(failOnError: true, flush: true)




            }
        }
    }

    def destroy = {
    }
}
