complete_wordpress
==================

Puppet module to easily install wordpress alongside required services and packages.

Currently been tested and works on:
1. Fedora 19
2. Centos 6.4

How to install
------

Installing the complete wordpress module is simple, run this command on your puppet master.

 ```bash
 puppet module install mwils/complete_wordpress 
 ```
 #### Other modules that are required
 
 completed wordpress also requires:
 1. puppetlabs/apache
 2. puppetlabs/mysql
 
#### for each module run this command
 ```bash
 puppet module install puppetlabs/<MODULE NAME> 
 ```
site.pp
------

Now in site.pp, we are going to start by using the puppetlabs/firewall class.

 ```perl
node 'MY-NODE' {
include complete_wordpress
  class { '::mysql::server':
   root_password => 'MY-ROOT-PASSWORD';
  }
 class { 'apache': }
 class {'apache::mod::php': }
 }
  
 ```
Notes
------
 We advise that you also download the puppetlabs/firewall module for security purposes.
