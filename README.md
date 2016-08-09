# <a name="title"></a> jmxtrans-cookbook  [![Build Status](https://drone.io/github.com/jkgentry/jmxtrans-cookbook/status.png)](https://drone.io/github.com/jkgentry/jmxtrans-cookbook/latest)

Notice
======
[ver-2.0](https://github.com/jmxtrans/jmxtrans-cookbook/tree/ver-2.0) branch of this cookbook uses the latest version of ``jmxtrans`` and is available for use.

- ``default`` recipe installs from tar.gz file
- ``ubuntu_install`` recipe for ``deb``
- ``centos_install`` recipe for ``rpm``
- ``remove_ver1`` to remove ``jmxtrans`` installed using the earlier version of this cookbook.

Description
===========

This repo is a Chef cookbook to install and configure JMXTrans and was originally
developed by [Bryan Berry](https://github.com/bryanwb/chef-jmxtrans). Thanks
Bryan!!. Since Bryan is no longer maintaining the original repo, this repo was
created with his permission and is maintained here.

[jmxtrans](https://github.com/lookfirst/jmxtrans) is an excellent tool
for transporting jmx data from your VMs and into a graphing tool like
graphite or ganglia. This cookbook only supports writing to graphite
but could be easily modified to work with ganglia

Requirements
============

* Depends on the ark cookbook
* JMXTrans is java based and Java need to be installed for it to start and
  run successfully. So `` java `` cookbook is suggested.

Attributes
==========

* `node['jmxtrans']['graphite']['host']` - defaults to 'graphite'
* `node['jmxtrans']['graphite']['port']` - default to 2003
* `node['jmxtrans']['servers']` - array of servers to query for jmx data
  along with the properties needed to access each one
* `node['jmxtrans']['root_prefix']` - root prefix for the graphite
  buckets, defaults to "jmx"

Usage
=====

You must override the attribute `node['jmxtrans']['servers']` with the
list of servers you want monitored and their respective properties

the following example comes from a role

```
:jmxtrans => {
   :servers =>[
      {
        'name' => 'foo1.example.org',
        'port' => "8999",
        'type' => 'tomcat',
        'username' => 'foobar',
        'password' => 'rw'
      },
      {
        'name' => 'foo2.example.org',
        'port' => "8999",
        'type' => 'tomcat',
        'username' => 'foobar',
        'password' => 'baz'
       }
     ]                                   
}
```

[chef-bach bcpc_jmxtrans cookbook](https://github.com/bloomberg/chef-bach/tree/c0eac24081d07a9b750ea75dcebb83e460313954/cookbooks/bcpc_jmxtrans) is an example of how this community cookbook can
be used using a wrapper cookbook.

Copyright
=========

Copyright 2015, [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either expressed or implied. See the license for the specific
language governing permissions and limitations under the license.

Contributing
============
1. Fork the repository on Github
2. Create a named feature branch (like add-component-x)
3. Make your code changes
4. Test that your changes work, for example with Vagrant
5. Submit a Pull Request using Github
