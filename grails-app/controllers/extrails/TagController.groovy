package extrails
import org.grails.taggable.Tag

import grails.converters.JSON

class TagController {

    def listAsJson = {
        render Tag.findAllByNameIlike("${params.term}%").name as JSON
    }
}
