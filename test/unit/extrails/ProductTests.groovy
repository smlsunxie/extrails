package extrails



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Product)
class ProductTests {

    void testEqualsAndHashCode() {
			def product=new Product( name:'a',
			title:'a',
			owner:extrails.ProductOwner.STORE,
			years:new Date())


      product.save()

      println product
    }
}
