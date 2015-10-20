#!/usr/bin/env bash
# wrapper script for docker-machine so this all can work on OSX

set -e

DOCKER_MACHINE_NAME=default
PORTS="3030 8080"

# this only matters on OSX
[[ $(uname -s ) = "Darwin" ]] || exit 0

echo "OSX detected, proceeding with docker-machine"

if [[ $(docker-machine status "$DOCKER_MACHINE_NAME") = "Stopped" ]]; then
  docker-machine start "$DOCKER_MACHINE_NAME"
fi

eval $(docker-machine env "$DOCKER_MACHINE_NAME")

for PORT in $PORTS; do
  if VBoxManage showvminfo "$DOCKER_MACHINE_NAME" --machinereadable | grep -q "tcp-port$PORT"; then
    echo "Port $PORT already mapped"
  else
    echo "Mapping $PORT..."
    VBoxManage controlvm default natpf1 "tcp-port$PORT,tcp,,$PORT,,$PORT"
  fi
done

if ! VBoxManage showvminfo $DOCKER_MACHINE_NAME --machinereadable | grep SharedFolderName | grep -q '="Volumes"$'; then
  echo "Adding /Volumes shared folder"
  VBoxManage sharedfolder add $DOCKER_MACHINE_NAME --name Volumes --hostpath /Volumes --automount
fi
docker-machine ssh $DOCKER_MACHINE_NAME 'sudo ntpclient -s -h pool.ntp.org'
docker-machine ssh $DOCKER_MACHINE_NAME 'sudo mkdir -p /Volumes ; sudo  mount -t vboxsf Volumes /Volumes'

VBoxManage guestproperty set $DOCKER_MACHINE_NAME "/VirtualBox/GuestAdd/VBoxService/--timesync-set-on-restore" 1
VBoxManage guestproperty set $DOCKER_MACHINE_NAME "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold" 1000
VBoxManage guestproperty set $DOCKER_MACHINE_NAME "/VirtualBox/GuestAdd/VBoxService/--timesync-interval" 10000
VBoxManage guestproperty set $DOCKER_MACHINE_NAME "/VirtualBox/GuestAdd/VBoxService/--timesync-min-adjust" 100
