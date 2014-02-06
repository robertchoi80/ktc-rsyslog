#
# Cookbook Name:: ktc-rsyslog
# Attributes:: default
#
# Copyright 2013, Robert Choi
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_attribute "rsyslog"

default['rsyslog']['logstash_server'] = nil
default['rsyslog']['logstash_server_port'] = '5514'
default['rsyslog']['protocol'] = 'tcp'
default['rsyslog']['disable_local_log'] = false
default['rsyslog']['include_dmesg'] = true
default['rsyslog']['logstash_recipe'] = 'ktc-logging\\:\\:server_logstash'
default['rsyslog']['preserve_fqdn'] = 'on'

default['rsyslog']['queue']['type'] = 'LinkedList'
default['rsyslog']['queue']['file_name'] = 'syslog_disk_queue'
default['rsyslog']['queue']['max_disk_space'] = '10g'

# process monitoring
default["rsyslog"]["processes"] = [
  { "name" => "rsyslogd", "shortname" => "rsyslogd" }
]
