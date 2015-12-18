#
# Cookbook Name:: supervisord
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

easy_install_package 'supervisor'

cookbook_file '/etc/init.d/supervisord' do
  source 'supervisord'
  mode '0755'
  action :create
end

template "/etc/supervisord.conf" do
  path "/etc/supervisord.conf"
  source "supervisord.conf.erb"
  mode "0600"
  notifies :restart, "service[supervisord]"
end

service "supervisord" do
  supports :restart => true, :start => true, :stop => true
  action [:enable, :start]
end
