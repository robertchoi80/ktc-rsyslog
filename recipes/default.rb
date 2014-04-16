#
# Cookbook Name:: ktc-rsyslog
# Recipe:: default
#
include_recipe 'ktc-rsyslog::setup'
include_recipe 'ktc-rsyslog::logrotate'
include_recipe 'ktc-rsyslog::check_procs'
