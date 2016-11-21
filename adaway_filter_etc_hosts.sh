#!/bin/sh

#SYS_VAR
CURL=$(which curl)

#STATIC_VAR
HOSTS_PATH="/etc/hosts"

function deploy {
  echo "###BEGIN:ADAWAY" >> $HOSTS_PATH
  $CURL -L https://adaway.org/hosts.txt >> $HOSTS_PATH
  echo "###END:ADAWAY" >> $HOSTS_PATH
}

function remove {
  sed -i.bak '/^###BEGIN:ADAWAY/,/^###END:ADAWAY/d' $HOSTS_PATH
}

function upgrade {
  remove
  deploy
}

case "$1" in
	deploy)
	deploy &
		;;
	remove)
	remove
		;;
	upgrade)
	upgrade
		;;
	*)

	echo $"Usage: $0 {deploy|remove|upgrade}"
	exit 1
		;;
esac
