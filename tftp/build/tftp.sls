# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import TFTP with context %}

build-tftp-podman-image:
  cmd.run:
    - name: podman build -t {{ TFTP.image.name }} .
    - cwd: /opt/tftp/src
    - runas: {{ TFTP.hostuser.name }}
