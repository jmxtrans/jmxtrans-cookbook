#
# Cookbook Name:: jmxtrans
# Recipe:: default
#
# Copyright 2015, Biju Nair & Contributors
#
# Apache 2.0 license
#

# include_recipe 'ark'

# if platform_family?('debian')
#     init_script_file = 'jmxtrans.init.deb.erb'
# elsif platform_family?('rhel')
#     init_script_file = 'jmxtrans.init.el.erb'
# end

# user node['jmxtrans']['user']

# merge stock jvm queries w/ container specific ones into single array

#
# Changes for issue #13 & 14
#
# servers = node['jmxtrans']['servers'].dup
# servers.each do |server|
#     server['queries'] = [] unless server.key?('queries')
#     server['queries'] << node['jmxtrans']['default_queries']['jvm']
#     #
#     # Case statement was replaced for enhancement in issue #16
#     #
#     server['queries'] << node['jmxtrans']['default_queries'][server['type']]
#     server['queries'].flatten!
# end

case node['platform_family']
when 'debian'
    # init_script_file = 'jmxtrans.init.deb.erb'
when 'rhel'
    remote_file "#{Chef::Config[:file_cache_path]}/jmxtrans.rpm" do
        source 'http://central.maven.org/maven2/org/jmxtrans/jmxtrans/254/jmxtrans-254.rpm'
        action :create
    end

    rpm_package 'jmxtrans' do
        source "#{Chef::Config[:file_cache_path]}/jmxtrans.rpm"
        action :install
        allow_downgrade true
    end
end

# ark 'jmxtrans' do
#     url node['jmxtrans']['url']
#     checksum node['jmxtrans']['checksum']
#     version 'latest'
#     prefix_root '/opt'
#     prefix_home '/opt'
#     owner node['jmxtrans']['user']
#     group node['jmxtrans']['user']
# end
#
# New resource to change the mode of jmxtrans.sh so that service can
# start successfully. Issue #17
#
# file "#{node['jmxtrans']['home']}/jmxtrans.sh" do
#     mode '0755'
#     action :touch
# end

# template '/etc/init.d/jmxtrans' do
#     source init_script_file
#     owner 'root'
#     group 'root'
#     mode  '0755'
#     variables(name: 'jmxtrans')
#     notifies :restart, 'service[jmxtrans]', :delayed
# end

# template '/etc/default/jmxtrans' do
#     source 'jmxtrans_default.erb'
#     owner 'root'
#     group 'root'
#     mode  '0644'
#     notifies :restart, 'service[jmxtrans]', :delayed
# end
#
# directory node['jmxtrans']['log_dir'] do
#     owner node['jmxtrans']['user']
#     group node['jmxtrans']['user']
#     mode  '0755'
# end
#
# directory node['jmxtrans']['json_dir'] do
#     owner node['jmxtrans']['user']
#     group node['jmxtrans']['user']
#     mode  '0755'
# end

template "#{node['jmxtrans']['json_dir']}/set1.json" do
    source 'set1.json.erb'
    owner node['jmxtrans']['user']
    group node['jmxtrans']['user']
    mode  '0755'
    notifies :restart, 'service[jmxtrans]', :delayed
    variables(
        servers: node['jmxtrans']['servers']
    )
end

# package 'gzip'
#
# cron 'compress and remove logs rotated by log4j' do
#     minute '0'
#     hour '0'
#     command "find #{node['jmxtrans']['log_dir']}/ -name '*.gz' -mtime +30 -exec rm -f '{}' \\; ; \
#     find #{node['jmxtrans']['log_dir']} ! -name '*.gz' -mtime +2 -exec gzip '{}' \\;"
# end

service 'jmxtrans' do
    supports restart: true, status: true, reload: true
    action [:enable, :start]
end
