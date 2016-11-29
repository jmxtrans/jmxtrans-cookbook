#
# Cookbook Name:: jmxtrans
# Recipe:: ubuntu-install.rb
#
# Install jmxtrans on Ubuntu using deb package
#
# Copyright 2015, Biju Nair & Contributors  
#
# Apache 2.0 license
#

servers = node['jmxtrans']['servers'].dup
servers.each do |server|
 if !server.key?('queries')
  server['queries'] = []
 end
 server['queries'] << node['jmxtrans']['default_queries']['jvm']
 server['queries'] << node['jmxtrans']['default_queries'][server['type']]
 server['queries'].flatten!
end

remote_file "#{Chef::Config[:file_cache_path]}/jmxtrans-#{node['jmxtrans']['version']}.deb" do
  source "#{node['jmxtrans']['url']}/jmxtrans-#{node['jmxtrans']['version']}.deb"
  #checksum "http://central.maven.org/maven2/org/jmxtrans/jmxtrans/#{node['jmxtrans']['version']}/jmxtrans-#{node['jmxtrans']['version']}.deb.sha1"
  action :create_if_missing
end

dpkg_package "jmxtrans-#{node['jmxtrans']['version']}" do
  action :upgrade
  source "#{Chef::Config[:file_cache_path]}/jmxtrans-#{node['jmxtrans']['version']}.deb"
end

user node['jmxtrans']['user']

template "/etc/default/jmxtrans" do
  source "jmxtrans_default.erb"
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[jmxtrans]", :delayed
end

directory node['jmxtrans']['log_dir'] do
  owner node['jmxtrans']['user']
  group node['jmxtrans']['user']
  mode  "0755"
end

node.override['jmxtrans']['json_dir'] = "/var/lib/jmxtrans"

directory node['jmxtrans']['json_dir'] do
  owner node['jmxtrans']['user']
  group node['jmxtrans']['user']
  mode  "0755"
end

template "#{node['jmxtrans']['json_dir']}/set1.json" do
  source "set1.json.erb"
  owner node['jmxtrans']['user']
  group node['jmxtrans']['user']
  mode  "0755"
  notifies :restart, "service[jmxtrans]", :delayed
  variables(
            :servers => servers,
            :graphite_host => node['jmxtrans']['graphite']['host'],
            :graphite_port => node['jmxtrans']['graphite']['port'],
            :root_prefix => node['jmxtrans']['root_prefix']
            )
end

package 'gzip'

cron "compress and remove logs rotated by log4j" do
  minute "0"
  hour   "0"
  command  "find #{node['jmxtrans']['log_dir']}/ -name '*.gz' -mtime +30 -exec rm -f '{}' \\; ; \
  find #{node['jmxtrans']['log_dir']} ! -name '*.gz' -mtime +2 -exec gzip '{}' \\;"
end

service "jmxtrans" do
  supports :restart => true, :status => true, :reload => true
  action [ :enable, :start]
end

