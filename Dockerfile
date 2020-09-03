# FROM alpine:latest

# ENV LANG en_US.UTF-8

# RUN echo "root:root" | chpasswd \
#     && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
#     && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
#     && apk update \
#     && apk add --no-cache openconnect openvpn openssh && mkdir ${HOME}/.ssh

# CMD ["sh", "-c", "echo \"${SSH_KEY}\" > ~/.ssh/authorized_keys && ssh-keygen -A && /usr/sbin/sshd && sh"]

# ADD . /code
# WORKDIR /code

# RUN pip install -r requirements.txt
# CMD ["python", "webssh/main.py"]

# FROM ubuntu:latest


# ENV DEBIAN_FRONTEND=noninteractive \

# ADD requirements.txt /root/requirements.txt
# RUN export
# RUN pip install -r requirements.txt

# ENTRYPOINT /bin/bash
# #ENTRYPOINT cd /root/device_shadow_framework && \
# #	python3 manage.py collectstatic --noinput && \
# #	python3 manage.py zenmigrate -i && \
# #	python3 manage.py makemigrations && \
# #	python3 manage.py migrate && \
# #	python3 manage.py loaddata initial_data && \
# #	echo "from zenauth.models import ZenatixUser; ZenatixUser.objects.filter(email='DEVICE_SHADOW_FRAMEWORK_SU_EMAIL').delete(); ZenatixUser.objects.create_superuser('admin', 'DEVICE_SHADOW_FRAMEWORK_SU_EMAIL', 'DEVICE_SHADOW_FRAMEWORK_SU_PASS')" | python3 manage.py shell && \
# #	python3 manage.py runserver 0.0.0.0:9107

# EXPOSE 5555 8070 8071 8080 8888 8889

FROM python:2.7.10-slim

RUN apt-get update && \
    apt-get dist-upgrade --yes && \
    apt-get install -y openconnect openvpn openssh-server && mkdir ${HOME}/.ssh && \
    apt-get autoremove -y && apt-get clean -y && \
    pip install --upgrade pip && \
    rm -rf /var/lib/apt/lists/*

ADD requirements.txt /root/requirements.txt
RUN pip install --no-cache-dir -r /root/requirements.txt

ADD . /root/code

RUN ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa && chmod 744 ~/.ssh
