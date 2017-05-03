include:
  - elasticsearch.service

{%- if elasticsearch.major_version == 5 %}
/etc/security/limits.d/99-elasticsearch.conf:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - contents: "elasticsearch    soft    nproc  2048"
    - watch_in:
      - service: elasticsearch
{% endif -%}
