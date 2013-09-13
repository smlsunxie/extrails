package extrails



import org.junit.*
import grails.test.mixin.*

@TestFor(StoreCostDetailController)
@Mock(StoreCostDetail)
class StoreCostDetailControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/storeCostDetail/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.storeCostDetailInstanceList.size() == 0
        assert model.storeCostDetailInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.storeCostDetailInstance != null
    }

    void testSave() {
        controller.save()

        assert model.storeCostDetailInstance != null
        assert view == '/storeCostDetail/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/storeCostDetail/show/1'
        assert controller.flash.message != null
        assert StoreCostDetail.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/storeCostDetail/list'

        populateValidParams(params)
        def storeCostDetail = new StoreCostDetail(params)

        assert storeCostDetail.save() != null

        params.id = storeCostDetail.id

        def model = controller.show()

        assert model.storeCostDetailInstance == storeCostDetail
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/storeCostDetail/list'

        populateValidParams(params)
        def storeCostDetail = new StoreCostDetail(params)

        assert storeCostDetail.save() != null

        params.id = storeCostDetail.id

        def model = controller.edit()

        assert model.storeCostDetailInstance == storeCostDetail
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/storeCostDetail/list'

        response.reset()

        populateValidParams(params)
        def storeCostDetail = new StoreCostDetail(params)

        assert storeCostDetail.save() != null

        // test invalid parameters in update
        params.id = storeCostDetail.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/storeCostDetail/edit"
        assert model.storeCostDetailInstance != null

        storeCostDetail.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/storeCostDetail/show/$storeCostDetail.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        storeCostDetail.clearErrors()

        populateValidParams(params)
        params.id = storeCostDetail.id
        params.version = -1
        controller.update()

        assert view == "/storeCostDetail/edit"
        assert model.storeCostDetailInstance != null
        assert model.storeCostDetailInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/storeCostDetail/list'

        response.reset()

        populateValidParams(params)
        def storeCostDetail = new StoreCostDetail(params)

        assert storeCostDetail.save() != null
        assert StoreCostDetail.count() == 1

        params.id = storeCostDetail.id

        controller.delete()

        assert StoreCostDetail.count() == 0
        assert StoreCostDetail.get(storeCostDetail.id) == null
        assert response.redirectedUrl == '/storeCostDetail/list'
    }
}
