package extrails

class EventTransationService {

    def eventCreateUpdate(event) {
        event.merge(flush: true)
        event=Event.findByName(params.name)

    }
}
