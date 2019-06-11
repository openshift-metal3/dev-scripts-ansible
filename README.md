Metal³ Ansible installer
===============================

This set of playbooks provides an unattended installation of [dev-scripts](https://github.com/openshift-metal3/dev-scripts/) on a 
local or remote system.  THis is useful for automatic deployments, setting up a development environment, or demonstrating Metal³ 
complete with the [kubevirt/web-ui](https://github.com/kubevirt/web-ui).

This is very similar to how we do TripleO testing so we reuse some roles
from tripleo-quickstart here.

By default, this will deploy 'master' branches of each component, but can be modified given the options pointed out below.

# Pre-requisites

- CentOS 7.5 or greater (installed from 7.4 or newer)
- file system that supports d_type (see Troubleshooting section for more information)
- ideally on a bare metal host
- run as a user with passwordless sudo access
- get a valid pull secret (json string) from https://cloud.openshift.com/clusters/install#pull-secret

# Instructions

## Configuration

Edit group_vars/all.yml to your liking.  The only mandatory default is that of 'pull_secret'; these 
are necessary to properly pull down containers that are required for [dev-scripts](https://github.com/openshift-metal3/dev-scripts/)

Other notable options are:
-  rhhi_user
-  dev_scripts_dir
-  dev_scripts_refspec
-  web_ui_refspec
-  go_path

## Installation

For a new setup, run:

`./dev-scripts.sh <remote host>`

The script will run playbooks that each represents [dev-scripts](https://github.com/openshift-metal3/dev-scripts/) scripts.  The following
scripts will run in order:

- `01_install_requirements.sh`
- `02_configure_host.sh`
- `03_ocp_repo_sync.sh`
- `04_setup_ironic.sh`
- `06_create_cluster.sh`
- `08_deploy_bmo.sh`
- `11_register_hosts.sh`

An additional playbook will start [kubevirt/web-ui](https://github.com/kubevirt/web-ui), both with 
the authentication bridge and the Yarn development server.

The deployment is idempotent; it can be re-ran against a system which already has a [dev-scripts](https://github.com/openshift-metal3/dev-scripts/) 
deployment on it.  The previous [dev-scripts](https://github.com/openshift-metal3/dev-scripts/) deployment will be `make clean`'ed and a 
new deployment will be made.
