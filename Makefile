build:
	docker build -t voronenko/nas-backup:latest .
push:
	docker push voronenko/nas-backup:latest
# https://vorta.borgbase.com/
install-borg-ui-vorta:
	pip3 install vorta
install-borg-borgmatic:
	pip3 install --upgrade ntfy[pid,emoji,xmpp,telegram,instapush,slack,rocketchat]
	pip3 install --upgrade borgmatic
down:
	docker-compose down -v
