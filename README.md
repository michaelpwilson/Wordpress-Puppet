complete_wordpress
==================

Puppet module to easily install wordpress alongside required services and packages.

Currently been tested and works on: Fedora 19 & Centos 6.4

View this project on puppet forge:
http://forge.puppetlabs.com/mwils/complete_wordpress

How to install
------

Installing the complete wordpress module is simple, run this command on your puppet master.

 ```bash
 puppet module install mwils/complete_wordpress 
 ```
 
 completed wordpress also requires:
 1. puppetlabs/apache
 2. puppetlabs/mysql
 

#### for each module run this command
 
```bash
 puppet module install puppetlabs/<MODULE NAME> 
 ```

site.pp
------

Now in site.pp include this snippet for a node and change ```MY-ROOT-PASSWORD``` and ```MY-NODE``` to the settings you would like to have.


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

Customization of manifest/init.pp
---------------------------------

The init.pp file creates the wordpress database, so you can change the details of the database creation there.

notes
-----

We advise that you also download the puppetlabs/firewall module for security purposes.
