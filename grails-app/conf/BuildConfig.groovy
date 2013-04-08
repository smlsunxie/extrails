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

// Exclude files from a generated war
// grails.war.resources = { stagingDir, args ->
//     //delete (file: "${stagingDir}/WEB-INF/lib/hibernate-core-3.3.1.GA.jar")
//     delete { fileset(dir: "${stagingDir}/bootswatch", includes: '*') }
//     delete { fileset(dir: "${stagingDir}/swatchmaker", includes: '*') }
//     delete { fileset(dir: "${stagingDir}/font-awesome", includes: '*') }
//     delete { fileset(dir: "${stagingDir}/images", includes: '*.psd') }
//     delete { fileset(dir: "${stagingDir}/sass", includes: '*') }
//     delete { fileset(dir: "${stagingDir}/fancybox", includes: '*') }
// };

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
        compile 'org.imgscalr:imgscalr-lib:4.1' 
        runtime 'net.java.dev.jets3t:jets3t:0.9.0'
        runtime 'org.jsoup:jsoup:0.2.2'
        compile 'org.compass-project:compass:2.2.0' 

        // compile 'net.coobird:thumbnailator:0.4.2' 
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
        runtime ":yui-minify-resources:0.1.5"

        // 關閉 cache 相關 plugins 以利了解檔案配置
        runtime ":cached-resources:1.1"
        compile ':cache:1.0.1'
        compile ":cache-headers:1.1.5"





        // spring-security 相關
        compile ':spring-security-core:latest.release'
        compile ':spring-security-ui:latest.release'
        compile ':famfamfam:latest.release'


        // html 相關
        // compile ":closure-compiler:0.9.1"
        // runtime ":cors:1.0.3"
        // 上面兩個套件 test-app 造成: Error creating bean with name 'instanceTagLibraryApi': Injection of autowired dependencies failed
        

        runtime ':jquery-ui:latest.release'
        // runtime ":twitter-bootstrap:2.3.0"
        runtime ":browser-detection:0.4.3"
        runtime ":modernizr:2.6.2"
        runtime ":jquery:1.8.3"

        compile ":taggable:1.0.1"
        compile ":ajax-uploader:1.1"

        
        compile ":codenarc:0.18.1"


        compile ":create-domain-uml:0.5"
        compile ":csv:0.3.1"

        compile ":searchable:0.6.4"


        compile ":google-analytics:2.0"

        compile ":disqus:0.1"



    }
}
