#/usr/bin/env bash
ip=$(ip addr show eth0 | grep "inet " | sed 's/^.*inet \([0-9.]\+\)\/.*$/\1/g')
echo $ip