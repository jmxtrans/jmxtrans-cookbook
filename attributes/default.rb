# default['jmxtrans']['install_prefix'] = '/opt'
# default['jmxtrans']['java_home'] = '/usr/bin/java'
# default['jmxtrans']['home'] = "#{default['jmxtrans']['install_prefix']}/jmxtrans"
default['jmxtrans']['json_dir'] = '/var/lib/jmxtrans'
# default['jmxtrans']['log_dir'] = '/var/log/jmxtrans'
# default['jmxtrans']['user'] = 'jmxtrans'
# default['jmxtrans']['url'] = 'https://github.com/downloads/jmxtrans/jmxtrans/jmxtrans-20120525-210643-4e956b1144.zip'
# default['jmxtrans']['checksum'] = '0a5a2c361cc666f5a7174e2c77809e1a973c3af62868d407c68beb892f1b0217'
# default['jmxtrans']['heap_size'] = '512'
# default['jmxtrans']['jmxtrans_opts'] = nil
default['jmxtrans']['run_interval'] = '60'
default['jmxtrans']['log_level'] = 'debug'
# default['jmxtrans']['graphite']['host'] = 'graphite'
# default['jmxtrans']['graphite']['port'] = '2003'

# default['jmxtrans']['servers'] = []
#
# Example servers attribute set-up
#
# default['jmxtrans']['servers'] = [
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
# ]

default['jmxtrans']['servers'] = [
    {
        'host' => 'localhost',
        'port' => 1090,
        'type' => 'test',
        'username' => 'xxx',
        'password' => 'sss',
        'queries' => [
            'obj' => 'test',
            'attr' => %w(something something),
            'output_writers' => [
                'class' => 'com.googlecode.jmxtrans.model.output.elastic.ElasticWriter',
                'connectionUrl' => 'http://elasticsearch-sndbx.hq.target.com:9200',
                'rootPrefix' => 'sdm'
            ]
        ]
    }
]
# default['jmxtrans']['root_prefix'] = 'test'
# default['jmxtrans']['default_queries'] = {
#     'jvm' => [
#         {
#             'result_alias' => 'memory',
#             'obj' => 'java.lang:type=Memory',
#             'attr' => %w(HeapMemoryUsage NonHeapMemoryUsage)
#         },
#         {
#             'result_alias' => 'memorypool',
#             'obj' => 'java.lang:type=MemoryPool,name=*',
#             'attr' => ['Usage']
#         },
#         {
#             'result_alias' => 'gc',
#             'obj' => 'java.lang:type=GarbageCollector,name=*',
#             'attr' => %w(CollectionCount CollectionTime)
#         },
#         {
#             'result_alias' => 'threads',
#             'obj' => 'java.lang:type=Threading',
#             'attr' => %w(
#                 DaemonThreadCount
#                 PeakThreadCount
#                 ThreadCount
#                 TotalStartedThreadCount)
#         }
#     ],
#     'tomcat' => [
#         {
#             'obj' => 'Catalina:type=ThreadPool,name=*',
#             'result_alias' => 'connectors',
#             'attr' => ['currentThreadCount', 'currentThreadsBusy', '']
#         },
#         {
#             'obj' => 'Catalina:type=GlobalRequestProcessor,name=*',
#             'result_alias' => 'requests',
#             'attr' => %w(bytesReceived bytesSent errorCount maxTime processingTime requestCount)
#         },
#         { 'obj' => 'Catalina:type=DataSource,class=javax.sql.DataSource,name=*',
#           'result_alias' => 'datasources',
#           'attr' => %w(NumActive NumIdle NumQueryThreads)
#         }
#     ]
# }
