#
# Cookbook Name:: jmxtrans
# Recipe:: remove_ver1
#
# If version 1 of the cookbook was used to install with the default
# attributes, this recipe can be used to remove before installing
# using the latest version of the cookbook
#
# Copyright 2015, Biju Nair & Contributors  
#
# Apache 2.0 license
#

service "jmxtrans" do
  supports :restart => true, :status => true, :reload => true
  action [ :stop]
end

directory node['jmxtrans']['json_dir'] do
  action :delete
  recursive true
end

directory node['jmxtrans']['log_dir'] do
  action :delete
  recursive true
end

directory node['jmxtrans']['home'] do
  action :delete
  recursive true
end

file '/etc/init.d/jmxtrans' do
  action :delete
end

file '/etc/default/jmxtrans' do
  action :delete
end
