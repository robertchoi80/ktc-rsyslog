#
# Cookbook Name:: ktc-rsyslog
# Recipe:: default
#
# Copyright 2013, Robert Choi.
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

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe "rsyslog::default"

rewind :template => "/etc/rsyslog.d/50-default.conf" do
  source "50-default-new.conf.erb"
  cookbook_name "ktc-rsyslog"
end

unless node['rsyslog']['server']
  if node['rsyslog']['logstash_server'].nil?
    logstash_server = search(:node,
      "recipes:#{node['rsyslog']['logstash_recipe']}").first['fqdn'] rescue nil
  else
    logstash_server = node['rsyslog']['logstash_server']
  end
end

template "/etc/rsyslog.d/91-logstash.conf" do
  source "91-logstash.conf.erb"
  backup false
  variables(
    :server => logstash_server,
    :protocol => node['rsyslog']['protocol']
  )
  owner "root"
  group "root"
  mode 0644
  not_if { logstash_server.nil? }
end

# we use this to know if the monitors shoudl be registered
monitor_loaded = node.run_context.loaded_recipe? "ktc-monitor::client"

# process monitoring and sensu-check config
processes = node['rsyslog']['processes']

processes.each do |process|
  sensu_check "check_process_#{process['name']}" do
    command "check-procs.rb -c 10 -w 10 -C 1 -W 1 -p #{process['name']}"
    handlers ["default"]
    standalone true
    interval 30
    only_if { monitor_loaded }
  end
end

ktc_collectd_processes "rsyslog-processes" do
  input processes
  only_if { monitor_loaded }
end
