#remote_addr=192.168.0.107
remote_addr=motoranger.net
remote_user=spooky


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

upload:

	scp target/extrails.war ${remote_user}@${remote_addr}:~/extrails/target/ 
	scp ~/.grails/extrails-config.groovy ${remote_user}@${remote_addr}:~/.grails/


deploy:
	cp ~/.grails/extrails-config.groovy /usr/share/tomcat6/.grails/
	rm -rf /var/lib/tomcat6/webapps/ROOT.war
	rm -rf /var/lib/tomcat6/webapps/ROOT
	cp target/extrails.war /var/lib/tomcat6/webapps/ROOT.war
	service tomcat6 restart

log:
	tail -f /var/lib/tomcat6/logs/catalina.out

# upload-secret:
# 	s3cmd put ~/.grails/codecanaan-config.groovy s3://s3.lyhdev.com/apps/

# download:
# 	[ -d target ] || mkdir target
# 	wget -O target/codecanaan.war http://s3.lyhdev.com/apps/codecanaan.war

# download-secret:
# 	s3cmd get s3://s3.lyhdev.com/apps/codecanaan-config.groovy ~/.grails/codecanaan-config.groovy

remote-init:
	ssh -t ${remote_user}@${remote_addr} 'git clone git@github.com:smlsunxie/extrails.git'
	ssh -t ${remote_user}@${remote_addr} 'mkdir ~/extrails/target && mkdir ~/.grails'
	ssh -t ${remote_user}@${remote_addr} 'sudo mkdir -p /usr/share/tomcat6/.grails/projects/extrails/searchable-index/production/index/product && sudo chgrp -R tomcat6 /usr/share/tomcat6 && sudo chmod -R 770 /usr/share/tomcat6'


remote-dbinit:

	CREATE DATABASE extrails DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
	create user 'extrails'@'localhost' identified by 'mvagusta';
	grant all on *.* to 'extrails'@'localhost';
	

remote-deploy:
	ssh -t ${remote_user}@${remote_addr} 'cd extrails && make update && sudo make deploy'


remote-log:
	ssh -t ${remote_user}@${remote_addr} 'cd extrails && sudo make log'




syncdb:
	ssh -t ${remote_user}@${remote_addr} 'mysqldump --user=root -p extrails > ~/backup/extrails.sql'

recoverdb:
	mysql -u root -p extrails < extrails.sql

# services:
# 	mysqld_safe5 &
# 	rabbitmq-server &


done-remote:
	make clean war upload && make remote-deploy

done:
	make update clean war && sudo make deploy

loglink:
	- mkdir ~/Library/Logs/extrails
	- touch target/development.log
	- touch target/test.log
	- touch target/grails.log
	- touch target/root.log
	- touch target/stacktrace.log
	- ln ~/projects/extrails/target/development.log ~/Library/Logs/extrails/development.log
	- ln ~/projects/extrails/target/grails.log ~/Library/Logs/extrails/grails.log
	- ln ~/projects/extrails/target/root.log ~/Library/Logs/extrails/root.log
	- ln ~/projects/extrails/target/stacktrace.log ~/Library/Logs/extrails/stacktrace.log
	- ln ~/projects/extrails/target/test.log ~/Library/Logs/extrails/test.log

