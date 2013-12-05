def __bundleName = 'motoranger'

modules = {
    
    'jquery-plugins' {
        dependsOn 'jquery'
        
        resource url: 'jquery-plugins/jquery.migrate.min.js'
        resource url: 'jquery-plugins/jquery.textarea.js'
        resource url: 'jquery-plugins/jquery.jfontsize.js'
        resource url: 'jquery-plugins/jquery.cookie.js'
        resource url: 'jquery-plugins/jquery.masonry.js'
        resource url: 'jquery-plugins/jquery.lazyload.min.js'
    }


    common {
        dependsOn 'jquery, jquery-ui, jquery-plugins, pagedown'

        resource url: 'js/common.js'
    }

    application {
        dependsOn 'common'

        resource url: 'js/application.js'
    }

    ie6 {
        resource url: 'universal-ie6-css/ie6.1.0.css',
            wrapper: { s -> "<!--[if IE 6]>$s<![endif]-->" }
    }

    pagedown {
       
        //css
        resource url: 'pagedown/pagedown.css'
        
        
        //js
        resource url: 'pagedown/Markdown.Converter.js'
        resource url: 'pagedown/Markdown.Sanitizer.js'
        resource url: 'pagedown/Markdown.Editor.js'
    }

    
    'bootstrap-ext' {
        dependsOn 'bizstrap'

        resource url: 'bootstrap-ext/bootbox/bootbox.min.js'

        resource url: 'bootstrap-ext/datepicker/css/datepicker.css'
        resource url: 'bootstrap-ext/datepicker/js/bootstrap-datepicker.js'
    }
    
    'font-awesome' {
        dependsOn 'bizstrap'
        
        resource url: 'stylesheets/font-awesome.css'
        resource url: 'stylesheets/font-awesome-ie7.css',
            wrapper: { s -> "<!--[if lte IE 7]>$s<![endif]-->" }
    }
    

    tagit {
        dependsOn 'jquery, jquery-ui'
        resource url: 'tagit/css/jquery.tagit.css'
        resource url: 'tagit/css/tagit.ui-zendesk.css'

        resource url: 'tagit/js/tag-it.js'
    }

    compass {
        dependsOn 'bizstrap, tagit, fileuploader'
        
        resource url: 'stylesheets/screen.css'

    }

    bizstrap {   
        dependsOn 'jquery'     
        resource url: 'bizstrap/css/bootstrap.css'        
        resource url: 'bizstrap/rs-plugin/css/settings.css', attrs: [media: 'screen']
        resource url: 'bizstrap/css/rs-responsive.css', attrs: [media: 'screen']

        resource url: 'bizstrap/css/custom.css'
        resource url: 'bizstrap/css/isotope.css'
        resource url: 'bizstrap/css/color_scheme.css'
        resource url: 'bizstrap/css/flexslider.css'
        resource url: 'bizstrap/css/jquery.fancybox.css?v=2.1.0', attrs: [media: 'screen']


        resource url: 'bizstrap/js/bootstrap.js'  
        resource url: 'bizstrap/js/jquery.flexslider-min.js'
        resource url: 'bizstrap/js/jquery.isotope.js'
        resource url: 'bizstrap/js/jquery.fancybox.pack.js?v=2.1.0'        
        // resource url: 'bizstrap/rs-plugin/js/jquery.themepunch.plugins.min.js'
        // resource url: 'bizstrap/rs-plugin/js/jquery.themepunch.revolution.min.js'
        // resource url: 'bizstrap/js/revolution.custom.js'

        resource url: 'bizstrap/js/custom.js'

    }
    'ajax-uploader' {
        dependsOn 'jquery'
        resource url: 'css/uploader.css'
        resource url: 'js/fileuploader.js'  

    }


}
