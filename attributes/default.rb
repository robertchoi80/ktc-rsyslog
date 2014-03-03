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

include_attribute 'rsyslog'

default['rsyslog']['logstash_server'] = nil
default['rsyslog']['logstash_server_port'] = '5514'
default['rsyslog']['protocol'] = 'tcp'
default['rsyslog']['logstash_recipe'] = 'ktc-logging\\:\\:server_logstash'
default['rsyslog']['preserve_fqdn'] = 'on'
default['rsyslog']['version'] = '5.8.6-1ubuntu8.5'

# Logging options
default['rsyslog']['disable_local_log'] = false
default['rsyslog']['separate_logs'] = true
default['rsyslog']['include_dmesg'] = true

# Facility names used in logging.conf
default['rsyslog']['nova_facility'] = 'LOG_LOCAL2'
default['rsyslog']['cinder_facility'] = 'LOG_LOCAL3'
default['rsyslog']['quantum_facility'] = 'LOG_LOCAL4'
default['rsyslog']['glance_facility'] = 'LOG_LOCAL5'
default['rsyslog']['keystone_facility'] = 'LOG_LOCAL6'

# Facility names used in syslog config
default['rsyslog']['nova_config_facility'] = 'local2'
default['rsyslog']['cinder_config_facility'] = 'local3'
default['rsyslog']['quantum_config_facility'] = 'local4'
default['rsyslog']['glance_config_facility'] = 'local5'
default['rsyslog']['keystone_config_facility'] = 'local6'

# Queue config
default['rsyslog']['queue']['type'] = 'LinkedList'
default['rsyslog']['queue']['file_name'] = 'syslog_disk_queue'
default['rsyslog']['queue']['max_disk_space'] = '10g'

# process monitoring
default['rsyslog']['processes'] = [
  { 'name' => 'rsyslogd', 'shortname' => 'rsyslogd' }
]
