export OPT_WORKDIR=${OPT_WORKDIR:=$HOME/.rhhi}

#ssh config
export SSH_CONFIG=${SSH_CONFIG=$OPT_WORKDIR/ssh.config.ansible}
#make sure ssh config exists
touch $SSH_CONFIG
export ANSIBLE_SSH_ARGS=${ANSIBLE_SSH_ARGS="-F ${SSH_CONFIG}"}

