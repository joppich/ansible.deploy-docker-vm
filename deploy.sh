#!/bin/sh

function usage () {
    echo 'Usage:  '
    echo '    deploy.sh action'
    echo 'Actions:  '
    echo '    new : Clean up working directory and (re)deploy'
    echo '    update : Restart vm and rerun provisioning'
    echo '    clean : Clean up working directory'
}

function clean () {
    # Remove stale files if present
    vagrant halt
    vagrant destroy
    garbage='Vagrantfile env ansible-roles tmp'
    for i in $garbage; do
        if [ -e $i ]
        then
            rm -rf $i
        fi
    done
}

if [ $# == 0 ] || [ $# -gt 1 ]
then
    usage
    exit 1;
fi

if [ $1 == 'new' ]
then
    clean
    sh bootstrap.sh
    . env/bin/activate
    vagrant up
elif [ $1 == 'update' ]
then
    . env/bin/activate
    vagrant reload --provision
elif [ $1 == 'clean' ]
then
    clean
else
    usage
    exit 1;
fi

exit 0
