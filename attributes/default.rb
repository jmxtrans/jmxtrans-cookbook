default['jmxtrans']['install_prefix'] = '/opt'
#
# Note that deb and rpm will install software as per standards
# and the install_prefix attribute is applicable only for installation
# using the tar.gz file provided by jmxtrans.
#
default['jmxtrans']['java_home'] = nil
default['jmxtrans']['home'] = "#{default['jmxtrans']['install_prefix']}/jmxtrans"
default['jmxtrans']['json_dir'] = "#{default['jmxtrans']['home']}/json"
#
# Note: for deb and rpm installation the json directory will be /var/lib/jmxtrans
# the json_dir attribute is applicable only for installation using tar.gz
#
default['jmxtrans']['log_dir'] = '/var/log/jmxtrans'
default['jmxtrans']['version'] = '250'
default['jmxtrans']['user'] = 'jmxtrans'
default['jmxtrans']['url'] = "http://central.maven.org/maven2/org/jmxtrans/jmxtrans/#{default['jmxtrans']['version']}"
default['jmxtrans']['checksum'] = '0a5a2c361cc666f5a7174e2c77809e1a973c3af62868d407c68beb892f1b0217'
default['jmxtrans']['heap_size'] = '512'
default['jmxtrans']['run_interval'] = '60'
default['jmxtrans']['log_level'] = 'debug'
default['jmxtrans']['graphite']['host'] = 'graphite'
default['jmxtrans']['graphite']['port'] = '2003'

default['jmxtrans']['servers'] = []
#
# Example servers attribute set-up
#
#default['jmxtrans']['servers'] = [
#	{ "name" => "10.0.100.14",
#	  "port" => "9999",
#	  "type" => "kafka",
#	  "usermame" => "xxxx",
#	  "password" => "yyyy"
#	},
#	{ "name" => "10.0.100.14",
#	  "port" => "9999",
#	  "type" => "tomcat",
#	  "usermame" => "xxxx",
#	  "password" => "yyyy"
#	}
#]
default['jmxtrans']['root_prefix'] = "jmx"
default['jmxtrans']['default_queries'] = {
  'jvm' => [
            {
              "result_alias" => "memory",
              "obj" => "java.lang:type=Memory",
              "attr" => [ "HeapMemoryUsage", "NonHeapMemoryUsage" ]
            },
            {
              "result_alias" => "memorypool",
              "obj" => "java.lang:type=MemoryPool,name=*",
              "attr" => [ "Usage" ]
            },
            {
              "result_alias" => "gc",
              "obj" => "java.lang:type=GarbageCollector,name=*",
              "attr" => [ "CollectionCount", "CollectionTime" ]
            },
            {
            "result_alias" => "threads",
            "obj" => "java.lang:type=Threading",
            "attr" => [
                       "DaemonThreadCount",
                       "PeakThreadCount",
                       "ThreadCount",
                       "TotalStartedThreadCount"
                      ]
            }
           ],
  'tomcat' => [
               {
                 'obj' => "Catalina:type=ThreadPool,name=*",
                 'result_alias' => "connectors",
                 'attr' => [ "currentThreadCount", "currentThreadsBusy", "" ]
               },
               {
                 'obj' => "Catalina:type=GlobalRequestProcessor,name=*",
                 'result_alias' => "requests",
                 'attr' => [ "bytesReceived", "bytesSent", "errorCount", "maxTime", "processingTime", "requestCount" ]
               },
               {  "obj" => "Catalina:type=DataSource,class=javax.sql.DataSource,name=*",
                 "result_alias" => "datasources",
                 "attr" => [ "NumActive", "NumIdle", "NumQueryThreads" ]
               }
              ]
}
