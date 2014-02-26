name              "ktc-rsyslog"
maintainer        "Robert Choi"
maintainer_email  "taeilchoi1@gmail.com"
license           "Apache 2.0"
description       "Add configs for sending logs to central logstash server"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.13'

recipe            "default", "Add configs for sending logs to central logstash server"

supports          "ubuntu", ">= 8.04"
supports          "debian", ">= 5.0"
supports          "fedora"
supports          "centos"
supports          "redhat"

depends           "rsyslog"
depends           "hostsfile", ">= 2.4.1"
depends           "ktc-monitor"
