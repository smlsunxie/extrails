// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

// Externalized Configuration: Secure Passwords in private config file or without reatart configuation
grails.config.locations = [
	"file:${userHome}/.grails/${appName}-config.groovy"
]

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
	all:           '*/*',
	atom:          'application/atom+xml',
	css:           'text/css',
	csv:           'text/csv',
	form:          'application/x-www-form-urlencoded',
	html:          ['text/html','application/xhtml+xml'],
	js:            'text/javascript',
	json:          ['application/json', 'text/json'],
	multipartForm: 'multipart/form-data',
	rss:           'application/rss+xml',
	text:          'text/plain',
	xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']
grails.resources.bundle.excludes = ['**/*.less']

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

environments {
	development {
		grails.logging.jul.usebridge = true
		// grails.serverURL = "http://dev.extrails:8080"
		
		//disable resource path hash ?_debugResources=y
		grails.resource.debug = true
		grails.resources.mapper.hashandcache.excludes = ['**/*']
	
		// Don't enable CDN for development
		grails.resources.mappers.baseurl.enabled = false

		// Don't enable cached-resources
		//grails.resources.mappers.
		//grails.resources.mapper.hashandcache.excludes = ['**/*']
		grails.resources.mapper.cached.excludes = ['**/*']
		upload.files.path="${userHome}/appData/${appName}/uploadfiles"

		//grails.resources.debug = true 
	}
	test {
		// dirty fix "Cannot create a bundle from resource" warning
		grails.resources.mappers.bundle.excludes = ['**/*'] 
	}
	production {
	
		grails.logging.jul.usebridge = false
		grails.serverURL = "http://extrails.com"
		//grails.serverURL = "http://dev.codecanaan.com:8080"

		// Using baseurl feature to enable CDN deployment
		grails.resources.mappers.baseurl.enabled = true
		upload.files.path="${userHome}/appData/${appName}/uploadfiles"

		//grails.resources.mappers.baseurl.enabled = false
		//grails.resources.mappers.baseurl.default = "http://static.extrails.com/static"

		//This not works
		//grails.resources.mappers.baseurl.excludes = ['biwascheme/*']
	}
}

// log4j configuration
// log4j configuration
log4j = {
	// Example of changing the log pattern for the default console appender:
	//
	appenders {
		console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
	}

	info "grails.app"

	debug 'extrails'
	
	// //SpringSecurity Facebook
	// debug   'com.the6hours', 'grails.app.taglib.com.the6hours'
	
	error  'org.codehaus.groovy.grails.web.servlet',        // controllers
		   'org.codehaus.groovy.grails.web.pages',          // GSP
		   'org.codehaus.groovy.grails.web.sitemesh',       // layouts
		   'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
		   'org.codehaus.groovy.grails.web.mapping',        // URL mapping
		   'org.codehaus.groovy.grails.commons',            // core / classloading
		   'org.codehaus.groovy.grails.plugins',            // plugins
		   'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
		   'org.springframework',
		   'org.hibernate',
		   'net.sf.ehcache.hibernate'
}

//The default level is SIMPLE_OPTIMIZATIONS, options ADVANCED_OPTIMIZATIONS
// grails.resources.mappers.googleclosurecompiler.compilation_level='SIMPLE_OPTIMIZATIONS'

// Twitter Bootstrap
grails.plugins.twitterbootstrap.fixtaglib = true

// Bundle all resources to extrails
grails.plugins.twitterbootstrap.defaultBundle = 'extrails'

// JustFont
// grails.justfont.appId = '04a33145MnLiu8AI4KNCkfQQX18d_e3RX0f8GVpfG1diW5LYhaoiIuChsq61MXXmmv1-DTv5O0x8Q-M6wDVACDJxtEeI-_zEH2erPVBnvn_O0rNYUxTAysJ7bMYsPVRNRtxxKcR7LU_kpdARwG4Q_xXHkyzrSTEhAPHewUyTug7fj48gBxY='

// Analytics
// grails.analytics.account = 'UA-298440-14'
// grails.analytics.domainName = 'codecanaan.com'

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'extrails.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'extrails.UserRole'
grails.plugins.springsecurity.authority.className = 'extrails.Role'

// 動態定義 securityConfig by map in db
// grails.plugins.springsecurity.securityConfigType = "Requestmap"
// grails.plugins.springsecurity.requestMap.className = 'extrails.SecurityMap'


grails.plugins.springsecurity.useSwitchUserFilter = true
grails.plugins.springsecurity.controllerAnnotations.staticRules = [
	'/j_spring_security_switch_user': ['ROLE_ADMIN'],
	'/securityInfo/*': ['ROLE_ADMIN'],
	'/registrationCode/*': ['ROLE_ADMIN'],
	'/persistentLogin/*': ['ROLE_ADMIN'],
	'/role/*': ['ROLE_ADMIN'],
	'/user/search': ['ROLE_ADMIN']
]

grails.plugins.springsecurity.rememberMe.alwaysRemember = true
grails.plugins.springsecurity.rememberMe.persistent = true
grails.plugins.springsecurity.rememberMe.persistentToken.domainClassName = 'extrails.PersistentLogin'



//SpringSecurity Facebook
// grails.plugins.springsecurity.facebook.permissions='email,user_about_me'
// grails.plugins.springsecurity.facebook.filter.type='redirect'
// grails.plugins.springsecurity.facebook.domain.classname='codecanaan.FacebookUser'
// grails.plugins.springsecurity.facebook.appId='--appid--'
// grails.plugins.springsecurity.facebook.secret='--secret--'

// google {
//     adsense.adClient = 'ca-pub-0839975967683137'
// }

// aws {
//     //domain="s3.amazonaws.com"
//     domain="s3.amazonaws.com"
//     accessKey="-accessKey-"
//     secretKey="-secretKey-"
//     bucketName="secure.codecanaan.com"
// }

// grails {
//     mail {
//         host = "smtp.gmail.com"
//         port = 465
//         username = "youracount@gmail.com"
//         password = "yourpassword"
//         props = [
//             "mail.smtp.auth":                   "true",
//             "mail.smtp.socketFactory.port":     "465",
//             "mail.smtp.socketFactory.class":    "javax.net.ssl.SSLSocketFactory",
//             "mail.smtp.socketFactory.fallback": "false"
//         ]
//     }
// }


