#
# Cookbook Name:: ktc-rsyslog
# Recipe:: default
#
include_recipe 'ktc-rsyslog::_setup'
include_recipe 'ktc-rsyslog::_logrotate'
include_recipe 'ktc-rsyslog::_check_procs'
