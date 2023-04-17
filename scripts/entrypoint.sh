#!/bin/bash
# active python3 virtual environment
. /venv/bin/activate

# Configure Ansible to use the ara callback plugin
export ANSIBLE_CALLBACK_PLUGINS="$(python3 -m ara.setup.callback_plugins)"

# Set up the ara callback to know where the API server is located
export ARA_API_CLIENT="http"
export ARA_API_SERVER="http://api-server:8000"

export PBR_VERSION=$(pip list | grep pbr|awk '{print $NF}')
cd /srv/pymodule && python setup.py install

cd /srv/ansible
exec $@
