# == Class: Complete Wordpress
#
# This class is used to create a mysql database, download the latest tarball directly from Wordpress. Then extract it into your html directory.
#
# === Requirements
#
# mysql module = puppet module install puppetlabs/mysql
# http://forge.puppetlabs.com/puppetlabs/mysql
# 
# -----------------------------------------------------
#
# apache module = puppet module install puppetlabs/apache
# http://forge.puppetlabs.com/puppetlabs/apache
#
# === Authors
#
# Michael Wilson michaelpwilson96@gmail.com <mwils@brightprocess.com>
#
# All other modules used have been created by puppetlabs.
#
# === Copyright
#
# Copyright 2013 Michael P Wilson
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
  source => "puppet:///modules/complete_wordpress/wp-config.php",
  require => Exec['wordpress-extract']
 }
}
