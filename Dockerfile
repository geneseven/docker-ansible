FROM ubuntu:latest

ARG USER

COPY src/config/ssh_config /root/.ssh/config
COPY src/config/krb5.conf /etc/krb5.conf
COPY src/config/ansible.cfg /root/.ansible.cfg
COPY bin/* /
COPY /plugins/actions /plugins/actions
COPY /plugins/modules /plugins/modules
RUN chown root.root /root/.ssh/config

RUN apt-get update -qy && \
    apt install python3-pip vim sshpass -qy && \
    pip install --upgrade pip && \
    pip install virtualenv && \
    virtualenv /venv && \
    . /venv/bin/activate && \
    pip install gspread==5.7.1 PyMySQL==1.0.2 ansible==7.0.0a2 "ara[server]"

RUN sed -i -e "s/<USER>/$USER/g" /root/.ssh/config

COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod u+x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
