import extrails.*
import org.grails.taggable.Tag

class BootStrap {

    def init = { servletContext ->

        //基本權限
        environments {

            //def role2 = Role.findOrSaveByAuthority('ROLE_FACEBOOK')
            def ruleAdmain = Role.findOrSaveByAuthority('ROLE_ADMIN')
            def ruleManager = Role.findOrSaveByAuthority('ROLE_MANERGER')
            def ruleOper = Role.findOrSaveByAuthority('ROLE_OPERATOR')
            def ruleCus = Role.findOrSaveByAuthority('ROLE_CUSTOMER')

            //create administrator
            def userAdmin = User.findByUsername('admin')


            // 動態定義 securityConfig by map in db 
            // new SecurityMap(url: '/securityInfo/config',
            //    configAttribute: 'ROLE_ADMIN').save(failOnError: true, flush: true)


            if (!userAdmin) {
                userAdmin = new User(username: 'admin', password: 'admin', title:'超級使用者',mobile:'0911111111', enabled: true, works: true).save(failOnError: true, flush: true)
                //join roles
                UserRole.create(userAdmin, ruleAdmain)
                UserRole.create(userAdmin, ruleManager)
                UserRole.create(userAdmin, ruleOper)
                UserRole.create(userAdmin, ruleCus)

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


                def store1=new Store(title:'勝祥機車行', name:'store1', address:'台北市汀州路一段 354 號', telphone:'0223033926').save(flush:true, failonerror:true)

                userAdmin.store=store1
                userAdmin.save(flush:true, failOnError:true)

                def user4 = new User(username: 'smlsun', password: '1', title:'宗穎', enabled: true, store:store1).save(failOnError: true, flush: true)
                def user5 = new User(username: 'fat', password: '1', title: "小胖", enabled: true, store:store1).save(failOnError: true, flush: true)
                def user6 = new User(username: 'bro', password: '1', title: "小弟", enabled: true, store:store1).save(failOnError: true, flush: true)
                def user7 = new User(username: 'tin', password: '1', title: "宗庭", enabled: true, store:store1).save(failOnError: true, flush: true)
                def user8 = new User(username: 'paul', password: '1', title: "保羅", enabled: true, store:store1).save(failOnError: true, flush: true)
                
                UserRole.create(user4, ruleAdmain)
                UserRole.create(user4, ruleOper)
                UserRole.create(user5, ruleOper)
                UserRole.create(user6, ruleOper)
                UserRole.create(user7, ruleOper)
                UserRole.create(user8, ruleManager)


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
