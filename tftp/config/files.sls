# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import TFTP with context %}

/opt/tftp:
  file.directory:
    - user: {{ TFTP.hostuser.name }}
    - group: {{ TFTP.hostuser.group }}

/home/{{ TFTP.hostuser.name }}/.config/cni/net.d:
  file.directory:
    - user: {{ TFTP.hostuser.name }}
    - group: {{ TFTP.hostuser.group }}
    - makedirs: true

/home/{{ TFTP.hostuser.name }}/.config/cni/net.d/podman-network-tftp.conflist:
  file.managed:
    - source: salt://tftp/files/podman-network-tftp.conflist.jinja
    - user: {{ TFTP.hostuser.name }}
    - group: {{ TFTP.hostuser.group }}
    - template: jinja
    - context:
      pod: {{ TFTP.pod }}

/opt/tftp/tftp-pod.yaml:
  file.managed:
    - source: salt://tftp/files/tftp-pod.yaml
    - user: {{ TFTP.hostuser.name }}
    - group: {{ TFTP.hostuser.group }}
    - template: jinja
    - context:
      image: {{ TFTP.image }}
      resources: {{ TFTP.resources }}
      port: {{ TFTP.port }}

/opt/tftp/src:
  file.recurse:
    - source: salt://tftp/files/tftp-hpa-podman
    - user: {{ TFTP.hostuser.name }}
    - group: {{ TFTP.hostuser.group }}
    - show_changes: false

/opt/tftp/pxelinux.cfg:
  file.recurse:
    - source: salt://tftp/files/pxelinux.cfg
    - user: {{ TFTP.hostuser.name }}
    - group: {{ TFTP.hostuser.group }}
    - template: jinja
    - show_changes: false
