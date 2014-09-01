# Makefile to deploy components
#

all:

install-kamailio-plugin:
	mkdir -p ~/.vim/plugin/kamailio
	cp plugin/kamailio/kamailio*.* ~/.vim/plugin/kamailio

rm-kamailio-plugin:
	rm -rf ~/.vim/plugin/kamailio
