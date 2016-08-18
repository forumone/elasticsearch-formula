# Include java dep (github.com/forumone/java-formula)
include:
  - java

# import ES repo key
#import-es-repo-key:
#  cmd.run:
#    - name: rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

es-yum-repo:
  pkgrepo.managed:
    - humanname: Elasticsearch repository for 2.x packages
    - baseurl: https://packages.elastic.co/elasticsearch/2.x/centos
    - gpgcheck: 1
    - gpgkey: https://packages.elastic.co/GPG-KEY-elasticsearch
    - disabled: False

install-elasticsearch:
  pkg.installed:
    - name: elasticsearch
  service.running:
    - name: elasticsearch
    - enable: True
    - require:
      - pkg: elasticsearch

modify-es-config-enable-cors:
  file.append:
    - name: /etc/elasticsearch/elasticsearch.yml
    - text: 
      - 'http.cors.enabled: true'
      - 'http.cors.allow-origin : "*"'
      - 'http.cors.allow-methods : OPTIONS, HEAD, GET, POST, PUT, DELETE'
      - 'http.cors.allow-headers : X-Requested-With,X-Auth-Token,Content-Type, Content-Length'
    - watch_in:
      - service: elasticsearch

modify-es-config-bind-host:
  file.append:
    - name: /etc/elasticsearch/elasticsearch.yml
    - text: "network.bind_host: 0.0.0.0"
    - watch_in:
      - service: elasticsearch
