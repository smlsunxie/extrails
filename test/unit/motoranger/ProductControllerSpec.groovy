package motoranger



import grails.test.mixin.*
import spock.lang.*

@TestFor(ProductController)
@Mock([Product, User, Event, UserService])
class ProductControllerSpec extends Specification {

    def setup(){
        UserService.metaClass.currentUser = {
            new User(username: "user")
        }
        ProductController.metaClass.searchSimilarProduct = { productInstance ->
            []
        }

    }

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        params["name"] = 'QQQ123'
        params["title"] = 'QQQ123'

    }

    void "Test the create action returns the correct model"() {
    	setup: "建立 model 變數"
        
        when:"The create action is executed"
            controller.create()
        then:"The model is correctly created"
            assert model.productInstance


        when:"建立 product 設定 name"
        	params.name = "prdouct"
            controller.create()

        then:"product 的 title 要跟 name 一樣"
            assert model.productInstance.title == params.name
            println model.productInstance
    }


    void "Test the save action correctly persists an instance"() {
    	// setup: "建立 model 變數"
    	// 	def model

        when:"The save action is executed with an invalid instance"
            def product = new Product(name: "product")
            product.validate()
            controller.save(product)

        then:"The create view is rendered again with the correct model"
            model.productInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            product = new Product(params)

            controller.save(product)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/product/show/1'
            controller.flash.message != null
            Product.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"redirect to /home/redirect"
            response.redirectedUrl == '/home/redirect'
            flash.message != null

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def product = new Product(params)
            controller.show(product)

        then:"A model is populated containing the domain instance"
            model.productInstance == product
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"redirect to /home/redirect"
            response.redirectedUrl == '/home/redirect'
            flash.message != null

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def product = new Product(params)
            controller.edit(product)

        then:"A model is populated containing the domain instance"
            model.productInstance == product
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"redirect to /home/redirect"
            response.redirectedUrl == '/home/redirect'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def product = new Product()
            product.validate()
            controller.update(product)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.productInstance == product

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            product = new Product(params).save(flush: true)
            controller.update(product)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/product/show/$product.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.delete(null)

        then:"redirect to /home/redirect"
            response.redirectedUrl == '/home/redirect'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def product = new Product(params).save(flush: true)

        then:"It exists"
            Product.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(product)

        then:"The instance is deleted"
            Product.count() == 0
            response.redirectedUrl == '/home/redirect'
            flash.message != null
    }
}
