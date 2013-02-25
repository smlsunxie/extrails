package extrails

class CommonTagLib {
    def justfont = { attr, body ->
        if (attr.force) {
            out << render(template: '/taglib/justfont_force')
        }
        else {
            out << render(template: '/taglib/justfont')
        }
    }
    
    /**
     * CodeMirror Syntax Mode
     */
    def cmmode = { attr, body ->
        if (attr && attr.type) {
            if (attr.type.toString().toLowerCase()=='scheme') {
                out << 'text/x-scheme'
            }
            else if (attr.type.toString().toLowerCase()=='html') {
                out << 'text/html'
            }
            else {
                out << 'text/x-csrc'
            }
        }
    }

	def compact = { attr, body ->
		def c = body()?.trim()

		if (c) {
			c = (c =~ /\n+/).replaceAll('\n')
		}

		out << c
	}
}
