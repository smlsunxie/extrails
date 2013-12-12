package motoranger

import org.springframework.dao.DataIntegrityViolationException

class StoreController {

    static layout = 'bootstrap'
    def springSecurityService

    

    def show() {

        def currentUser = springSecurityService.currentUser
        def store = Store.findById(params.id)
        
        def unfinEvents= Event.findAllByStatusAndStore(motoranger.ProductStatus.UNFIN
            , store,[order:"desc",sort:"lastUpdated"])
        def endEvents= Event.findAllByStatusAndStore(motoranger.ProductStatus.END
            , store,[max:8,order:"desc",sort:"lastUpdated"])




        [
            unfinEvents: unfinEvents,
            endEvents: endEvents,
            store: store
        ]


    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [storeInstanceList: Store.list(params), storeInstanceTotal: Store.count()]
    }

    def create() {
        [storeInstance: new Store(params)]
    }

    def save() {
        def storeInstance = new Store(params)
        if (!storeInstance.save(flush: true)) {
            render(view: "create", model: [storeInstance: storeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'store.label', default: 'Store'), storeInstance.id])
        redirect(action: "show", id: storeInstance.id)
    }


    def edit(Long id) {
        def storeInstance = Store.get(id)
        if (!storeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'store.label', default: 'Store'), id])
            redirect(action: "list")
            return
        }

        [storeInstance: storeInstance]
    }

    def update(Long id, Long version) {
        println params
        def storeInstance = Store.get(id)
        if (!storeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'store.label', default: 'Store'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (storeInstance.version > version) {
                storeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'store.label', default: 'Store')] as Object[],
                          "Another user has updated this Store while you were editing")
                render(view: "edit", model: [storeInstance: storeInstance])
                return
            }
        }



        storeInstance.properties = params

        if (!storeInstance.save(flush: true)) {
            render(view: "edit", model: [storeInstance: storeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'store.label', default: 'Store'), storeInstance.id])
        redirect(action: "show", id: storeInstance.id)
    }

    def delete(Long id) {
        def storeInstance = Store.get(id)
        if (!storeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'store.label', default: 'Store'), id])
            redirect(action: "list")
            return
        }

        try {
            storeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'store.label', default: 'Store'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'store.label', default: 'Store'), id])
            redirect(action: "show", id: id)
        }
    }
}
