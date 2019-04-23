#!/bin/bash
# Show colored output if running interactively
if [ -t 1 ] ; then
    export ANSIBLE_FORCE_COLOR=true
fi
# Log everything from this script into _rhhi.log
echo "$0 $@" > _rhhi.log
exec &> >(tee -i -a _rhhi.log )

export DEV_SCRIPTS_DIR=./
source $DEV_SCRIPTS_DIR/ansible_ssh_env.sh

# With LANG set to everything else than C completely undercipherable errors
# like "file not found" and decoding errors will start to appear during scripts
# or even ansible modules
LANG=C

DEFAULT_OPT_TAGS=""

: ${OPT_WORKDIR:=~/.rhhi}

if [ "$#" -lt 1 ]; then
    if [ "${VIRTHOST:-}" == "" ]; then
        echo "ERROR: You didn't specify a target machine and VIRTHOST is not defined" >&2
#        usage >&2
        exit 2
    else
        echo "NOTICE: Using VIRTHOST=$VIRTHOST as target machine" >&2
    fi
else
    VIRTHOST=$1
fi

#mkdir $OPT_WORKDIR

ansible-playbook -vvvvvv \
    -e virthost=$VIRTHOST \
    -e local_working_dir=$OPT_WORKDIR \
    playbooks/dev-scripts.yml

