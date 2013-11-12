# == Class: brightwp
#
# Full description of class brightwp here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { brightwp:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class complete_wordpress {
 mysql::db { 'wordpress':
  user     => 'admin',
  password => 'Bergun21',
  host     => 'localhost',
  grant    => ['SELECT', 'UPDATE', 'INSERT'],
    }
 exec { 'notify me':
  command => 'echo Wordpress will be installed',
  path => '/bin',
  creates => '/var/www/html/wordpress',
  notify => [Exec['wordpress-download','wordpress-extract','remove-wp-latest-zip'],File['/var/www/html/wordpress/wp-config.php']],
 }
 package { 'wget':
   ensure => present,
   before => Exec['wordpress-download'],
 }
 package { 'wordpress':
   ensure => present,
   before => Exec['wordpress-download'],
 }
 package { 'zip': 
   ensure => present,
   before => Exec['wordpress-extract'],
 }
 package { 'unzip':
  ensure => present,
  before => Exec['wordpress-extract'],
 }
 exec {'wordpress-download': 
  command => 'wget http://wordpress.org/latest.zip',
  path => '/usr/bin/',
  cwd => '/var/www/html/',
  creates => '/var/www/html/latest.zip',
  refreshonly => true,
 }
 exec { 'wordpress-extract': 
  command => 'unzip latest.zip',
  path => '/usr/bin/',
  cwd => '/var/www/html/',
  require => Exec['wordpress-download'],
  creates => '/var/www/html/wordpress', 
 }
 exec { 'remove-wp-latest-zip':
  command => 'rm -rf latest.zip',
  path => '/bin/',
  cwd => '/var/www/html/',
  require => Exec['wordpress-extract'],
  refreshonly => true,
 }
 file { '/var/www/html/wordpress/wp-config.php':
  owner =>   root,
  group =>   root,
  source => "puppet:///modules/brightwp/wp-config.php",
  require => Exec['wordpress-extract']
 }
}
