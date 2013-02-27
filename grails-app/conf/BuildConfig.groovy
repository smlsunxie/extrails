grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
grails.project.war.file = "target/${appName}.war"
//grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
//grails.project.fork = [
//   run: [maxMemory:1024, minMemory:64, debug:false, maxPerm:256]
//]

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenLocal()
        mavenCentral()

        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.

        runtime 'mysql:mysql-connector-java:5.1.22'
    }

    plugins {
        runtime ":hibernate:$grailsVersion"
        build ":tomcat:$grailsVersion"
        runtime ":database-migration:1.2.1"
        compile ':mail:latest.release'
        compile ":webxml:1.4.1"

        //resources 優化管理相關
        runtime ":resources:1.2.RC3"
        // Uncomment these (or add new ones) to enable additional resources capabilities
        runtime ":zipped-resources:1.0.1"
        //runtime ":yui-minify-resources:0.1.4"

        // 關閉 cache 相關 plugins 以利了解檔案配置
        // runtime ":cached-resources:1.1"
        // compile ':cache:1.0.1'
        // compile ":cache-headers:1.1.5"





        // spring-security 相關
        compile ':spring-security-core:latest.release'
        compile ':spring-security-ui:latest.release'
        compile ':famfamfam:latest.release'


        // html 相關
        compile ":closure-compiler:0.9.1"
        compile ':jquery-ui:latest.release'
        compile ":twitter-bootstrap:2.3.0"
        compile ":browser-detection:0.4.3"
        runtime ":modernizr:2.6.2"
        runtime ":jquery:1.8.3"
    }
}
