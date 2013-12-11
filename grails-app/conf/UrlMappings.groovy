class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?/"{
			constraints {
				// apply constraints here
			}
		}

		"/" (controller: "home")
		"/store/$name" (controller: "store", action: "index")
		"/user/$name" (controller: "user", action: "index")
		"/user/list" (controller: "user", action: "list")
		"/user/create" (controller: "user", action: "create")
		
		"500"(view:'/error')

		// "500" (view: '/error500')
        //"500" (controller: 'error', action: 'serverError')
        
    // "404" (controller: 'error', action: 'notFound')

    "404"(view:'/notFound')



	}

}
