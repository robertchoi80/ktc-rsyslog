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
    logstash_server = search(:node, "role:log-server").first['fqdn'] rescue nil
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
  notifies :create, "ruby_block[edit-etc-hosts]", :immediately
end

ruby_block 'edit-etc-hosts' do
  block do
    loopback_line = "127.0.0.1 #{node['fqdn']} localhost"

    conf_file = Chef::Util::FileEdit.new("/etc/hosts")
    conf_file.search_file_replace_line(/127\.0\.0\.1/, loopback_line)
    conf_file.write_file

    system('touch /var/lock/.edit_etc_hosts_done')
  end
  action :nothing
  notifies :restart, "service[rsyslog]", :immediately
  not_if "test -f /var/lock/.edit_etc_hosts_done"
end
