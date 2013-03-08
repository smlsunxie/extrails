package extrails



import grails.test.mixin.*
import org.junit.*
import org.grails.taggable.Tag
/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Post)
class PostTests {

    void testAddPost() {

       def post1=new Post(name:'news', title:'newes',type:PostType.DEMO).save(flush:true,failOnError:true)
       def post2=new Post(name:'demo', title:'demo',type:PostType.DEMO).save(flush:true)

       assert Post.list().size()==2
    }
}
