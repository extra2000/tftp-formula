# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import TFTP with context %}

tftpd-container-dead:
  cmd.run:
    - name: podman pod rm --force tftp-pod
    - runas: {{ TFTP.hostuser.name }}
