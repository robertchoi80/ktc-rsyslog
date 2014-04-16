#
# Cookbook Name:: ktc-rsyslog
# Recipe:: setup
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

chef_gem 'chef-rewind'
require 'chef/rewind'

include_recipe 'rsyslog::default'
include_recipe 'services'

rewind package: 'rsyslog' do
  version node['rsyslog']['version']
  options '--force-yes'
end

rewind template: '/etc/rsyslog.d/50-default.conf' do
  source '50-default-new.conf.erb'
  cookbook_name 'ktc-rsyslog'
end

unless node['rsyslog']['server']
  if node['rsyslog']['logstash_server'].nil?
    endpoint = Services::Endpoint.new 'logstash-server'
    endpoint.load
    logstash_server = endpoint.ip
  else
    logstash_server = node['rsyslog']['logstash_server']
  end
end

template '/etc/rsyslog.d/91-logstash.conf' do
  source '91-logstash.conf.erb'
  backup false
  variables(
    server: logstash_server,
    protocol: node['rsyslog']['protocol']
  )
  owner 'root'
  group 'root'
  mode 0644
  not_if { logstash_server.nil? }
end
