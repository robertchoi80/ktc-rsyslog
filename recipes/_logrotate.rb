#
# Cookbook Name:: ktc-rsyslog
# Recipe:: logrotate
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

include_recipe 'logrotate'

logrotate_app 'openstack-logs' do
  path '/var/log/openstack/*.log'
  frequency nil
  rotate 4
  size '100M'
  create '640 syslog adm'
  sharedscripts true
  postrotate "\treload rsyslog >/dev/null 2>&1 || true"
end
