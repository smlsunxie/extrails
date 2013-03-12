server:
#	export GRAILS_OPTS="-XX:MaxPermSize=1024m -Xmx1024M -server"
	grails run-app

assets:
	compass compile web-app
	mkdir -p web-app/font
	cp web-app/font-awesome/font/* web-app/font
	lessc --yui-compress web-app/font-awesome/less/font-awesome.less web-app/stylesheets/font-awesome.css
	lessc --yui-compress web-app/font-awesome/less/font-awesome-ie7.less web-app/stylesheets/font-awesome-ie7.css
	#lessc --yui-compress web-app/swatchmaker/swatchmaker.less > web-app/stylesheets/bootstrap.min.css
	#lessc --yui-compress web-app/swatchmaker/swatchmaker-responsive.less > web-app/stylesheets/bootstrap-responsive.min.css

commit:
	git commit . -m 'development update'
	git push

update:
	git pull

clean:
	grails clean

clean-cache:
	rm -rf ./web-app/.sass-cache

war:
	grails war

submoduleInstall:
	git submodule init
	git submodule update

update:
	git pull

upload:
	scp target/extrails.war spooky@106.187.54.84:~/extrails/target 
	scp ~/.grails/extrails-config.groovy spooky@106.187.54.84:~/.grails

# upload-secret:
# 	s3cmd put ~/.grails/codecanaan-config.groovy s3://s3.lyhdev.com/apps/

# download:
# 	[ -d target ] || mkdir target
# 	wget -O target/codecanaan.war http://s3.lyhdev.com/apps/codecanaan.war

# download-secret:
# 	s3cmd get s3://s3.lyhdev.com/apps/codecanaan-config.groovy ~/.grails/codecanaan-config.groovy



remote-deploy:
	ssh -t spooky@106.187.54.84 'cd extrails && make update && sudo make deploy'

# remote-log:
# 	ssh -t kyle@codecanaan.com 'cd codecanaan && make log'

deploy:
	rm -rf /var/lib/tomcat7/webapps/ROOT.war
	rm -rf /var/lib/tomcat7/webapps/ROOT
	cp target/extrails.war /var/lib/tomcat7/webapps/ROOT.war
	service tomcat7 restart

log:
	tail -f /var/lib/tomcat7/logs/catalina.out

# syncdb:
# 	mysqldump -h codecanaan.com -usynconly -p contpub | mysql -h localhost -ucontpub -pcontpub contpub

# services:
# 	mysqld_safe5 &
# 	rabbitmq-server &


done:
	make clean war upload && make remote-deploy
