package extrails

class EventTagLib {
		static namespace = "event"
    def totalPrice = { attr, body ->
        def totalPrice= 0L
        attr.event.details.each(){ detail ->
          totalPrice+= detail.price
        }

        out << body() << totalPrice
    }
}
