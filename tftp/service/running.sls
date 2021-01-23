# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import TFTP with context %}

tftpd-container-running:
  cmd.run:
    - name: podman play kube --network=tftp tftp-pod.yaml
    - cwd: /opt/tftp
    - runas: {{ TFTP.hostuser.name }}
